# sentinel.hcl - Configuration for Sentinel policies

policy "enforce-naming-convention" {
    source = "./enforce_naming_convention.sentinel"
    enforcement_level = "advisory"
}
