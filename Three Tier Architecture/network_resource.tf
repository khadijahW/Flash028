resource "aws_vpc" "VPC" {
cidr_block="10.0.0.0/16"
    tags = {
        Name="VPC"
    }
}

resource " aws_subnet" "Left_public_subnet"{
    availability_zone = "ap-southeast-1a"
    cidr_block = "10.0.0.0/28"
    vpc_id = "aws_vpc.VPC"

    tags = {
        Name = "Left_public_subnet"
    }
}

resource " aws_subnet" "Right_public_subnet"{
    availability_zone = "ap-southeast-1b"
    cidr_block = "10.0.16.0/28"
    #This is 16 because the first subnet utilizes 16 ip addresses, 14 of them being for host
    vpc_id = "aws_vpc.VPC"

    tags = {
        Name = "Right_public_subnet"
    }
}

resource " aws_subnet" "Left_private_subnet"{
    availability_zone = "ap-southeast-1a"
    cidr_block = "10.0.0.32/28"
    vpc_id = "aws_vpc.VPC"

    tags = {
        Name = "Left_private_subnet"
    }
}
resource " aws_subnet" "Right_private_subnet"{
    availability_zone = "ap-southeast-1b"
    cidr_block = "10.0.0.48/28"
    vpc_id = "aws_vpc.VPC"

    tags = {
        Name = "Right_private_subnet"
    }
}


resource " aws_subnet" "Left_private_subnet2"{
    availability_zone = "ap-southeast-1a"
    cidr_block = "10.0.0.64/28"
    vpc_id = "aws_vpc.VPC"

    tags = {
        Name = "Left_private_subnet2"
    }
}
resource " aws_subnet" "Right_private_subnet2"{
    availability_zone = "ap-southeast-1b"
    cidr_block = "10.0.0.80/28"
    vpc_id = "aws_vpc.VPC"

    tags = {
        Name = "Right_private_subnet2"
    }
}