module "team1_secrets" {
  source = "../../modules/team-secrets-engine"

  team_name   = "team1"
  environment = "dev"
  kv_version  = 2
}

output "secrets_engine_path" {
  value = module.team1_secrets.secrets_engine_path
}

output "policy_name" {
  value = module.team1_secrets.policy_name
}
