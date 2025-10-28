# sentinel.hcl - Configuration for Sentinel policies

policy "enforce-kv-version" {
    source = "./enforce_kv_version.sentinel"
    enforcement_level = "hard-mandatory"
}

policy "enforce-naming-convention" {
    source = "./enforce_naming_convention.sentinel"
    enforcement_level = "advisory"
}

policy "validate-policy-structure" {
    source = "./validate_policy_structure.sentinel"
    enforcement_level = "hard-mandatory"
}
