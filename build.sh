version='1.0.0'
az login 
az acr login --name containerregistryprod
docker build -t azuredevopsagent:$version .
docker tag azuredevopsagent:$version containerregistryprod.azurecr.io/azuredevopsagent:$version
docker push containerregistryprod.azurecr.io/azuredevopsagent:$version
kubectl apply -f secret_azuredevopsagentelvia.yaml
kubectl apply -f secret_azuredevopsagenthafslund.yaml
kubectl apply -f azuredevopsagentelvia.yaml
kubectl apply -f azuredevopsagenthafslund.yaml




# kubectl rollout restart statefulset azuredevopsagentelvia
# kubectl rollout restart statefulset azuredevopsagenthafslund
