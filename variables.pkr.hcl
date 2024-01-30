variable "nomad_ver" {
  type = string
  default = "1.7.3"
}

variable "license" {
  type    = string
  default = "nomad.hclic"
}

variable "nomad_config" {
  type    = string
  default = "nomad.pkrtpl.hcl"
}

variable "region" {
  type = string
  default = "us-east-2"
}