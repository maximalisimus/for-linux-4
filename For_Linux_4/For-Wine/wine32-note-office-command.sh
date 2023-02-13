#!/bin/bash
export WINEPREFIX=~/.wine32/
export WINEARCH=win32
#wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
#chmod +x winetricks
./winetricks corefonts allfonts 
./winetricks msxml3 msxml4 msxml6
./winetricks vcrun2005 gdiplus riched30
winetricks dotnet20 dotnet30 dotnet35 dotnet40 dotnet45
winetricks vcrun2005 vcrun2008 vcrun2010
winetricks d3dx9 d3dx9_28 d3dx9_36 d3dx10
winetricks d3dxof dinput8 directmusic directplay
winetricks directx9 directx10
# wine ~/Загрузки/MicrosoftOffice/setup.exe
# wine ~/.msoffice/dosdevices/c:/Program Files/Microsoft Office/Office14/winword.exe
# wine ~/.msoffice/dosdevices/c:/Program Files/Microsoft Office/Office14/exel.exe

# wine "/home/mikl/.wine32/drive_c/Program Files/Microsoft Office/Office12/WINWORD.exe"
# 
