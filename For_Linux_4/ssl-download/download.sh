#!/bin/bash
 
openssl s_client -showcerts -connect "${1}":443 </dev/null > ./certificate.txt
