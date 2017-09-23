#!/bin/sh


CMD=$@
XYZ=$(expect -c "
set start [exec cat /sys/block/sdb/sdb2/start]



spawn fdisk /dev/sdb
expect \"*Command*\"
send \"d\r\"
expect \"*Partition number*\"
send \"2\r\"
expect \"*Command*\"
send \"n\r\"
expect \"*Partition type*\"
send \"p\r\"
expect \"*Partition number*\"
send \"\r\"
expect \"*First sector*\"
send \"$start\r\"
expect \"*Last sector*\"
send \"\r\"
expect \"*remove the signature?*\"
send \"n\r\"
expect \"*Command*\"
send \"w\r\"
expect {
    timeout {puts \"took too much time\"}
    eof     {puts \"finished in time\"}
}
")
echo "$XYZ"


wait
e2fsck -f /dev/sdb2
wait
resize2fs /dev/sdb2
