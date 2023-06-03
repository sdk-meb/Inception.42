#! /bin/sh

script_argc=$#   # Assigning count of script arguments to a variable

build_image() {

    if [ $# -lt 2 ]; then
        docker build $1 
    else
        docker build $1 --tag $2
    fi
}

run_conatainer() {

    IMG=$1
    docker run $2 $(docker image ls | grep $IMG | awk '{print $3}' )
}

clear_none() {

    IMG=$1
    if [ -z $1 ]; then
        IMG="none"
    fi
    docker image rm  $(docker image ls | grep $IMG | awk '{print $3}') -f 
}

get_help() {

    echo "build   PATH          [TAG='']"  
    echo "run     NAME          [OPT='']"  
    echo "clear  [NAME=none]"  
}

if [ "$1" = "clear" ]; then
    clear_none $2
elif [ "$1" = "help" ]; then
    get_help
elif [ "$1" = "run" ]; then
    run_conatainer $2 $3
elif [ "$1" = "build" ]; then
    build_image $2 $3
fi

