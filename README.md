# Plugin Sops

This module adds the `SOPS` plugin to your Spacelift account.
It will decrypt an arbitrary number of files based on config you set.

## Usage

This plugin requires the `sops` binary in the Spacelift runner. The included `Dockerfile` will build a terraform runner with `sops` installed.

1. Build your custom runner using the included `Dockerfile` as a starting point.
2. Spin up the module (see examples below)
3. Add the `plugin_sops` label to any stack that has access to your decryption keys.
4. The secrets you define in your `.sops.yaml` will automatically be decrypted with your configured `creation_rules`.

#### .sops.yaml

The `.sops.yaml` file is a configuration file that tells `sops` how to decrypt your files.
It is a YAML file that contains a list of `creation_rules` that define how to decrypt your files.
Read more on sops official repository: https://github.com/getsops/sops

In addition to the sops config, this plugin also uses the `.sops.yaml` file to determine which files to decrypt.
simply add a list of `secrets` to your `.sops.yaml` in your working directory and the plugin will decrypt them.

The following `.sops.yaml` example will decrypt a `test_secret.yaml` file using the defined kms key.
```yaml
creation_rules:
  - kms: arn:aws:kms:us-east-2:694182862388:key/6825a259-28df-43be-80f8-6122eb8a5903

secrets:
  - test_secret.yaml
```



<!-- BEGIN_TF_DOCS -->
## Example

```hcl
module "plugin_sops" {
  source = "spacelift.io/spacelift-solutions/plugin-sops/spacelift"
  
  # Optional Variables
  name     = "plugin-sops"
  space_id = "root"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Name of the context | `string` | `"trigger_attached_contexts_stacks"` | no |
| <a name="input_space_id"></a> [space\_id](#input\_space\_id) | ID of the space | `string` | `"root"` | no |
| <a name="input_spacelift_domain"></a> [spacelift\_domain](#input\_spacelift\_domain) | fqdn of the spacelift instance (https://spacelift-solutions.app.spacelift.io) | `string` | n/a | yes |
<!-- END_TF_DOCS -->
