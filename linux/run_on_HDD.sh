#!/bin/bash
mkdir "USB"
mkdir "USB"/"CD"
mkdir "USB"/"DVD"
for i in DVD/*.iso; do
    echo "$i"
    > "USB"/"$i"
done
for i in CD/*.iso; do
    echo "$i"
    > "USB"/"$i"
done
echo "Done!"
echo "Move the contents of the 'USB' folder to the root of the drive containing your XEB+ install"
