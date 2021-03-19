#!/bin/sh
yum update -y
yum install httpd -y
service httpd start
#chkconfig httpd on
cat <<EOF > /var/www/html/index.html
<body bgcolor="#FFFF00"></body>
EOF