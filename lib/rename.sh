find ./ -name "*.c"  | while read i
do
        echo "$i";
        mv $i  "$i"c
done