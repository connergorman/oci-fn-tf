## Copyright (c) 2020, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_functions_application" "application" {
    compartment_id = var.compartment_ocid
    display_name = "${var.app_display_name}"
    subnet_ids = [!var.use_existing_vcn ? oci_core_subnet.fnsubnet[0].id : var.fn_subnet_id]
}

resource "oci_functions_function" "function" {
    application_id = oci_functions_application.application.id
    display_name = "${var.fn_display_name}"
    image = "${local.ocir_docker_repository}/${local.ocir_namespace}/${var.ocir_repo_name}/${var.image_name}:0.0.5"
    memory_in_mbs = "256" 
    config = { 
      "REGION" : "${var.region}"
    }
}

