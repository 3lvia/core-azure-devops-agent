# azure-devops-agent
Scripts to set up an azure devops docker agent

## to add new agents
Create secret.yaml with a token from Azure Devops with permission "Agent pool (read+manage)".
Create azuredevopsagent.yaml.
Run
```
kubectl deploy -f secret.yaml
kubectl deploy -f azuredevopsagent.yaml
```
