#!/bin/bash
# Title:
#Share your code in a nicely frommatted manner right from the command-line-interface 

# Description:
# If you are vim person and spend too much on the command-line-interface
# I brought twitter for you to post your code right from where you are "terminal"

# Usage
# script + path-to-code + message 

#Example 
# . ./tweet_it.sh ./tweet_it.sh "This tweet is right from the comman-line-interface of my little raspberry pi because why not"
function check_it
{
	if [[ -z $1 ]] 
	then 
		echo "- Please provide the file name"
		exit
	elif [[ ! -f $1 ]]
	then
		echo "- Could not find a file named \"$1\"" 
		exit
	elif [[ ! -s $1 ]]
	then
		echo "- File is empty"
		exit
	else
		echo  "- File checked (ok)"
	fi

	if [[ ! -z $(twurl -v) ]]
	then 
		echo "- twurl is installed" 
	else
		echo "- Please install twurl"
	       	exit	
	fi

	if [[ ! -z $(carbon-now --version  2> /dev/null) ]]
	then 
		echo "- carbon-now is installed"
	else
		echo "- Please install carbon-now"
		exit
	
	fi

}

if [[ ! $TWITTER_CHECKED == "OK" ]] 
then
	check_it $1
	TWITTER_CHECKED="OK"	
	export TWITTER_CHECKED 
	
fi

tmp_dir=$(mktemp -d -t tmpD.XXXXXXX)
tmp_name=$(mktemp -t tmpf-XXXXXXX)
file_name=$(basename $(echo $tmp_name))

carbon-now -h --location $tmp_dir --target $file_name $1 

media_id=$(twurl -H "upload.twitter.com" -X POST "/1.1/media/upload.json" --file \
	$(echo -en "$tmp_dir/$file_name.png") --file-field "media" | \
	python3 -c "import sys, json; print(json.load(sys.stdin)['media_id'])")

twurl -q "/1.1/statuses/update.json" -d "media_ids=$media_id&status=$(echo -e $2)"
