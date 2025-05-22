crossplane-init() {
    if [[ ! "$(pwd)" =~ "crossplane/.*-ionoscloud" ]]; then {
        echo "error: command should only be used within ionoscloud crossplane providers folders" > /dev/stderr
        return
    } fi

    PROJECT_NAME=$1
    if [ -z "$PROJECT_NAME" ]; then {
        echo "error: command should follow the format: $0 <project_name>" > /dev/stderr
        return
    } fi

    echo -e "Creating kind cluster"
	kind create cluster --name=$PROJECT_NAME-dev
	kubectl cluster-info --context kind-$PROJECT_NAME-dev
	kubectl config use-context kind-$PROJECT_NAME-dev
	echo -e "\nCreating namespace crossplane-system"
	kubectl create namespace crossplane-system
	echo -e "\nSetting current context namespace to crossplane-system"
	kubectl config set-context --current --namespace=crossplane-system
	echo -e "\nInstalling Crossplane CRDs"
	helm install crossplane --namespace crossplane-system crossplane-stable/crossplane
	echo -r "\nInstalling Provider IONOS Cloud CRDs"
	kubectl apply -R -f package/crds
	echo -r "\nCreating secret for IONOS Cloud provider"
	kubectl create secret generic --namespace crossplane-system example-provider-secret --from-literal=credentials="{\"token\":\"${IONOS_TOKEN}\",\"user\":\"${IONOS_USERNAME}\",\"password\":\"${BASE64_PW}\",\"s3_access_key\":\"${IONOS_S3_ACCESS_KEY}\",\"s3_secret_key\":\"${IONOS_S3_SECRET_KEY}\"}"
	echo -e "\nInstalling IONOS Cloud provider config"
	kubectl apply -f examples/provider/config.yaml
	echo -e "\nStarting Provider IONOS Cloud controllers"
	go run cmd/provider/main.go --debug
}
