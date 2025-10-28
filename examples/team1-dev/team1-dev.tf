module "team1_secrets" {
  source = "../../modules/team-secrets-engine"

  team_name   = "team"
  environment = "dev"
}

output "secrets_engine_path" {
  value = module.team1_secrets.secrets_engine_path
}

output "policy_name" {
  value = module.team1_secrets.policy_name
}
