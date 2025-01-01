variable "ami" {
  default = "Your AMI Id"
}

variable "instance_type" {
  default = "Instance Size"
}

variable "region" {
  default = "Region"
}

variable "to_port" {
  type    = list(number)
  default = [9090, 22]
}

variable "from_port" {
  type    = list(number)
  default = [9090, 22]
}
variable "cidr_block" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "rule_description" {
  type = list(string)
  default = [
    "Allowing access to cockpit on port 9090",
    "Allowing SSH connection the instance"
  ]
}
