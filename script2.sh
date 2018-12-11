find /$HOME -type f -name "*.txt" | while read txt; do
#  echo "$txt";   # Do something else

        while IFS= read -r var1
                do
        #       echo "$var1"
                        if [["$var1" =~ \https.* ]];then
                                git clone $var1
                        fi


                done < "$txt"


 done
