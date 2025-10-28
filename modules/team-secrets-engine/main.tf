terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "~> 3.10"
    }
  }
}

# Configure the Vault provider with empty configuration
# The actual configuration should be provided by the module caller
provider "vault" {}

# Input variables
variable "team_name" {
  type        = string
  description = "Name of the team that will own this secrets engine"
}

variable "service_name" {
  type        = string
  description = "Name of the service that will own this secrets engine"
}

variable "environment" {
  type        = string
  description = "Environment (e.g., dev, staging, prod)"
  default     = "dev"
}

variable "kv_version" {
  type        = number
  description = "Version of the KV secrets engine (1 or 2)"
  default     = 2
  validation {
    condition     = contains([1, 2], var.kv_version)
    error_message = "KV version must be either 1 or 2."
  }
}

# Create a KV secrets engine for the team
resource "vault_mount" "team_secrets" {
  path        = "${var.team_name}-secrets"
  type        = "kv"
  description = "KV secrets engine for ${var.team_name} team in ${var.environment}"
  
  options = var.kv_version == 2 ? { version = "2" } : null
}

# Create a policy that allows the team to manage their own secrets
resource "vault_policy" "team_policy" {
  name = "${var.team_name}-${var.service_name}-${var.environment}-policy"
  
  policy = <<-EOT
    # Allow full access to the team's secrets
    path "${vault_mount.team_secrets.path}/*" {
      capabilities = ["create", "read", "update", "delete", "list"]
    }
  EOT
}

# Output the path to the secrets engine
output "secrets_engine_path" {
  value       = vault_mount.team_secrets.path
  description = "Path where the secrets engine is mounted"
}

output "policy_name" {
  value       = vault_policy.team_policy.name
  description = "Name of the Vault policy created for the team"
}
