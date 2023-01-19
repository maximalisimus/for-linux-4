#!/bin/bash
 
certname="$1"
 
for certDB in $(find ~/ -name "cert9.db"); do
	certdir=$(dirname ${certDB});
	for cert_files in ./*.pem; do
		certutil -A -n "${certname}" -t "TCu,Cu,Tu" -i "${cert_files}" -d sql:${certdir}
	done
done
