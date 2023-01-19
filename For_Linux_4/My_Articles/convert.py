#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import re
import pathlib

def main():
	cert_file = './certificate.txt'
	with open(cert_file, "r") as f:
		lines = f.readlines()
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
			outname = pathlib.Path(outname.replace(' ','_')).resolve()
			iswrite = True
		elif onsearch1 in item:
			onstart = re.search(onsearch2, item).end()
			outname = str(fname + ' ' + item[onstart:]  + '.pem').replace(onsearch2,'').replace('*','_').replace(' ','_').replace('\n','')
			outname = pathlib.Path(outname).resolve()
			iswrite = True
		if iswrite:
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
