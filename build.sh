version='1.1.0'
az login 
az acr login --name containerregistryelvia
docker build -t azuredevopsagent:$version .
docker tag azuredevopsagent:$version containerregistryelvia.azurecr.io/azuredevopsagent:$version
docker push containerregistryelvia.azurecr.io/azuredevopsagent:$version
# kubectl apply -f secret_azuredevopsagentelvia.yaml
kubectl apply -f azuredevopsagentelvia.yaml




# kubectl rollout restart statefulset azuredevopsagentelvia
# kubectl rollout restart statefulset azuredevopsagenthafslund
