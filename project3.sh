 #! /bin/bash
 add_book()
 {
 read -p "Enter Name of the Book to Add:" newBook
 books[$i]=$newBook
 let i++
 echo "$newBook Book Added Successfully"
 echo
 }
 delete_book()
{
 read -p "Enter Name of the Book to delete:" book_to_delete
 available="no"
 for index in ${!books[@]}
 do
 if [ ${books[$index]} = $book_to_delete ]; then
 available="yes"
 unset books[$index]
 echo "$book_to_delete Book Deleted Successfully"
 echo
 break
 fi
 done
 if [ $available = "no" ]; then
 echo "$book_to_delete Book is not available, cannot be deleted"
 echo
 fi

}
 list_books()
{
 if [ ${#books[@]} -eq 0 ]; then
 echo "No Books are Available"
 echo
 return 1
 fi
 echo "List Of All Available Books:"
 echo "----------------------------"
 for book in ${books[@]}
 do
 echo $book
 done
 echo
}
 echo "Welcome to 'SHIVA SAI' Book Management Application"
 echo "################################################"
 declare -a books
 i=0
 while [ true ]
 do
 read -p "Which Operation you want to perform [add|delete|list|exit]:" option
 case $option in
 add)
 add_book
 ;;
 delete)
 delete_book
 ;;
 list)
 list_books
  ;;
 exit)
 echo "Thanks for using Our Application"
 exit 0
 ;;
 *)
 echo "Wrong Option, Try Again"
 esac
 done 
 
