# Vault Secrets Engine Module for Teams

This Terraform module provides a no-code solution for teams to self-serve their own Vault secrets engines with appropriate access controls. It's designed to be used with Terraform Enterprise for a complete GitOps workflow.

## Features

- **No-Code Provisioning**: Teams can provision their own secrets engines through simple variable inputs
- **Multi-Environment Support**: Built-in support for multiple environments (dev, staging, prod)
- **Secure by Default**: Implements least-privilege access and short-lived credentials
- **Audit Trail**: All changes are tracked through version control
- **Self-Service**: Teams can manage their own secrets without requiring Vault admin intervention

## Prerequisites

- Vault server (local dev or production)
- Terraform 1.2.0 or later
- Vault provider 3.10 or later

## Module Usage

### Basic Example

```hcl
module "team_secrets" {
  source = "./modules/team-secrets-engine"

  team_name           = "payment-service"
  environment         = "dev"
  secrets_engine_type = "kv"
  kv_version          = 2
  default_lease_ttl   = 3600  # 1 hour
  max_lease_ttl       = 86400 # 24 hours
}
```

### Module Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| team_name | Name of the team that will own this secrets engine | string | n/a | yes |
| environment | Deployment environment (e.g., dev, staging, prod) | string | "dev" | no |
| secrets_engine_type | Type of secrets engine to create | string | "kv" | no |
| kv_version | Version of the KV secrets engine (1 or 2) | number | 2 | no |
| default_lease_ttl | Default lease TTL in seconds | number | 3600 | no |
| max_lease_ttl | Maximum lease TTL in seconds | number | 86400 | no |

### Module Outputs

| Name | Description |
|------|-------------|
| secrets_engine_path | Path where the secrets engine is mounted |
| approle_role_id | AppRole Role ID for the team |
| approle_secret_id | AppRole Secret ID for the team (sensitive) |
| policy_name | Name of the Vault policy created for the team |

## Example: Team Onboarding

1. **Create a new workspace in Terraform Enterprise**
   - Connect to your VCS repository
   - Set the working directory to `examples/team1-dev`
   - Configure Vault credentials as environment variables

2. **Customize the example**
   - Copy the example to a new directory for your team
   - Update the team name and environment
   - Commit and push the changes

3. **Run the pipeline**
   - The pipeline will create a new secrets engine and access credentials
   - The team will receive the Role ID and Secret ID for their applications

## Security Considerations

- **Never commit secrets to version control**
- Use TFE variables for sensitive values
- Rotate AppRole secret IDs regularly
- Restrict network access to Vault using firewall rules
- Monitor audit logs for suspicious activity

## Best Practices

1. **Least Privilege**
   - Grant only the permissions that are absolutely necessary
   - Use separate AppRoles for different applications

2. **Secret Rotation**
   - Implement automated secret rotation
   - Use short TTLs for sensitive credentials

3. **Monitoring and Alerting**
   - Monitor failed authentication attempts
   - Set up alerts for unusual access patterns

4. **Documentation**
   - Document the purpose of each secrets engine
   - Maintain an inventory of all secrets

## Cleanup

To remove resources:
1. Run `terraform destroy` in the workspace
2. The module will clean up all created resources including policies and auth methods

## License

This module is licensed under the MIT License.
