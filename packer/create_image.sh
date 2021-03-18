export ARM_CLIENT_ID= # sp-terraform-core-dev
export ARM_CLIENT_SECRET=<secret>
export ARM_SUBSCRIPTION_ID=93c9a48f-6fc4-46b4-b1b9-10b6cc422f76 # core-devtest
export ARM_TENANT_ID=2186a6ec-c227-4291-9806-d95340bf439d
export ARM_RESOURCE_GROUP=CORE-RGDEV
export ARM_STORAGE_ACCOUNT=elviaootagenttmp
export ARM_RESOURCE_LOCATION=westeurope

packer build ubuntu2004.json
