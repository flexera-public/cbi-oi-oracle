## This configuration was generated by terraform-provider-oci

resource oci_apigateway_gateway export_app-gw {
  #certificate_id = <<Optional value not found in discovery>>
  compartment_id = oci_artifacts_container_configuration.export_container_configuration.id
  defined_tags = {
    "Oracle-Tags.CreatedBy" = var.tag_created_by
    "Oracle-Tags.CreatedOn" = var.tag_created_on
  }
  display_name  = "app-gw"
  endpoint_type = "PUBLIC"
  freeform_tags = {
  }
  subnet_id = oci_core_subnet.export_Public-Subnet.id
}

resource oci_apigateway_deployment export_Web-Server {
  compartment_id = oci_artifacts_container_configuration.export_container_configuration.id
  defined_tags = {
    "Oracle-Tags.CreatedBy" = var.tag_created_by
    "Oracle-Tags.CreatedOn" = var.tag_created_on
  }
  display_name = "Web-Server"
  freeform_tags = {
  }
  gateway_id  = oci_apigateway_gateway.export_app-gw.id
  path_prefix = "/cbi"
  specification {
    logging_policies {
      #access_log = <<Optional value not found in discovery>>
      execution_log {
        is_enabled = "true"
        log_level  = "INFO"
      }
    }
    request_policies {
      authentication {
        #audiences = <<Optional value not found in discovery>>
        function_id                 = oci_functions_function.export_oci-cbi.id
        is_anonymous_access_allowed = "true"
        #issuers = <<Optional value not found in discovery>>
        #max_clock_skew_in_seconds = <<Optional value not found in discovery>>
        #public_keys = <<Optional value not found in discovery>>
        #token_auth_scheme = <<Optional value not found in discovery>>
        token_header = "Auth-Token"
        #token_query_param = <<Optional value not found in discovery>>
        type = "CUSTOM_AUTHENTICATION"
        #verify_claims = <<Optional value not found in discovery>>
      }
      cors {
        allowed_headers = [
        ]
        allowed_methods = [
          "*",
        ]
        allowed_origins = [
          "*",
        ]
        exposed_headers = [
        ]
        is_allow_credentials_enabled = "false"
        max_age_in_seconds           = "0"
      }
      #rate_limiting = <<Optional value not found in discovery>>
    }
    routes {
      backend {
        #body = <<Optional value not found in discovery>>
        #connect_timeout_in_seconds = <<Optional value not found in discovery>>
        function_id = oci_functions_function.export_oci-cbi.id
        #headers = <<Optional value not found in discovery>>
        #is_ssl_verify_disabled = <<Optional value not found in discovery>>
        #read_timeout_in_seconds = <<Optional value not found in discovery>>
        #send_timeout_in_seconds = <<Optional value not found in discovery>>
        #status = <<Optional value not found in discovery>>
        type = "ORACLE_FUNCTIONS_BACKEND"
        #url = <<Optional value not found in discovery>>
      }
      logging_policies {
        #access_log = <<Optional value not found in discovery>>
        execution_log {
          #is_enabled = <<Optional value not found in discovery>>
          log_level = ""
        }
      }
      methods = [
        "POST",
      ]
      path = "/invoke"
      request_policies {
        authorization {
          #allowed_scope = <<Optional value not found in discovery>>
          type = "ANONYMOUS"
        }
        #cors = <<Optional value not found in discovery>>
        #header_transformations = <<Optional value not found in discovery>>
        #query_parameter_transformations = <<Optional value not found in discovery>>
      }
      response_policies {
        #header_transformations = <<Optional value not found in discovery>>
      }
    }
  }
}

