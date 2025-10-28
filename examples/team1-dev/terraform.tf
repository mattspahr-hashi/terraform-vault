provider "vault" {
  address = "http://127.0.0.1:8200"
  token   = var.vault_token
}

variable "vault_token" {
  type = string
}

variable "vault_address" {
  type = string
}