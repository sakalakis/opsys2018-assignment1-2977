#!/bin/bash
#: Title :script1
#: Date : 2018-12-2
#: Author : "Sakalakis Evangelos"
#: Version : 0.99beta
#: Description : reads info from file sources.txt, compares with info on the file database.txt and prints according to
#: directions of assignment.
#: Options : None

export input1=$HOME/sources.txt

while IFS=' ' read
do
        if grep -Fq "$REPLY" $HOME/database.txt
        then
                #calculate the new md5 sum and store to the swap file
                var2="curl -s $REPLY|md5sum|cut -d ' ' -f 1"
                eval $var2 >md5swap.dat
                link=$(head -1 md5swap.dat)
                #edw tha epaize kalytera me awk alla eipate na min tin xrisimopoiisoume
                while IFS=" " read -r website1 hash1
                do
                        if ["$REPLY"="$website1"] && ["$hash1" != "$link"]
                        then
                                echo "$REPLY"
                                #replace the previous hash with the new one
                                sed -i -e 's/"$hash1"/"$link/g' database.txt
                        fi
                done < database.txt
        else
                echo "$REPLY INIT"
                var2="curl -s $REPLY|md5sum|cut -d ' ' -f 1"
                eval $var2 >md5swap.dat
                link=$(head -1 md5swap.dat)
                echo "$REPLY $link">>database.txt
        fi
done < "$input1"
