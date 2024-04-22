#!/bin/bash
#
# $ sudo usermod -aG disk,storage mikl
#
_language=$(locale | cut -d '"' -f2 | cut -d '.' -f1 | grep -Evi "=" | sed '/_/!d' | sort -u | cut -d '_' -f1 | tr '[:upper:]' '[:lower:]' | sed '2,$d')
#
case "${_language[*]}" in
	"en") _menu_title="Removing flash drives"
		_menu_text="\nThe menu for selecting the flash drive to extract.\n"
		_notify_title="Removing the USB device."
		_notify_text_one="Your USB device"
		_notify_text_two="can be removed!"
		# English
		;;
	"it") _menu_title="Rimozione di unità flash"
		_menu_text="\nMenu di selezione dell'unità flash da espellere.\n"
		_notify_title="Rimozione del dispositivo USB."
		_notify_text_one="Il tuo dispositivo USB"
		_notify_text_two="può essere estratto!"
		# Italian
		;;
	"ru") _menu_title="Извлечение флешек"
		_menu_text="\nМеню выбора флешки для извлечения.\n"
		_notify_title="Извлечение USB устройства."
		_notify_text_one="Ваше USB устройство"
		_notify_text_two="может быть извлечено!"
		# Russian
		;;
	"tr") _menu_title="Flash sürücülerin çıkarılması"
		_menu_text="\nÇıkarılacak flash sürücüyü seçme menüsü.\n"
		_notify_title="Cihazın usb'sini çıkarma."
		_notify_text_one="USB cihazınız"
		_notify_text_two="çıkarılabilir olabilir!"
		# Turkish
		;;
	"nl") _menu_title="Flash drives verwijderen"
		_menu_text="\nHet menu voor het selecteren van de flash drive te extraheren.\n"
		_notify_title="Het USB-apparaat verwijderen."
		_notify_text_one="Uw USB-apparaat"
		_notify_text_two="kan worden verwijderd!"
		# Dutch
		;;
	"el") _menu_title="Αφαίρεση μονάδων flash"
		_menu_text="\nΤο μενού για την επιλογή της μονάδας flash για εξαγωγή.\n"
		_notify_title="Αφαίρεση της συσκευής USB."
		_notify_text_one="Η συσκευή USB σας"
		_notify_text_two="μπορεί να εξαχθεί!"
		# Greek
		;;
	"da") _menu_title="Fjernelse af flashdrev"
		_menu_text="\nMenuen til valg af flashdrev, der skal udtrækkes.\n"
		_notify_title="Fjernelse af USB-enheden."
		_notify_text_one="Din USB-enhed"
		_notify_text_two="kan fjernes!"
		# Danish
		;;
	"hu") _menu_title="Flash meghajtók eltávolítása"
		_menu_text="\nA kibontandó flash meghajtó kiválasztásának menüje.\n"
		_notify_title="Az USB-eszköz eltávolítása."
		_notify_text_one="Az USB-eszköz"
		_notify_text_two="el lehet távolítani!"
		# Hungarian
		;;
	"pt") _menu_title="Extração de pen drives"
		_menu_text="\nMenu de seleção da unidade flash para extrair.\n"
		_notify_title="Remova o dispositivo USB."
		_notify_text_one="Seu dispositivo USB"
		_notify_text_two="pode ser extraído!"
		# Portuguese
		;;
	"de") _menu_title="Flash-Laufwerke entfernen"
		_menu_text="\nDas Auswahlmenü des zu extrahierenden USB-Sticks.\n"
		_notify_title="Entfernen des USB-Geräts."
		_notify_text_one="Ihr USB-Gerät"
		_notify_text_two="kann extrahiert werden!"
		# German
		;;
	"fr") _menu_title="Extraction de clés USB"
		_menu_text="\nMenu de sélection de la clé USB à extraire.\n"
		_notify_title="Retirer le périphérique USB."
		_notify_text_one="Votre périphérique USB"
		_notify_text_two="peut être extrait!"
		# French
		;;
	*) _menu_title="Removing flash drives"
		_menu_text="\nThe menu for selecting the flash drive to extract.\n"
		_notify_title="Removing the USB device."
		_notify_text_one="Your USB device"
		_notify_text_two="can be removed!"
		;;
esac
#
ABSOLUT_FILENAME=$(readlink -e "$0")
filesdir=$(dirname "$ABSOLUT_FILENAME")
_the_icon="${filesdir}/flashdrive-png.png"
SYSTEM=$(uname -s)
VERSION=$(uname -r)
ARCHI=$(uname -m)
usb_name=""
for i in /dev/disk/by-path/*usb* ; do
	if [[ $i != *part* ]]; then
		devpoint=$(readlink -f $i | cut -d '/' -f3-9)
		usb_name="${usb_name} $devpoint"
	fi
done
name_usb=( $usb_name )
unset usb_name
usb_name=$(printf "%s\n" "${name_usb[@]}" | sort -u | tr '\n' ' ')
unset name_usb
name_usb=( $usb_name )
unset usb_name
for i in ${name_usb[*]}; do
	m_point=$(lsblk -o NAME,MOUNTPOINT | grep -Ei "$i" | grep -Ei "run|media|mnt|/" | grep -Ei "/" | awk '{print $2,$3,$4,$5}' | sed -r 's/^ *| *$//g' | tr ' ' '_')
	if [[ ${m_point[*]} != "" ]]; then
		usb_size=$(lsblk -o NAME,SIZE | grep -Ei "^$i" | awk '{print $2}' | tr ' ' '_')
		usb_name=$(lsblk -o NAME,MOUNTPOINT | grep -Ei "$i" | grep -Ei "run|media|mnt|/" | rev | cut -d '/' -f1 | rev | tr ' ' '_')
		usb_model=$(lsblk -o  NAME,MODEL | grep -Ei "^$i" | awk '{print $2}' | tr ' ' '_')
		if [[ ${usb_model[*]} != "" ]]; then
			usb_info="${usb_size[*]}_${usb_name[*]}_${usb_model[*]}"
		else
			usb_info="${usb_size[*]}_${usb_name[*]}"
		fi	
		dev_usb=$(lsblk -ro  NAME,MOUNTPOINT | grep -Ei "$i" | grep -Ei "run|media|mnt" | awk '{print $1}' | sed -r 's/^ *| *$//g')
		menu_usb_dev="${menu_usb_dev} ${dev_usb[*]} $usb_info"
	fi
done
if [[ ${menu_usb_dev} != "" ]]; then
	variables=$(Xdialog --stdout --backtitle "$SYSTEM $VERSION $ARCHI" --title "${_menu_title}" --menu "${_menu_text}" 0 0 10 ${menu_usb_dev})
	if [[ ${variables} != "" ]]; then
		udisksctl unmount --block-device /dev/"${variables[*]}"
		wait
		udisksctl power-off --block-device /dev/"${variables}"
		wait
		notify-send --urgency normal --expire-time=10000 -i "$_the_icon" "${_notify_title}" "${_notify_text_one} <b>/dev/${variables}</b> ${_notify_text_two}"
	fi
fi
exit 0
