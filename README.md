
# Hostel Management System

Front-end : Skeleton CSS framework, jQuery Back-end: Python, bottle framework Database: MySQL

Intuitive front-end for hostel administrators with extensive options to manage tasks related to events, courier, gate records, visitors, hostels, complaints, hostel employees and students. High efficiency  due to use of triggers, stored procedures and functions to minimize the info that needs to be entered by the end user. 

Lots of automation, including automatic allocation of rooms to new students. There is also another feature which will be useful at the end of academic year – automatic updating of student year info. All students who passed will have their year value updated and they will be allocated a room in appropriate hostel id depending on their new year. Students in 4th year will be marked as ex-students and their rooms will be freed.

The system also has a login for students. Students can see their own uncollected couriers, submit new complaints as well as check the status of pending ones, see events taking place in the hostel they’re residing in and search for other students to find out their rooms.

**Please see the [ project report](https://github.com/neatpun/Group_C-universal-testing-machine/tree/master/Presentation%20%26%20demo%20videos) for detailed information of all features as well as ER analysis of database.**

## Demo
### Example feature: Student entry-exit records
![GUI demonstration GIF](https://raw.githubusercontent.com/neatpun/hostel-management-system/master/Project%20Report/example_video.gif)
## Requirements

 1. MySQL Workbench
 2. Python 3
 3. [MySQL Python connector](https://dev.mysql.com/downloads/connector/python/)
 4. [Bottle Python framework](http://bottlepy.org/docs/dev/), or `pip install bottle`
 5. [More-itertools](https://github.com/erikrose/more-itertools), or `pip install more-itertools`
## Configuration instructions
Clone this repo, then:
 1. Import the sql dump from the 'Database dump' folder into MySQL. (On Windows, Server -> Database Import)
 2. Edit lines 13-19 of 'main.py' according to your MySQL config. (user,pass and host)
 3. `python main.py`will start the server and the hostel management system should be accessible at `127.0.0.1:8080`

**Note:** The login system is just for demonstration as the main aim of project was database design.   
The admin credentials by default are `user:0` and `pass:0.`  
For students, both user and pass are their roll no.


This project was done by Prathamesh (me) and Gaurav. 
We did the database design together, then I implemented the system, using python for back-end and skeleton framwork & jQuery for the front-end.
