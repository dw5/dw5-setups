#!usr/bin/env bash

# get all directories
# directory for loop
# all files in said directory be moved elsewhere / above
# perfect for many small files scattered in bunch of folders
# later folder can be deleted once its empty

# does not folder of a folder of a folder moving files

foldyOUTFILES=$(pwd)

echo -e "Folders in: $(pwd) \n"
#ls -d ./*/

for foldyDIRS in *; do
    if [ -d "${foldyDIRS}" ]; then
        echo "START: ${foldyDIRS}" # which folder

        for foldyFILES in ${foldyDIRS}/*; do
        if [ -f "${foldyFILES}" ]; then
        echo "${foldyFILES}"   # files in folder
            mv ${foldyFILES} ${foldyOUTFILES}
        fi
        done

        ls -A ${foldyDIRS}

        if [ -z "$(ls -A ${foldyDIRS})" ]; then
            echo "OKDEL: No files found ${foldyDIRS}"
            ls ${foldyDIRS}
            mkdir ${foldyOUTFILES}/deletable ; mv ${foldyDIRS} ${foldyOUTFILES}/deletable
            else
            echo "|||| WARNING: ${foldyDIRS} Has files/folders"
            ls ${foldyDIRS}
            mkdir ${foldyOUTFILES}/foldyattention ; mv ${foldyDIRS} ${foldyOUTFILES}/foldyattention
        fi

    fi
done

