variable "region" {
  description = "region"
  type = string
  default = "eu-west-2"
}

variable "az_1" {
    description = "az for first subnet"
    type = string
    default = "eu-west-2a"
}

variable "az_2" {
    description = "az for second subnet"
    type = string
    default = "eu-west-2b"
}