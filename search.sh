#! /bin/bash

DIR=sherlock/
LOOP=true

#Optional with parameters
NAME=$@


#downloads sherlock when ist not installed
function getSherlock(){
	if [ ! -d $DIR ]
	then
	echo 'Cloning Sherlock Project'
	git clone https://github.com/sherlock-project/sherlock.git
	cd $DIR
	echo 'Installing Requirements'
	python3 -m pip install -r requirements.txt
	echo 'Done'
	else
	cd $DIR
	fi
}


#main function
function inputCore(){
	echo 'Enter commands or q to exti: '
	read NAME
	if [ $NAME = 'q' ]
	then
	read -p "Are you sure? [Y/y or N/n]" -n 1 -r
        if [[ $REPLY =~ ^[Yy]$ ]]
        then
        echo ''
        echo 'Quitting'
        LOOP=false
        else
        python3 sherlock.py $NAME
        fi
	else
	python3 sherlock.py $NAME
	fi
}

#runs on first execution 
function executeArgsFirst(){
    if [[ $NAME = '' ]]
    then
    python3 sherlock.py --help
    else
    python3 sherlock.py $NAME
    fi
    inputCore
	
}


getSherlock
executeArgsFirst

while [ $LOOP == true ]
do
	inputCore
done

