#! /bin/bash
add_user () 
{
if [ ! -e users.data ];then
  touch users.data
fi
echo "Please Provide Information To Add User Details"
read -p "Enter Your Firstname:" fname
read -p "Enter Your Lastname:" lname
read -p "Enter Your U.ID:" uid
count=$(cat users.data |cut -d ":" -f 1 | grep -w $uid | wc -l)
if [ $count -ne 0 ]; then
echo "$uid already exists"
echo
echo "----------------------------"
return 1
fi
read -s -p "Enter Your Password:" passw
echo
read -p "Retype Your Password:" cpwd
if [ $passw -ne $cpwd ];then
echo "Passwords are not matching, We cannot add user" 
echo
echo "----------------------------------------"
return 2
fi
read -p "Enter ur Environment" env
echo "$uid:$fname:$lname:$passw:$env" >> users.data
echo "User Added Successfully"
echo
}
search_user ()
{
 read -p "Enter Your U.ID:" uid
 count=$(cat users.data | grep -w $uid | wc -l)
 if [ $count -eq 0 ]; then
 echo "$uid user doesnot exists"
 return 3
 fi
 read -p "Enter Your Password:" passw
 count=$(cat users.data | grep -w $uid | cut -d ":" -f 4 | grep -w $passw | wc -l )
 if [ $count -eq 0 ]; then
 echo "Invalid Password"
 return 4
 fi
 while read line
 do
 fuid=$(echo $line | cut -d ":" -f 1)
 fpassw=$(echo $line | cut -d ":" -f 4)
 if [ $uid = $fuid -a $passw = $fpassw ];then
 echo "The Complete information of the user is:"
 echo "User Id:$(echo $line | cut -d ":" -f 1)"
 echo "Password:$(echo $line | cut -d ":" -f 4)"
 echo "First Name:$(echo $line | cut -d ":" -f 2)"
 echo "Last Name:$(echo $line | cut -d ":" -f 3)"
 echo "Environment:$(echo $line | cut -d ":" -f 5)"
 echo
 echo
 break 
 fi
 done < users.data
}
change_password ()
{
 read -p "Enter Ur user id:" uid
 count=$(cat users.data | cut -d ":" -f 1 | grep -w $uid | wc -l)
 if [ $count -eq 0 ]; then
 echo "$uid user doesnot exists,can't change password"
 return 3
 fi
 read -p "Enter Your Password:" passw
 count=$(cat users.data | grep -w $uid | cut -d ":" -f 4 | grep -w $passw | wc -l )
 if [ $count -eq 0 ]; then
 echo "Invalid Password"
 return 4
 fi
 while read line
 do
 fuid=$(echo $line | cut -d ":" -f 1)
 fpassw=$(echo $line | cut -d ":" -f 4)
  if [ $uid = $fuid -a $passw = $fpassw ] ; then
   grep -v $line users.data > temp.data
   record=$line
   break
  fi
 done < users.data
 mv temp.data users.data
 read -p "Enter New Password:" npwd
 uid=$(echo $record | cut -d ":" -f 1)
 fname=$(echo $record | cut -d ":" -f 2)
 lname=$(echo $record | cut -d ":" -f 3)
 env=$(echo $record | cut -d ":" -f 5)
 echo "$uid:$fname:$lname:$npwd:$env" >> users.data
 echo "Password changed successfully"
 echo
 echo
 }
 delete_user ()
{
read -p "Enter User Id: " uid
 count=$(cat users.data | cut -d ":" -f1 | grep -w $uid | wc -l)
 if [ $count -eq 0 ]; then
 echo "User Id: $uid does not exist, Cannot Delete User"
 echo
 return 5
 fi
 read -p "Enter your Password:" passw
 count=$(cat users.data | grep -w $uid | cut -d ":" -f 4 | grep -w $passw | wc -l)
 if [ $count -eq 0 ]; then
 echo "Wrong password, Cannot Delete User"
 echo
 return 6
 fi
 while read line
 do
 fuid=$(echo $line | cut -d ":" -f1)
 fpwd=$(echo $line | cut -d ":" -f4)
 if [ $uid = $fuid -a $passw = $fpwd ]; then
 grep -v $line users.data > temp.data
 break
 fi
 done < users.data
 mv temp.data users.data
 echo "user deleted successfully"
 echo
 echo
 }
show_all_users ()
 {
  echo "Total no of users available are:" 
  echo "-------------------------------:"
  nu=$(cat users.data | cut -d ":" -f1 | wc -l)
  echo "No of users Available are: $nu "
  echo "List of users availavle are:"
  echo "----------------------------"
  cat users.data
  echo
 }
echo "WELCOME TO USER MANAGEMNT APPLICATION"
echo "#####################################"
while [ true ]
do
echo "1. Add User"
echo "2. Search For User"
echo "3. Change Password"
echo "4. Delete User"
echo "5. Show All Users"
echo "6. Exit"
read -p "Enter Your Choice [1|2|3|4|5|6|]:" choice
 case $choice in
 1 )
 add_user
 ;;
 2 )
 search_user
 ;;
 3 )
 change_password
 ;;
 4 )
 delete_user 
 ;;
 5 ) 
 show_all_users
 ;;
 6 )
 echo "Thanks for using application"
 break
  ;;
  * )
   echo "U Entered Wrong Option"
 esac
done

