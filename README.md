# terraform-aws-direct-connect-gateway-association-proposal

Terraform module proposing a cross-account association between a
Direct Connect gateway owned by another account and a VPC's virtual
private gateway or Transit Gateway owned by this one.

## Cost

This proposal carries no charge of its own — see
[`terraform-aws-direct-connect-gateway`](https://github.com/kn47ytv9mv/terraform-aws-direct-connect-gateway)'s
Cost section for where Direct Connect's real charges originate.

## Design

The other half of
[`terraform-aws-direct-connect-gateway-association`](https://github.com/kn47ytv9mv/terraform-aws-direct-connect-gateway-association)'s
cross-account path — same shape as
[`terraform-aws-vpc-peering-connection-accepter`](https://github.com/kn47ytv9mv/terraform-aws-vpc-peering-connection-accepter)
and
[`terraform-aws-transit-gateway-peering-accepter`](https://github.com/kn47ytv9mv/terraform-aws-transit-gateway-peering-accepter):
this module runs in the account that owns the virtual private gateway
or Transit Gateway (`associated_gateway_id`), proposing an association
with a Direct Connect gateway it does not own
(`dx_gateway_id`/`dx_gateway_owner_account_id`). The Direct Connect
gateway's own account then accepts it — pass this module's `id`
output to `terraform-aws-direct-connect-gateway-association`'s
`proposal_id`, running under that account's own provider.

Needs no physical Direct Connect connection or virtual interface to
exist first, same as the other two modules in this trio — a real
`terraform apply`/`terraform destroy` exercises the full propose/accept
flow against AWS's control-plane APIs alone.

## Usage

```hcl
module "proposal" {
  source = "kn47ytv9mv/direct-connect-gateway-association-proposal/aws"

  dx_gateway_id               = "dx-gw-12345"
  dx_gateway_owner_account_id = "999999999999"
  associated_gateway_id       = module.transit_gateway.id
}
```

Or directly from this repository:

```hcl
module "proposal" {
  source = "github.com/kn47ytv9mv/terraform-aws-direct-connect-gateway-association-proposal"

  dx_gateway_id               = "dx-gw-12345"
  dx_gateway_owner_account_id = "999999999999"
  associated_gateway_id       = module.transit_gateway.id
}
```

## Requirements

| Name | Version |
|---|---|
| terraform | >= 1.0 |
| aws | ~> 6.61 |

## Providers

| Name | Version |
|---|---|
| aws | ~> 6.61 |

## Inputs

| Name | Description | Default | Required |
|---|---|---|---|
| dx_gateway_id | The ID of the Direct Connect gateway, owned by another account, to propose an association with. | `null` | no |
| dx_gateway_owner_account_id | The account ID that owns dx_gateway_id. | `null` | no |
| associated_gateway_id | The ID of the VPC's virtual private gateway or Transit Gateway, owned by this account, to propose for association. | `null` | no |
| allowed_prefixes | CIDR blocks to advertise over the association once accepted. If null, AWS defaults to the VPC's own CIDR blocks for a virtual private gateway, or requires an explicit list for a Transit Gateway. | `null` | no |

## Outputs

| Name | Description |
|---|---|
| id | The ID of the association proposal — pass to terraform-aws-direct-connect-gateway-association's proposal_id, in the Direct Connect gateway's own account, to accept it. |
| associated_gateway_type | Whether the proposed gateway is a virtual private gateway or a Transit Gateway. |
| associated_gateway_owner_account_id | The account ID that owns associated_gateway_id — this account, restated by AWS. Pass to terraform-aws-direct-connect-gateway-association's associated_gateway_owner_account_id. |

## License

MIT — see [LICENSE.md](LICENSE.md).
