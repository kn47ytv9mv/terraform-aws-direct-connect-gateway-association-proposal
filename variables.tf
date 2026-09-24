variable "dx_gateway_id" {
  default     = null
  description = "The ID of the Direct Connect gateway, owned by another account, to propose an association with."
}

variable "dx_gateway_owner_account_id" {
  default     = null
  description = "The account ID that owns dx_gateway_id."
}

variable "associated_gateway_id" {
  default     = null
  description = "The ID of the VPC's virtual private gateway or Transit Gateway, owned by this account, to propose for association."
}

variable "allowed_prefixes" {
  default     = null
  description = "CIDR blocks to advertise over the association once accepted. If null, AWS defaults to the VPC's own CIDR blocks for a virtual private gateway, or requires an explicit list for a Transit Gateway."
}
