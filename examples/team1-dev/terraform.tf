provider "vault" {
  address = var.vault_address
  token   = var.vault_token
}

variable "vault_token" {
  type = string
}

variable "vault_address" {
  type = string
}