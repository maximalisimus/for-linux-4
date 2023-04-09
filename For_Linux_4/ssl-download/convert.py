#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import re
import pathlib
import sys

def main():
	cert_file = pathlib.Path('./certificate.txt').resolve()
	with open(cert_file, "r") as f:
		lines = f.readlines()
	cert_file.unlink(missing_ok=True)
	onsearch1 = 's:C'
	onsearch2 = 'CN = '
	onsearch3 = 'BEGIN CERTIFICATE'
	onsearch4 = 'END CERTIFICATE'
	fname = ''
	outname = ''
	startname = True
	startcert = False
	endcert = False
	iswrite = False
	for item in lines:
		if onsearch1 in item and startname:
			onstart = re.search(onsearch2, item).end()
			fname = item[onstart:].replace('*','_')
			startname = False
			outname = str(fname  + '.pem').replace(onsearch2,'').replace('*','_').replace(' ','_').replace('\n','')
			outname = pathlib.Path(sys.argv[0]).parent.joinpath("certs").joinpath(outname.replace(' ','_')).resolve()
			iswrite = True
		elif onsearch1 in item:
			onstart = re.search(onsearch2, item).end()
			outname = str(fname + ' ' + item[onstart:]  + '.pem').replace(onsearch2,'').replace('*','_').replace(' ','_').replace('\n','')
			outname = pathlib.Path(sys.argv[0]).parent.joinpath("certs").joinpath(outname).resolve()
			iswrite = True
		if iswrite:
			if not pathlib.Path(sys.argv[0]).parent.joinpath("certs").resolve().exists():
				pathlib.Path(sys.argv[0]).parent.joinpath("certs").resolve().mkdir(parents=True)
			with open(outname, 'a') as f:
				if onsearch3 in item:
					startcert = True
				if onsearch4 in item:
					startcert = False
					endcert = True
				if startcert:
					f.write(item)
				if endcert:
					endcert = False
					f.write(item)

if __name__ == '__main__':
	main()
