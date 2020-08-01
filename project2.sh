#! /bin/bash
#The Central library needs a way to determine the cost that a student has to pay for renting a Book
#The Fee Structure is shown in the following list:
#The cost is Rs 30 /- Per Day.
#If the Book is returned after 9 PM,the student will be charged an extra day.
#If the Book is rented on a Sunday, the student will get 50% off for as long as they keep the book.
#If the Book is rented on a Saturday, the student will get 30% ff as long as they keep the book.
#We need to write the code to meet this requiement?
echo "Welcome To Central Library"
echo "##########################################"
cost_per_day=30
echo  "plz enter day sunday-saturday otherwise it gives wrong value"
read -p "on which day book rented:" day_book_rented
read -p "How many days u Kept" days_rented
h=$(date +%H)
if [ $h -ge 21 ];then
days_rented=$[days_rented+1]
fi
if [ $day_book_rented = "sunday" ];then
cost=$(echo "$cost_per_day * $days_rented * 0.5" | bc)   
elif [ $day_book_rented = "saturday" ];then
cost=$(echo "$cost_per_day * $days_rented * 0.7" | bc)
else
cost=$(echo "$cost_per_day * $days_rented"| bc)
fi
echo "The cost of the book rental:$cost" 
orginal_cost=$[days_rented * cost_per_day]
discountF=$(echo "$orginal_cost - $cost" | bc)
discountI=$(echo "$discountF" | cut -d "." -f1)
if [ $discountI -gt 0 ];then
echo "Hello, You got Rs $discountF Discount, Enjoy.." 
fi
echo "visit Again"



