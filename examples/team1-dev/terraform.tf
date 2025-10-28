provider "vault" {
  address = "https://sample-cluster-public-vault-db854a77.7f7cc99c.z1.hashicorp.cloud:8200"
  token   = var.vault_token
}

variable "vault_token" {
  type = string
}
