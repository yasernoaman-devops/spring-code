variable location-1 {
  type        = string
  default     = "East US 2"
  description = "this is the location of demo"
}



variable "vm_count" {
  default = 2
  type        = number
}

variable "vm_prefix" {
  description = "Prefix for VM names"
  type        = string
  default = "POC-VM"
}
