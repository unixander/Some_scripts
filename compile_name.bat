@echo off
echo /////////////////////////////////////////////
echo //        Compile Helper v 1.0             //
echo //author: unixander                        //
echo //site: unixander.org.ua                   //
echo //Description:                             //
echo //Compile .asm files with tasm or masm     //
echo /////////////////////////////////////////////
if exist *.obj del *.obj
if exist *.com del *.com
if exist *.map del *.map
Set /p filename="Enter filename:"
echo Choose compiler:
echo 1-tasm
echo 2-masm
Set /p comp=">"
if %comp%==2 goto masm
:recompile
 tasm %filename%.asm
tlink %filename%.obj -t
:: Menu
:repeat
echo ===================================
echo Please pick a number and hit Enter:
echo 1 - Run
echo 2 - Delete
echo 3 - Move to archive
echo 4 - Recompile
echo 5 - Exit to console
echo 6 - Exit to Windows

:: Make choice
Set /p choice=">"
cls
:: Executing
IF %choice%==0 (tasm %filename%.asm
tlink -t %filename%.obj 
)
IF %choice%==1 %filename%.com
::Delete garbage
IF %choice%==2 (del %filename%.obj 
del %filename%.com)
::Move to archive
IF %choice%==3 ( del %filename%.obj
del %filename%.com 
move %filename%.asm \files 
)
::Recompile
IF %choice%==4 GOTO :recompile
IF %choice%==5 cmd
IF %choice%==6 exit
pause
GOTO :repeat 

:: MASM
:masm
Echo Enter full path
Set /p path=">"
:: Menu
:repeat_masm
echo ===================================
echo Please pick a number and hit Enter:
echo 1 - Run
echo 2 - Delete
echo 3 - Move to archive
echo 4 - Recompile
echo 5 - Exit to console
echo 6 - Exit to Windows

:: Make choice
Set /p choice=">"
cls
:: Executing
IF %choice%==0 (%path%\bin\ml /c /coff %filename%.asm
%path%\bin\PoLink /SUBSYSTEM:WINDOWS %filename%.obj 
)
IF %choice%==1 %filename%.exe
::Delete garbage
IF %choice%==2 (del %filename%.obj 
del %filename%.exe)
::Move to archive
IF %choice%==3 ( del %filename%.obj
del %filename%.exe 
move %filename%.asm \files 
)
::Recompile
IF %choice%==4 (%path%\bin\ml /c /coff %filename%.asm
%path%\bin\PoLink /SUBSYSTEM:WINDOWS %filename%.obj 
)
IF %choice%==5 cmd
IF %choice%==6 exit
pause
GOTO :repeat_masm
