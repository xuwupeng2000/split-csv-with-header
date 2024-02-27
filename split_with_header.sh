timestamp() {
  date +"%T" # current time
}
if [ -f "$1" ]
then
  tmp_pass=`head -c 10 /dev/random | md5 | head -c 10`
  tmp_pass="UNO-${tmp_pass}-"

    f_line=$(head -n 1 $1)
    split -l $2 -d $1 $tmp_pass

    ITER="first"
    for filename in ./$tmp_pass*; do
      if test $ITER = "first"
      then
        echo "It is first"
      else
        echo "It is NOT first"
        cat <<< "${f_line}
        $(cat $filename)" > $filename
      fi
      mv $filename $filename.csv
      ITER="touched"
    done
else
    echo "File does not exist"
fi
