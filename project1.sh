#! /bin/bash
#Rules:
#The first character of the Name should be 'd'
#The Last character of Favourite Actor should be 'r'
# The Lucky Number should be 7
# The number of characters in his favourite dish should be >=6.
#If the above conditions are satified then user is valid secret agent and share information
#about our next operation, otherwise just send thanks message.
echo "welcome to the Secret Agent Application"
echo "##############################################"
read -p "Enter ur name:" name
first_char_name=$(echo -n $name | cut -c 1 )
if [ $first_char_name != "d" ];then
 echo "Hello $name Thanks for giving information"
 exit 1
fi
read -p "Enter ur favourite actor name: " actor
len=$(echo -n $actor | wc -c )
last_char_actor=$(echo -n $actor | cut -c $len)
if [ $last_char_actor != "r" ];then
 echo "Hello $name, thanks for your information" 
 exit 1
fi
read -p "enter ur lucky number:" lucky
if [ $lucky -ne 7 ];then
 echo "Hello $name, thanks for your information" 
 exit 1
fi
read -p "Enter ur Favourite Dish:" dish
no_of_characters=$(echo $dish | wc -c )
if [ $no_of_characters -lt 6 ];then
 echo "Hello $name, thanks for your information"
 exit 1
fi
echo "Hello Secret Agent...Our Next Operation is"
echo "We have to kill atleast 10 Terrorists who are entered into country" 
