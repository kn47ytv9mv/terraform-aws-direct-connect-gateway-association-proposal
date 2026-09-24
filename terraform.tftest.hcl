mock_provider "aws" {
}

run "required_fields_pass_through" {
  command = plan

  variables {
    dx_gateway_id               = "dx-gw-12345"
    dx_gateway_owner_account_id = "999999999999"
    associated_gateway_id       = "tgw-12345"
  }

  assert {
    condition     = aws_dx_gateway_association_proposal.resource.dx_gateway_id == "dx-gw-12345"
    error_message = "dx_gateway_id should pass through unchanged."
  }

  assert {
    condition     = aws_dx_gateway_association_proposal.resource.dx_gateway_owner_account_id == "999999999999"
    error_message = "dx_gateway_owner_account_id should pass through unchanged."
  }

  assert {
    condition     = aws_dx_gateway_association_proposal.resource.associated_gateway_id == "tgw-12345"
    error_message = "associated_gateway_id should pass through unchanged."
  }
}

run "allowed_prefixes_pass_through" {
  command = plan

  variables {
    dx_gateway_id               = "dx-gw-12345"
    dx_gateway_owner_account_id = "999999999999"
    associated_gateway_id       = "tgw-12345"
    allowed_prefixes            = ["10.0.0.0/16", "10.1.0.0/16"]
  }

  assert {
    condition     = toset(aws_dx_gateway_association_proposal.resource.allowed_prefixes) == toset(["10.0.0.0/16", "10.1.0.0/16"])
    error_message = "allowed_prefixes should pass through unchanged."
  }
}

run "readme_example" {
  command = plan

  variables {
    dx_gateway_id               = "dx-gw-12345"
    dx_gateway_owner_account_id = "999999999999"
    associated_gateway_id       = "tgw-12345"
  }
}
