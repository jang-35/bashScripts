#!/bin/sh
append () {
    env=$(printenv PATH)
    app=$1
    PATH="$env:"$app""
}

prepend () {
    env=$(printenv PATH)
    pre=$1
    PATH=""$pre":$env"
}

delete() {
    del=$1
    env=$(printenv PATH)
    #convert : to \n to use grep to exclude unwanted lines (pathnames)
    #\\ in front of $del to manage special characters (ex ., $, *, etc.)
    PATH=$(echo "$env" | /usr/bin/tr ":" "\n" | /usr/bin/grep -v "^\\${del}$" | /usr/bin/tr "\n" ":")
    env=$(printenv PATH)
    f=y
    while [ $f = y ] ; do
        f=n
        echo $env | /usr/bin/grep -q ":$" #extra colons at end
        if [ "$?" -eq 0 ] ; then #grep exit code=0 => match found
            f=y
            PATH=${env%:} #remove suffix colons
            env=$(printenv PATH)
        fi
    done
}

editpath () {
    OPTIND=1
    while getopts "apd" opt ; do
    : #use getopts to advance to args
    done

    if [ "$OPTIND" -eq 1 ] ; then #no opts
        return 1 
    fi

    #store opt and get first arg
    if [ $(expr $OPTIND - 3) -ge 0 ] ; then 
        shift $(expr $OPTIND - 3)
        if [ "$2" != "--" ] ; then 
            shift
            optt=$1
            shift #at args
        else
            optt=$1
            shift 2 #at args
        fi
    else
        optt=$1
        shift #at args
    fi

    if [ "$optt" = "-a" ] ; then
        while [ "$#" '-gt' 0 ] ; do
            append "$1"
            shift 
        done

    elif [ "$optt" = "-d" ] ; then
        while [ "$#" '-gt' 0 ] ; do
            delete "$1"
            shift 
        done

    elif [ "$optt" = "-p" ] ; then
        while [ "$#" '-gt' 0 ] ; do
            prepend "$1"
            shift 
        done
    fi
}



