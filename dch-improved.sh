#!/bin/bash

# While loop is untidy, there is definitely a better way.
while read changelog
    do
        line=$changelog
        break
    done < ./debian/changelog

# If there is a set of parentheses in the first line:
if [[ $line =~ \(.*\) ]] 
then
    # Save the contents of the parentheses in the variable $line
    line=$(sed -e 's/^.*(// ; s/).*$//' <<< $line)

    # If there is an 8 digit number in $line:  
    if [[ $line =~ ^.*[0-9]{8}.*$ ]] 
    then
        # Save the 8 digit number in the variable $version
        datestamp=$(sed 's/^.*\([0-9]\{8\}\).*$/\1/' <<< $line)

        # Get the current date as a datestamp
        currentdate=`date +"%Y%m%d"`

        # If the 8 digit number is less than the current date:
        if [ $datestamp -lt $currentdate ]
        then
            version=$(sed "s/$datestamp.*$/$currentdate-1/" <<< $line)
            dch -v $version
        else
            # If there is a number at the end that is preceded by a hyphen
            if [[ $line =~ ^.*-[0-9]+$ ]]
            then
                # Get the number at the end that is preceded by a hyphen
                bump=$(sed 's/^.*-\([0-9]\+\)$/\1/' <<< $line)
                # Increment it
                incremented=$(($bump + 1))
                # Replace the old number with the incremented
                version=$(sed "s/-$bump$/-$incremented/" <<< $line)
                dch -v $version
            else
                dch -i
            fi
        fi
    fi
else 
    dch -i
fi
