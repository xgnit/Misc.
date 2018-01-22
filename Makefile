CFLAGS=-Wall -ggdb -I./lib -I./lib/cpp -std=c++11
LDFLAGS=-L./lib ./lib/cpp/libmosquittopp.so.1 ./lib/libmosquitto.so.1

.PHONY: all clean own_clean own_target

CROSS_COMPILE=arm-unknown-linux-gnueabi-
CC=gcc
CXX=${CROSS_COMPILE}g++

ip=81

target=mos_cpp
own_target:own_clean ${target} copy

own_clean:
	ssh root@192.168.196.${ip} rm -f /home/${target}
	rm -rf ${target}	

copy:
	scp ${target} root@192.168.196.${ip}:/home

print-%  : ; @echo $* = $($*)

all : ${target}

get_config.o: get_config.cpp
	${CXX} -c $^ -o $@ ${CFLAGS}


${target} : main.o mqtt_dev.o get_config.o
	${CXX} $^ -o $@ ${LDFLAGS}

main.o : main.cpp
	${CXX} -c $^ -o $@ ${CFLAGS}

mqtt_dev.o : mqtt_dev.cpp
	${CXX} -c $^ -o $@ ${CFLAGS}

clean : 
	-rm -f *.o mqtt_temperature_conversion
