variable "iam_user_prefix"{
    type = string #any, number, bool, list, map, set, object, tuple
    default = "my_iam_user"
}


resource "aws_iam_user" "my_iam_users"{
    count = 2
    name = "${var.iam_user_prefix}_${count.index}"
}