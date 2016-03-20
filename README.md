# NAME
&nbsp;&nbsp;&nbsp;**reminder** - Remind user after a specific time on Ubuntu Linux

# SYNOPSIS
&nbsp;&nbsp;&nbsp;**reminder** [**-t** <u>*time*</u>] [**-H** <u>*hour*</u>] [**-M** <u>_minute_</u>] [**-S** <u>_second_</u>] [**-h**]

# Options

&nbsp;&nbsp;&nbsp; **-h**                                            
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     Show help and exit                      
                                         
&nbsp;&nbsp;&nbsp;  **-t** <u>*time*</u>                                     
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     Remind user at time                                                     
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     (**-t** can't appear with [**-H**|**-M**|**-S**] simultaneously)                  
                                        
&nbsp;&nbsp;&nbsp;  **-H** <u>*hour*</u>                                             
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     Remind user after hour hour(s)                      
                                        
&nbsp;&nbsp;&nbsp;  **-M** <u>*minute*</u>                                                 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     Remind user after minute minute(s)               
                                        
&nbsp;&nbsp;&nbsp;  **-S** <u>*second*</u>                                               
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;     Remind user after second second(s)                      

# How to use the program?
## Prepare
Before use this program, you should give the file `reminder` execute permission:             
 
```bash      
$ chmod u+x reminder           
```
Install `mpg123`:         
        
```bash
$ sudo apt-get update
$ sudo apt-get install mpg123
```

## Example        
**See help**         
      
```bash
$ ./reminder -h
```         
**Remind user at 19:00:00**              
   
```bash          
$ ./reminder -t 19:00:00 &
```
**Remind user after 3 hours**           
       
```bash
$ ./reminder -H 3
```
