
resource "null_resource" "apache" {

    count = "${var.webserver_count}"

    connection {
        type = "ssh"
        host = "${element(packet_device.webservers.*.access_public_ipv4,count.index)}"
        private_key = "${file("~/.ssh/id_rsa")}"
        agent = false
    }

    provisioner "remote-exec" {
        inline = [
            "apt-get -y update",
            "apt-get -y install apache2",
            "echo `hostname` > /var/www/html/index.html"
        ]
    }
}


