resource "aws_dx_gateway_association_proposal" "resource" {
  dx_gateway_id               = var.dx_gateway_id
  dx_gateway_owner_account_id = var.dx_gateway_owner_account_id
  associated_gateway_id       = var.associated_gateway_id
  allowed_prefixes            = var.allowed_prefixes
}

output "id" {
  description = "The ID of the association proposal — pass to terraform-aws-direct-connect-gateway-association's proposal_id, in the Direct Connect gateway's own account, to accept it."
  value       = aws_dx_gateway_association_proposal.resource.id
}

output "associated_gateway_type" {
  description = "Whether the proposed gateway is a virtual private gateway or a Transit Gateway."
  value       = aws_dx_gateway_association_proposal.resource.associated_gateway_type
}

output "associated_gateway_owner_account_id" {
  description = "The account ID that owns associated_gateway_id — this account, restated by AWS. Pass to terraform-aws-direct-connect-gateway-association's associated_gateway_owner_account_id."
  value       = aws_dx_gateway_association_proposal.resource.associated_gateway_owner_account_id
}
