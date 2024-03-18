variable "location" {
	type = string
	description = "Region de Azure donde se alojará la estructura"
	default = "East US"
}

variable "vm_size" {
	type = string
	description = "Tamanio de la maquina virtual"
	default = "Standard_DS2_v2" # 7 GB, 2 CPU
}
