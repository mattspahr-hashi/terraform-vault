module "vault-kv" {
  source  = "app.terraform.io/mattspahr-sandbox/vault-kv/vault"
  version = "1.0.1"

  team_name   = "payments"
  service_name = "payment-service1"
  environment = "dev"
}

output "secrets_engine_path" {
  value = module.vault-kv.secrets_engine_path
}

output "policy_name" {
  value = module.vault-kv.policy_name
}
