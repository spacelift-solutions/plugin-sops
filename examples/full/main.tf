module "plugin_sops" {
  source = "spacelift.io/spacelift-solutions/plugin-sops/spacelift"

  # Optional Variables
  name     = "plugin-sops"
  space_id = "root"
}