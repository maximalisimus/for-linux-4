

https://github.com/kkkgo/vlmcsd
https://github.com/kkkgo/vlmcsd.git
https://github.com/kkkgo/vlmcsd/releases

Microsoft KMS Activation

Windows
slmgr.vbs -ipk W269N-WFGWX-YVC9B-4J6C9-T83GX
slmgr.vbs -skms kms.srv.crsoo.com
slmgr.vbs -ato

slmgr.vbs -ipk VDYBN-27WPP-V4HQT-9VMD4-VMK7H
slmgr.vbs -skms 192.168.14.147
slmgr.vbs -ato

Office
cd C:\Program Files\Microsoft Office\Office15
cscript ospp.vbs /inpkey:YC7DK-G2NP3-2QQC3-J6H88-GVGXT
cscript ospp.vbs /sethst:kms.srv.crsoo.com
cscript ospp.vbs /act

cd C:\Program Files\Microsoft Office\Office16
cscript ospp.vbs /sethst: 192.168.14.147
cscript ospp.vbs /act

cscript ospp.vbs /dstatusall




