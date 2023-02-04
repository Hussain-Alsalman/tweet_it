#!/bin/bash 

# Making sure you have the requirements 

function requirements_check {

echo -e "Installing few importat requirements \n "
sudo apt install git \
curl \
autoconf \
bison \
build-essential \
libssl-dev \
libyaml-dev \
libreadline6-dev \
zlib1g-dev \
libncurses5-dev \
libffi-dev \
libgdbm6 \
libgdbm-dev \
libdb-dev \ 



    echo -e "\nRequirements checklist: "
    google_flag="(X)"
    carbon_flag="(X)"
    twurl_flag="(X)"
    if [[ ! -z $(google-chrome --version) ]] 
    then 
        google_flag="(checked)"
    fi

    if [[ ! -z $(carbon-now --version 2> /dev/null) ]] 
    then 
        carbon_flag="(checked)"
    fi

    if [[ ! -z $(twurl -v 2> /dev/null) ]] 
    then 
        twurl_flag="(checked)"
    fi

    export google_flag
    export carbon_flag
    export twurl_flag
    }
 
function installation {

    if [[ $google_flag == "(X)" ]]
    then
        sudo apt-get update
        sudo apt install google-chrome
    fi
     if [[ $carbon_flag == "(X)" ]]
    then
        git clone https://github.com/Hussain-Alsalman/carbon-now-cli.git
        cd carbon-now-cli && \ 
          npm pack . && \  
          sudo npm install -g carbon-now-cli-1.4.0.tgz && \ 
        cd .. &&  \ 
        sudo rm -r ./carbon-now-cli
    fi   
    if [[ $twurl_flag == "(X)" ]]
    then
        gem install twurl
        echo -e "\n\nYou will need to settup your authentication with twitter first"
        echo -e "\n Enter the consumer key: " 
        read consumer_key
        echo -e "\n Enter the consumer secret:" 
        read consumer_secret
        echo -e "\n Click on the link and follow the authentication process" 

        twurl authorize --consumer-key $consumer_key       \
                --consumer-secret $consumer_secret
    fi
}   
    requirements_check
    echo "google chrome  ${google_flag}"
    echo "carbon-now     ${carbon_flag}"
    echo "twurl          ${twurl_flag}"
    installation
