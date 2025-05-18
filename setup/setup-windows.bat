@echo off
color 0a
cd ..
@echo on
echo Installing dependencies.
haxelib git lime https://github.com/swordcubes-grave-of-shite/lime
haxelib run lime rebuild cpp
haxelib install openfl
haxelib install flixel
haxelib install flixel-addons
haxelib install flixel-ui
haxelib install flixel-tools
haxelib install SScript
haxelib install tjson
haxelib git flxanimate https://github.com/ShadowMario/flxanimate dev
haxelib git linc_luajit https://github.com/superpowers04/linc_luajit
haxelib git hxdiscord_rpc https://github.com/MAJigsaw77/hxdiscord_rpc
haxelib git funkin-modchart https://github.com/TheoDevelops/FunkinModchart dev
echo Finished!
pause
