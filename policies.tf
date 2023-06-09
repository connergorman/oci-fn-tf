## Copyright (c) 2020, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

# Functions Policies

#resource "oci_identity_policy" "FunctionsServiceReposAccessPolicy" {
#  provider = oci.homeregion
#  name = "FunctionsServiceReposAccessPolicy-${random_id.tag.hex}"
#  description = "FunctionsServiceReposAccessPolicy-${random_id.tag.hex}"
#  compartment_id = var.tenancy_ocid
#  statements = ["Allow service FaaS to read repos in tenancy"]
#  provisioner "local-exec" {
#       command = "sleep 5"
#  }
#}


#resource "oci_identity_policy" "FunctionsServiceNetworkAccessPolicy" {
#  provider = oci.homeregion
#  depends_on = [oci_identity_policy.FunctionsDevelopersManageNetworkAccessPolicy]
#  name = "FunctionsServiceNetworkAccessPolicy-${random_id.tag.hex}"
#  description = "FunctionsServiceNetworkAccessPolicy-${random_id.tag.hex}"
#  compartment_id = var.tenancy_ocid
#  statements = ["Allow service FaaS to use virtual-network-family in compartment id ${var.compartment_ocid}"]
#  
#  provisioner "local-exec" {
#       command = "sleep 5"
#  }
#}

resource "oci_identity_policy" "FunctionsServiceObjectStorageManageAccessPolicy" {
  provider       = oci.homeregion
  name           = "FunctionsServiceObjectStorageManageAccessPolicy-${random_id.tag.hex}"
  description    = "FunctionsServiceObjectStorageManageAccessPolicy-${random_id.tag.hex}"
  compartment_id = var.tenancy_ocid
  statements     = ["Allow service objectstorage-${var.region} to manage object-family in tenancy"]

  provisioner "local-exec" {
    command = "sleep 5"
  }
}



resource "oci_identity_dynamic_group" "FunctionsServiceDynamicGroup" {
  provider = oci.homeregion
  #  depends_on     = [oci_identity_policy.FunctionsServiceNetworkAccessPolicy]
  name           = "FunctionsServiceDynamicGroup-${random_id.tag.hex}"
  description    = "FunctionsServiceDynamicGroup-${random_id.tag.hex}"
  compartment_id = var.tenancy_ocid
  matching_rule  = "ALL {resource.type = 'fnfunc', resource.compartment.id = '${var.compartment_ocid}'}"

  provisioner "local-exec" {
    command = "sleep 5"
  }
}

resource "oci_identity_policy" "FunctionsServiceDynamicGroupPolicy" {
  provider       = oci.homeregion
  depends_on     = [oci_identity_dynamic_group.FunctionsServiceDynamicGroup]
  name           = "FunctionsServiceDynamicGroupPolicy-${random_id.tag.hex}"
  description    = "FunctionsServiceDynamicGroupPolicy-${random_id.tag.hex}"
  compartment_id = var.compartment_ocid
  statements     = ["allow dynamic-group ${oci_identity_dynamic_group.FunctionsServiceDynamicGroup.name} to manage all-resources in compartment id ${var.compartment_ocid}"]

  provisioner "local-exec" {
    command = "sleep 5"
  }
}
