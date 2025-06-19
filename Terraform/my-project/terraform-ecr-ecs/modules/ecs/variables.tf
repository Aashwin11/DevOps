variable "task-role-arn"{
    type=string

}

variable "execution-role-arn"{
        type=string

}
variable "web-image-url"{
    type=string

}

variable "mongo-image"{
        type=string
}
variable "efs-volume-name"{
    type=string
}
variable "efs_file_system_id"{
    type=string
}
variable "target-group-arn" {
  type=string
}
variable "subnet-ids" {
  type=list(string)
}
variable "security-group-ids" {
  
}

variable "cluster-name" {
  type=string
}
variable "desired-count" {
}