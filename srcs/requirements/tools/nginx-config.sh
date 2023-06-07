#! /usr/bin/sh - /bin/sh 

argC=$#
argV=$@

_CF_=$1 # config file

creat_file () {
    if [ -e "$_CF_" ]; then
        echo "File '$_CF_' already exists."
        read  -rep "do you wont to erase $_CF_? yes/no" -i "Default answer" response
        if [ ${response} = "no" ]; then
            exit 
        fi
        touch $_CF_
    fi
    if [ -z $1 ]; then
        chmod $2 $_CF_
    fi
    echo "#! $_CF_ configuration file, NGINX.conf" > $_CF_
    for i in {0..2}; do
        echo >> $_CF_
    done
}

Content_filling () {

    read port -rep 
    echo "listen    "

}

add_context () {
    if [ -z $1 ]; then
        exit
    fi
    echo $1 " {" > $_CF_
    echo  > $_CF_
    Content_filling 
}

add_block () {

    if [  ]; then
        echo 
    fi

}

read -rep "Question here? " -i "Default answer" cmd

case "${cmd}" in
    "")
        echo "item = 1"
        break
    ;;
    2|3)
        echo "item = 2 or item = 3"
    ;;
    *)
        echo "default (none of above)"
    ;;
esac


