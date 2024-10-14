# declaring a list as a variable 
variable "iam_users_list"{
    default = ["user1","user2","user3"]
}

#declaring map as a variable
variable "map_users"{
    default = {
        user4:"India",
        user5:"Nepal"
        }
}

# using maps within a map variable
variable "map_of_map_users"{
    default = {
        user1:{country:"India",state:"Karnataka"},
        user2:{country:"Nepal",state:"Kathmandu"}
    }
}
resource "aws_iam_user" "my_iam_user"{
    
    # accessing list variable to create iam users
    # for_each = toset(var.iam_users_list)
    # name = each.value
    
    # accessing map variable to create iam users and their tags
    # for_each = var.map_users
    # name = each.key
    # tags = {
    #    country:each.value
    # }

    for_each = var.map_of_map_users
    name = each.key
    tags = {
        country : each.value.country
        state : each.value.state
    }
}



