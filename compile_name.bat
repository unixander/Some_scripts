@echo off
if exist *.obj del *.obj
if exist *.com del *.com
if exist *.map del *.map

Set /p filename="Enter filename:"
:recompile
 tasm %filename%.asm
tlink %filename%.obj -t
:: Меню
:repeat
echo Please pick a number and hit Enter:
echo 1 - Run
echo 2 - Delete
echo 3 - Move to archive
echo 4 - Recompile
echo 5 - Exit to console
echo 6 - Exit to Windows

:: Выбор
Set /p choic=""
:: Выполнение
IF %choic%==0 (tasm %filename%.asm
tlink %filename%.obj -t
)
IF %choic%==1 %filename%.com
::удаление мусора
IF %choic%==2 (del %filename%.obj 
del %filename%.com)
::Перемещение в архив
IF %choic%==3 ( del %filename%.obj
del %filename%.com 
move %filename%.asm \files 
)
::Перекомпиляция
IF %choic%==4 GOTO :recompile
IF %choic%==5 cmd
IF %choic%==6 exit
pause
GOTO :repeat 

