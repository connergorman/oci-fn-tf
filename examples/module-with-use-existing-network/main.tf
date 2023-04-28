## Copyright (c) 2021 Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "region" {}
variable "compartment_ocid" {}
variable "ocir_user_name" {}
variable "ocir_user_password" {}
variable "image_name" {}
variable "app_display_name" {}
variable "fn_display_name" {}

provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region
}

module "oci-arch-fn-app" {
  source             = "../../"
  tenancy_ocid       = var.tenancy_ocid
  user_ocid          = var.user_ocid
  fingerprint        = var.fingerprint
  region             = var.region
  private_key_path   = var.private_key_path
  compartment_ocid   = var.compartment_ocid
  ocir_user_name     = var.ocir_user_name
  ocir_user_password = var.ocir_user_password
  use_existing_vcn   = true
  vcn_id             = "ocid1.vcn.oc1.iad.amaaaaaapc6swyaasvtk5w6b4qrf454d6vb7ddkz4fsbl65u5ngo4ydaq6lq"
  fn_subnet_id       = "ocid1.subnet.oc1.iad.aaaaaaaaezobtwfr4gyys4cctenbw27lk6pvd2fdw7gdvjzlulmqp72ydc6q"
  image_name         = var.image_name
  fn_display_name    = var.fn_display_name
  app_display_name   = var.app_display_name
}


