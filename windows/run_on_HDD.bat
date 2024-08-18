@echo off
mkdir "USB"
mkdir "USB\CD"
mkdir "USB\DVD"
for %%i in (DVD\*.iso) do (
    echo %%i
    echo off > "USB\%%i"
)
for %%i in (CD\*.iso) do (
    echo %%i
    echo off > "USB\%%i"
)
echo Done!
echo Move the contents of the 'USB' folder to the root of the drive containing your XEB+ install
