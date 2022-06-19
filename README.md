# TodoList in Bash
Student Name: Talal Badreddine

# Code Job:
The code is a simple todo list written in shell, where the user is able to check and add/remove tasks by index.

# How To Run The run:
### Note: All these code must be applied in the terminal
1-Open terminal and navigate to the folder directory
<br>
2-Use ``` source todo.sh ``` to be able to execute function from the script
<br>
3-Use ```todo list```  To check the current tasks
<br>
4-Use ```todo done <number>``` to remove task from the todo list as a completed task. note: replace <number> by the index of the done task
<br>
5-Use ```todo add <number> <task details>``` to add task to the list at the <number> index. note: replace <task details> with the task
<br>

# How the code run
``` 
  function displayList() {
       nl -s "-" .todo_list 
  } 
  ```
  ``` nl ``` is used to display the content of the .todo_list file with number of lines, ``` -s "-" ``` is used to add dash after enumerating the lines
  <br>
  
  ``` 
     function getNumberOfTasks() {
   	count=0
   	while read -r dummy
   	do
   		count=$(( count + 1 ));
   	done < .todo_list
   	numberOfTasks=$count
   }
   ```
   This function is used to get number of lines (tasks) in the .todo_list file
   <br>
  
  #### Note: these function are inner function so the user will not be able to call them
  
  ``` 
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
```
                    
