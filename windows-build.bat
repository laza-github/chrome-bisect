rmdir /q /s chrome-bisect
rmdir /q /s chrome-bisect-64
rmdir /q /s build
rmdir /q /s dist
del /q /f chrome-bisect-%1-windows.zip
del /q /f chrome-bisect-%1-windows-x64.zip
del /q /f chrome-bisect-%1-windows-x64.msi
del /q /f *.wixobj
del /q /f *.wixpdb

c:\python27-32\scripts\pyinstaller --clean -F --distpath=chrome-bisect windows.spec
xcopy LICENSE chrome-bisect\
del gam\w9xpopen.exe
"%ProgramFiles%\7-Zip\7z.exe" a -tzip chrome-bisect-%1-windows.zip chrome-bisect\ -xr!.svn

c:\python27-64\scripts\pyinstaller --clean -F --distpath=chrome-bisect-64 windows.spec
xcopy LICENSE chrome-bisect-64\
"%ProgramFiles%\7-Zip\7z.exe" a -tzip chrome-bisect-%1-windows-x64.zip chrome-bisect-64\ -xr!.svn

set CBVERSION=%1
"%ProgramFiles(x86)%\WiX Toolset v3.10\bin\candle.exe" -arch x64 chrome-bisect.wxs
"%ProgramFiles(x86)%\WiX Toolset v3.10\bin\light.exe" -ext "%ProgramFiles(x86)%\WiX Toolset v3.10\bin\WixUIExtension.dll" chrome-bisect.wixobj -o chrome-bisect-%1-windows-x64.msi
del /q /f chrome-bisect-%1-windows-x64.wixpdb