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
                :
        else
                echo "$REPLY NEW"
                var2="curl -s $REPLY|md5sum|cut -d ' ' -f 1 "
                echo "$REPLY" >database.txt
                eval var2

        fi
done < "$input1"
