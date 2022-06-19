#!/bin/bash

function todo() {
   numberOfTasks=getNumberOfTasks
   
   function displayList() { nl -s "- " .todo_list }
   function getNumberOfTasks() {
   	count=0
   	while read -r dummy
   	do
   		count=$(( count + 1 ));
   	done < .todo_list
   	numberOfTasks=$count
   }
   
   numberOfArguments=$#
   getNumberOfTasks
   
   if [[ $numberOfArguments -eq 1 ]] && [[ $1 = 'list' ]] 
   then
   	  displayList
   	  
   elif [[ $numberOfArguments -eq 2 ]] && [[ $1 = 'done' ]] && [[ $2 -le $numberOfTasks ]] && [[ $2 -gt 0 ]]
   then
   	  cutFromTop=$(( $2 - 1 ))
   	  cutFromTail=$(( $numberOfTasks - $cutFromTop - 1 ))
   	  
   	  head -n $2 .todo_list > title.txt 
   	  tail -n 1 title.txt > titleUpdated.txt
   	  
   	  taskDone=`cat titleUpdated.txt`
   	  
   	  rm title.txt
   	  rm titleUpdated.txt

   	  
   	  head -n $cutFromTop .todo_list > tempFile.txt	
	  tail -n $cutFromTail .todo_list >> tempFile.txt
	  
	  echo "La Tache ${2} ($taskDone) est faite !"
	  
	  cat tempFile.txt > .todo_list 
	  rm tempFile.txt
   
   elif [[ $1 = "add" ]]
   then
   	taskToAdd="${@:3}"

   	head -n $(( $2 - 1 )) .todo_list > addTask.txt
   	echo $taskToAdd >> addTask.txt 
   	tail -n $(( $numberOfTasks - $2 + 1 )) .todo_list >> addTask.txt
   	
   	echo "La Tache \"$taskToAdd\" a ete ajoute en position $2."
   	
   	cat addTask.txt > .todo_list
   	rm addTask.txt
   	
   fi
  
}
