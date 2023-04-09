#!/bin/bash

for certDB in $(find ~/ -name "cert9.db"); do
	certdir=$(dirname ${certDB});
	for cert_files in ./*.pem; do
		certname=$(basename "${cert_files}" | sed 's/.pem//g')
		certutil -A -n "${certname}" -t "TCu,Cu,Tu" -i "${cert_files}" -d sql:${certdir}
	done
done

for certDB in $(find ~/ -name "cert8.db"); do
	certdir=$(dirname ${certDB});
	for cert_files in ./*.pem; do
		certname=$(basename "${cert_files}" | sed 's/.pem//g')
		certutil -A -n "${certname}" -t "TCu,Cu,Tu" -i "${cert_files}" -d sql:${certdir}
	done
done
