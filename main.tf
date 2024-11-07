terraform {
  required_providers {
    spacelift = {
      source  = "spacelift-io/spacelift"
      version = ">= 0.0.1"
    }
  }
}

resource "spacelift_context" "this" {
  name = var.name

  labels   = ["autoattach:plugin_sops"]
  space_id = var.space_id

  before_init = [
    "python /mnt/workspace/plugin_sops/space.py start plugin_sops"
  ]
}

resource "spacelift_mounted_file" "this" {
  context_id    = spacelift_context.this.id
  relative_path = "plugin_sops/plugin_sops.py"
  content       = filebase64("${path.module}/plugin_sops.py")
  write_only    = false
}

resource "spacelift_mounted_file" "spacepy" {
  context_id    = spacelift_context.this.id
  relative_path = "plugin_sops/space.py"
  content       = filebase64("${path.module}/space.py")
  write_only    = false
}

resource "spacelift_mounted_file" "requirements" {
  context_id    = spacelift_context.this.id
  relative_path = "plugin_sops/requirements.txt"
  content       = filebase64("${path.module}/requirements.txt")
  write_only    = false
}