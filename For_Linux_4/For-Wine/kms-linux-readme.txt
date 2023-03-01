

https://github.com/kkkgo/vlmcsd
https://github.com/kkkgo/vlmcsd.git
https://github.com/kkkgo/vlmcsd/releases

./vlmcsd-x86-musl-static -L 127.0.0.1 -P 1688
pgrep vlmcsd
pkill vlmcsd

$./vlmcsd
$ netstat -ntlp | grep LISTEN

#cp vlmcsd /usr/bin
# cp vlmcs /usr/bin
# touch /etc/systemd/system/kms-script.service
# chmod 664 /etc/systemd/system/kms-script.service
# nano /etc/systemd/system/kms-script.service


[Unit]
Description=Microsoft KMS Server
After=network.target
After=network-online.target
Wants=network-online.target
 
[Service]
Type=oneshot
ExecStart=/usr/bin/vlmcsd
RemainAfterExit=yes
LimitNOFILE=65536
 
[Install]
WantedBy=multi-user.target



# systemctl daemon-reload
# systemctl start kms-script.service
# systemctl status kms-script.service
# systemctl enable kms-script.servi

Расширенные настройки KMS сервера можно задать с помощью файла vlmcsd.ini (есть образец в каталоге ../vlmcsd/etc/. 
Тамже можно задать путь к файлу с логами KMS сервера (vlmcsd.log). 
Можно указать пути к файлам в аргументах запуска vlmcsd с помощью параметров:
-i /etc/vlmcsd.ini
-l /var/log/vlmcsd.log

Example:

Windows:
slmgr.vbs -ipk VDYBN-27WPP-V4HQT-9VMD4-VMK7H
slmgr.vbs -skms 192.168.14.147
slmgr.vbs -ato

Проверить статус активации Windows можно командой:
slmgr.vbs -dlv

Аналогичным образом вы можете активировать на KMS сервере корпоративные версии Microsoft Office 2019/2016/2013. Для этого используются такие команды:

cd C:\Program Files\Microsoft Office\Office16
cscript ospp.vbs /sethst: 192.168.14.147
cscript ospp.vbs /act

Проверить статус активации Office можно так:

cscript ospp.vbs /dstatusall







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
cscript ospp.vbs /sethst:127.0.0.1
cscript ospp.vbs /act

cd C:\Program Files\Microsoft Office\Office16
cscript ospp.vbs /sethst: 127.0.0.1
cscript ospp.vbs /act

cscript ospp.vbs /dstatusall




