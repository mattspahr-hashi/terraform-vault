# sentinel.hcl - Configuration for Sentinel policies

policy "enforce-kv-version" {
    source = "./enforce_kv_version.sentinel"
    enforcement_level = "hard-mandatory"
    description = "Enforces that all KV mounts use version 2"
}

policy "enforce-naming-convention" {
    source = "./enforce_naming_convention.sentinel"
    enforcement_level = "advisory"
    description = "Enforces naming conventions for KV mounts"
}

policy "validate-policy-structure" {
    source = "./validate_policy_structure.sentinel"
    enforcement_level = "hard-mandatory"
    description = "Validates that Vault policies have required capabilities"
}
