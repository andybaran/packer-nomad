variable "nomad_ver" {
  type = string
}

variable "os_user" {
  type    = string
  default = "nomad"
}

variable "os_password" {
  type    = string
  default = "nomad"
}

variable "enterprise" {
  type    = bool
  default = false
}

variable "license" {
  type    = string
  default = "nomad.hclic"
}

variable "nomad_config" {
  type    = string
  default = "nomad.pkrtpl.hcl"
}