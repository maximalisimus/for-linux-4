#!/bin/bash

for cert_files in ./*.pem; do
	certname=$(basename "${cert_files}" | sed 's/.pem//g')
	openssl x509 -inform PEM -in "${certname}.pem" -out "${certname}.crt" # -outform PEM
done


