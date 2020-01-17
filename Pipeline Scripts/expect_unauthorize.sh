#!/usr/bin/expect -f

# Pre-requirements before running this script
# Install expect: yum install expect -y (RedHat/CentOS) or apt-get install expect -y (ubuntu)

# Install dos2unix (if script was created on Windows): yum install dos2unix -y (RedHat/CentOS) or apt-get install dos2unix -y (ubuntu)  
#In some operating systems, the format of the script can't be read successfully that is why you need to convert it to unix format.

#How to use dos2unix: dos2unix expect_unauthorize.sh

# place the key on this directory: ~/.ssh/
# change the permission of the key that will be used: chmod 400 <key>

if {[llength $argv] < 2} {
    puts "Usage: ./expect_unauthorize.sh <nameOfkey> <user@remotehost>";
    exit 1;
}

puts \033\[2J

set key [lindex $argv 0]
set userhost [lindex $argv 1]
spawn sudo ssh -i ~/.ssh/$key $userhost
expect {
        "yes/no*" {
                send "yes\n"
                exp_continue
       }
}
interact