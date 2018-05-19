#python -m http.server 8000 --bind 127.0.0.1
from bottle import route, run, debug, template, request, static_file, error ,get,post,response,redirect

# only needed when you run Bottle on mod_wsgi
from bottle import default_app
import datetime
import mysql.connector
import collections
from mysql.connector import errorcode
from  more_itertools import unique_everseen
#current_students

config = {
  'user': 'root',
  'password': 'root',
  'host': '127.0.0.1',
  'database': 'hms',
  'raise_on_warnings': True,
}
cnx = mysql.connector.connect(**config)






from bottle import static_file
@route('/static/<filepath:path>')
def server_static(filepath):
    return static_file(filepath, root='static') # use static or ./static, / implies absolute path















@route('/ajax_student_added')
def ajax_student_added():
    return 'The new student was inserted into the database'


@get('/')
def just_get():
    redirect('/index')

@get('/index')
def index_get():
    if(request.get_cookie("user") is None):
        redirect('/login')
    

    
    

    return template('tpl/index',lolcat=request.get_cookie("user"),str="Successfully logged in as {}".format(request.get_cookie("user")))
    
    



@get('/logout')
def logout_get():
    response.set_cookie("user","",expires=0)
    return "Logged out."


@get('/login')
def login_get():

    
    

    return template('tpl/login')



@post('/login')
def login_post():
    c = cnx.cursor()
    
    c.execute("SELECT 1 FROM student where roll_no={} and year!='0' ".format(request.POST.get('1')))
    result = c.fetchone()
    
    c.close()
    if((result is None) and request.POST.get('1')!='0'):
        return {'text':"Roll no. doesn't exist "}
    if(request.POST.get('1')!=request.POST.get('2')):
        return {'text':"Incorrect Password"}
    else:
        response.set_cookie("user",request.POST.get('1'))
        #return "Successfully logged in as {}. ".format(request.POST.get('1'))
        return {'redirect':"/index"}
        




@get('/next_year')
def next_year_get():
    if(request.get_cookie("user") is None):
        redirect('/login')
    if(request.get_cookie("user")!='0'):
        return "Access denied."

    
    

    return template('tpl/next_year')


@post('/next_year')
def next_year_post():
    """Check to see if an uploaded file contains
    a target string 'Bobalooba'"""

    upload = request.files.get('newfile')

    # only allow upload of text files
    if upload.content_type != 'text/plain':
        return "Only text files allowed"



    output="Done ."


    c=cnx.cursor()

    for line in upload.file.readlines():
        

        query="""call fail({});""".format(line.decode())
        try:
            c.execute(query)
        except mysql.connector.Error as err:
            output= "Failed failing  student {} in database: {} <br/>".format(line.decode(),err) + output
    

    cnx.commit()
    c.close()



    c=cnx.cursor()

    query="""call forward()"""
    try:
        c.execute(query)
    except mysql.connector.Error as err:
        return ("Failed forward student in database: {}".format(err))
    cnx.commit()
    c.close()


    return output







@get('/show_students')
def show_students():
    if(request.get_cookie("user") is None):
        redirect('/login')
    if(request.get_cookie("user")!='0'):
        return "Access denied."

    
    c = cnx.cursor()
    
    c.execute("SELECT * FROM student ")
    result = c.fetchall()
    c.execute("SELECT column_name from information_schema.columns where table_name='student' and table_schema='hms'")
    column_names=c.fetchall()
    c.close()

    output = template('tpl/make_table', rows=result,columns=column_names,lolcat=request.get_cookie("user"))
    return output
# note that %s evaluates to 'string' not string



@get('/show_hostel')
def show_hostel():

    
    c = cnx.cursor()
    
    try:
        c.execute("SELECT * FROM hostel ")
    except mysql.connector.Error as err:
        return ("Failed fetching from table hostel: {}".format(err))
    result = c.fetchall()
    cnx.commit()
    c.close()

    c = cnx.cursor()
    
    try:
        c.execute("SELECT column_name from information_schema.columns where table_name='hostel' and table_schema='hms'")
    except mysql.connector.Error as err:
        return ("Failed fetching column names of table hms.hostel, please make sure that it exists: {}".format(err))
    column_names = c.fetchall()
    cnx.commit()
    c.close()

    
    output = template('tpl/make_table', rows=result,columns=column_names,lolcat=request.get_cookie("user"))
    return output







@get('/update_gate_record')
def update_gate_record_get():
    if(request.get_cookie("user") is None):
        redirect('/login')
    if(request.get_cookie("user")!='0'):
        return "Access denied."

    
    

    return template('tpl/update_get_record',lolcat=request.get_cookie("user"))
    

@post('/update_gate_record')
def update_gate_record_post():

    if(request.POST.get('10')=='1'):
        c=cnx.cursor()

        query="""call gate_record_in({});""".format(request.POST.get('1'))
        try:
            c.execute(query)
        except mysql.connector.Error as err:
            return ("Failed making sure not 2 null entry at same time gate_record in database: {}".format(err))
        cnx.commit()
        c.close()
        c=cnx.cursor()

        query=""" INSERT into gate_record(roll_no,purpose) values ({},'{}' ) """.format(request.POST.get('1'),request.POST.get('2'))
        try:
            c.execute(query)
        except mysql.connector.Error as err:
            if err.errno == 1452:
                return ("Student doesn't exist")
    
            return ("Failed adding gate_record in database: {}".format(err))
        cnx.commit()
        c.close()

        c=cnx.cursor()

        query="""SELECT * from gate_record where roll_no={} order by exit_time desc limit 1""".format(request.POST.get('1'))
        try:
            c.execute(query)
        except mysql.connector.Error as err:
            return ("Failed fetching gate_record from database: {}".format(err))
        result = c.fetchall()
        c.execute("SELECT column_name from information_schema.columns where table_name='gate_record' and table_schema='hms'")
        column_names=c.fetchall()
        c.close()

        output = template('tpl/only_table', rows=result,columns=column_names)
        return output

    elif (request.POST.get('10')=='2'):
        c=cnx.cursor()

        query=""" call gate_record_in({}) """.format(request.POST.get('1'))
        try:
            c.execute(query)
        except mysql.connector.Error as err:
            return ("Failed updating entry time for gate_record in database: {}".format(err))
        cnx.commit()
        c.close()

        c=cnx.cursor()

        query="""SELECT * from gate_record where roll_no={} order by entry_time desc,exit_time desc limit 1""".format(request.POST.get('1'))
        try:
            c.execute(query)
        except mysql.connector.Error as err:
            return ("Failed fetching gate_record from database: {}".format(err))
        result = c.fetchall()
        c.execute("SELECT column_name from information_schema.columns where table_name='gate_record' and table_schema='hms'")
        column_names=c.fetchall()
        c.close()

        output = template('tpl/only_table', rows=result,columns=column_names)
        return output
    elif(request.POST.get('10')=='3'):
        c = cnx.cursor()

        if(request.POST.get('5') =='0' and request.POST.get('9') =='0'):
            query=""" SELECT * from current_students natural join gate_record order by roll_no asc,isnull(entry_time) desc,entry_time desc """
            
        elif(request.POST.get('5') =='0' and request.POST.get('9') =='1'):
            query=""" SELECT * from current_students natural join gate_record where isnull(entry_time) order by roll_no asc """
        elif(request.POST.get('5') =='1' and request.POST.get('9') =='0'):
            query=""" SELECT * from student natural join gate_record where roll_no={} order by isnull(entry_time) desc,entry_time desc """.format(request.POST.get('7'))
        elif(request.POST.get('5') =='1' and request.POST.get('9') =='1'):
            query=""" SELECT * from student natural join gate_record where roll_no={} and isnull(entry_time) order by entry_time desc """.format(request.POST.get('7'))

            

        try:
            c.execute(query)
        except mysql.connector.Error as err:
            return ("Failed fetching from  gate record case 3 from database: {}".format(err))
        result = c.fetchall()

        c.execute("SELECT column_name from information_schema.columns where table_name='student' and table_schema='hms'")
        column_names=c.fetchall()
        c.execute("SELECT column_name from information_schema.columns where table_name='gate_record' and table_schema='hms'")
        column_names+=c.fetchall()

        column_names=list(unique_everseen(column_names))
        column_names[0],column_names[1]=column_names[1],column_names[0]


        c.close()

        output = template('tpl/only_table', rows=result,columns=column_names)
        return output



@get('/event')
def event_get():
    if(request.get_cookie("user") is None):
        redirect('/login')
    if(request.get_cookie("user")!='0'):
        c=cnx.cursor()
        query="""SELECT hostel_id from student where roll_no={}""".format(request.get_cookie("user"))
        try:
            c.execute(query)
        except mysql.connector.Error as err:
            return ("Failed getting hostel id  from  user: {}".format(err))

        result=c.fetchone();
        c.close()



        
        c=cnx.cursor()

        query="""SELECT * from event where start_time>now() order by field(hostel_id,{},{} ,{} ) asc ,start_time desc""".format(result[0] if result[0] else 3 ,(result[0]+1)%3 if (result[0]+1)%3 else 3,(result[0]+2)%3 if (result[0]+2)%3 else 3)
        
        



        

        try:
            c.execute(query)
        except mysql.connector.Error as err:
            return ("Failed getting custom (user) event from database: {}".format(err))
        result = c.fetchall()
        c.execute("SELECT column_name from information_schema.columns where table_name='event' and table_schema='hms' ")
        column_names=c.fetchall()
        c.close()

        output = template('tpl/make_table', rows=result,columns=column_names,lolcat=request.get_cookie("user"))
        return output
        

    
    

    return template('tpl/event',lolcat=request.get_cookie("user"))




@post('/event')
def event_post():

    if(request.POST.get('10') == '1'):
        c=cnx.cursor()

        date_in = request.POST.get('2')  #u'2015-01-02T00:00' 
        date_out = datetime.datetime(*[int(v) for v in date_in.replace('T', '-').replace(':', '-').split('-')])



        query=""" INSERT into event(description,start_time,expenditure,hostel_id) values ('{}','{}',{},{} ) """.format(request.POST.get('1'),str(date_out),request.POST.get('3'),request.POST.get('4'))
        print(query)
        try:
            c.execute(query)
        except mysql.connector.Error as err:
            if err.errno == 1452:
                return ("Hostel doesn't exist")
            return ("Failed adding to event in database: {}".format(err))
        cnx.commit()
        c.close()

        c=cnx.cursor()

        query="""SELECT * from event  order by event_id desc limit 1"""
        try:
            c.execute(query)
        except mysql.connector.Error as err:
            return ("Failed fetching from  event 1 from database: {}".format(err))
        result = c.fetchall()
        c.execute("SELECT column_name from information_schema.columns where table_name='event' and table_schema='hms'")
        column_names=c.fetchall()
        c.close()

        output = template('tpl/only_table', rows=result,columns=column_names)
        return output



    elif(request.POST.get('10')=='2'):
        c=cnx.cursor()

        if(request.POST.get('5')=='0' and request.POST.get('9')=='0' ):
            query="""SELECT * from event order by event_id desc"""
        
        elif(request.POST.get('5')=='0'  and request.POST.get('9')=='1'):
            query="""SELECT * from event where start_time>now() order by start_time desc"""
        elif(request.POST.get('5')=='0' and request.POST.get('9')=='2'):
            query="""SELECT * from event where start_time<now() order by start_time desc"""
        elif(request.POST.get('5')=='1' and request.POST.get('9')=='0'):
            query="""SELECT * from event where description like '%{}%' order by event_id desc""".format(request.POST.get('1'))
        elif(request.POST.get('5')=='1' and request.POST.get('9')=='1'):
            query="""SELECT * from event where description like '%{}%' and start_time>now() order by start_time desc""".format(request.POST.get('1'))
        elif(request.POST.get('5')=='1' and request.POST.get('9')=='2'):
            query="""SELECT * from event where description like '%{}%' and start_time<now() order by start_time desc""".format(request.POST.get('1'))
        





        

        try:
            c.execute(query)
        except mysql.connector.Error as err:
            return ("Failed show_it from  event from database: {}".format(err))
        result = c.fetchall()
        c.execute("SELECT column_name from information_schema.columns where table_name='event' and table_schema='hms'")
        column_names=c.fetchall()
        c.close()

        output = template('tpl/only_table', rows=result,columns=column_names)
        return output



















@get('/courier')
def courier_get():
    if(request.get_cookie("user") is None):
        redirect('/login')
    if(request.get_cookie("user")!='0'):




        
        c=cnx.cursor()

        query="""SELECT * from courier where roll_no={} order by isnull(collected_date) desc,received_date desc""".format(request.get_cookie("user"))



        

        try:
            c.execute(query)
        except mysql.connector.Error as err:
            return ("Failed getting custom (user) courier from database: {}".format(err))
        result = c.fetchall()
        c.execute("SELECT column_name from information_schema.columns where table_name='courier' and table_schema='hms'")
        column_names=c.fetchall()
        c.close()

        output = template('tpl/make_table', rows=result,columns=column_names,lolcat=request.get_cookie("user"))
        return output

    
    

    return template('tpl/courier',lolcat=request.get_cookie("user"))

@post('/courier')
def courier_post():

    if(request.POST.get('10') == '1'):
        c=cnx.cursor()

        query=""" INSERT into courier(roll_no,description) values ({},'{}' ) """.format(request.POST.get('1'),request.POST.get('2'))
        try:
            c.execute(query)
        except mysql.connector.Error as err:
            #print(query)
            if err.errno == 1452:
                return ("Student doesn't exist")
            return ("Failed adding to courier in database: {}".format(err))
        cnx.commit()
        c.close()

        c=cnx.cursor()

        query="""SELECT * from courier where roll_no={}  order by courier_id desc limit 1""".format(request.POST.get('1'))
        try:
            c.execute(query)
        except mysql.connector.Error as err:
            return ("Failed fetching from  courier from database: {}".format(err))
        result = c.fetchall()
        c.execute("SELECT column_name from information_schema.columns where table_name='courier' and table_schema='hms'")
        column_names=c.fetchall()
        c.close()

        output = template('tpl/only_table', rows=result,columns=column_names)
        return output

    elif(request.POST.get('10')=='2') :
        c=cnx.cursor()

        query=""" call courier_col({},{}) """.format(request.POST.get('1'),request.POST.get('2'))
        try:
            c.execute(query)
        except mysql.connector.Error as err:
            return ("Failed updating collected date for courier in database: {}".format(err))
        cnx.commit()
        c.close()

        c=cnx.cursor()

        query="""SELECT * from courier where roll_no={} and courier_id={} """.format(request.POST.get('1'),request.POST.get('2'))
        try:
            c.execute(query)
        except mysql.connector.Error as err:
            return ("Failed fetching courier from database: {}".format(err))
        result = c.fetchall()
        c.execute("SELECT column_name from information_schema.columns where table_name='courier' and table_schema='hms'")
        column_names=c.fetchall()
        c.close()

        output = template('tpl/only_table', rows=result,columns=column_names)
        return output

    elif(request.POST.get('10')=='3'):
        c=cnx.cursor()

        if(request.POST.get('5')=='0' and request.POST.get('9')=='0' ):
            query="""SELECT * from courier order by roll_no asc,courier_id asc"""
        
        elif(request.POST.get('5')=='0'  and request.POST.get('9')=='1'):
            query="""SELECT * from courier where isnull(collected_date) order by roll_no asc,courier_id asc"""
        elif(request.POST.get('5')=='0' and request.POST.get('9')=='2'):
            query="""SELECT * from courier where not isnull(collected_date) order by roll_no asc,courier_id asc"""
        elif(request.POST.get('5')=='1' and request.POST.get('9')=='0'):
            query="""SELECT * from courier where roll_no={} order by isnull(collected_date) desc,courier_id desc""".format(request.POST.get('7'))
        elif(request.POST.get('5')=='1' and request.POST.get('9')=='1'):
            query="""SELECT * from courier where roll_no={} and isnull(collected_date) order by courier_id desc""".format(request.POST.get('7'))
        elif(request.POST.get('5')=='1' and request.POST.get('9')=='2'):
            query="""SELECT * from courier where roll_no={} and not isnull(collected_date) order by courier_id desc""".format(request.POST.get('7'))
        





        

        try:
            c.execute(query)
        except mysql.connector.Error as err:
            return ("Failed show_it from  courier from database: {}".format(err))
        result = c.fetchall()
        c.execute("SELECT column_name from information_schema.columns where table_name='courier' and table_schema='hms'")
        column_names=c.fetchall()
        c.close()

        output = template('tpl/only_table', rows=result,columns=column_names)
        return output













        
@get('/complaint')
def complaint_get():
    if(request.get_cookie("user") is None):
        redirect('/login')
    if(request.get_cookie("user")!='0'):


        output = template('tpl/complaint_s', rolling=request.get_cookie("user"))
        return output

    
    

    return template('tpl/complaint',lolcat=request.get_cookie("user"))


@post('/complaint')
def complaint_post():

    if(request.POST.get('10') == '1'):
        c=cnx.cursor()

        query=""" INSERT into complaint(roll_no,description) values ({},'{}' ) """.format(request.POST.get('1'),request.POST.get('2'))
        try:
            c.execute(query)
        except mysql.connector.Error as err:
            if err.errno == 1452:
                return ("Student doesn't exist")
            return ("Failed adding to complaint in database: {}".format(err))
        cnx.commit()
        c.close()

        c=cnx.cursor()

        query="""SELECT * from complaint where roll_no={}  order by complaint_id desc limit 1""".format(request.POST.get('1'))
        try:
            c.execute(query)
        except mysql.connector.Error as err:
            return ("Failed fetching from  complaint from database: {}".format(err))
        result = c.fetchall()
        c.execute("SELECT column_name from information_schema.columns where table_name='complaint' and table_schema='hms'")
        column_names=c.fetchall()
        c.close()

        output = template('tpl/only_table', rows=result,columns=column_names)
        return output

    elif(request.POST.get('10')=='2') :
        c=cnx.cursor()

        query=""" call complaint_res({},{},'{}') """.format(request.POST.get('1'),request.POST.get('2'),request.POST.get('3'))
        try:
            c.execute(query)
        except mysql.connector.Error as err:
            return ("Failed updating resolved date for complaint in database: {}".format(err))
        cnx.commit()
        c.close()

        c=cnx.cursor()

        query="""SELECT * from complaint where roll_no={} and complaint_id={} """.format(request.POST.get('1'),request.POST.get('2'))
        try:
            c.execute(query)
        except mysql.connector.Error as err:
            return ("Failed fetching complaint from database: {}".format(err))
        result = c.fetchall()
        c.execute("SELECT column_name from information_schema.columns where table_name='complaint' and table_schema='hms'")
        column_names=c.fetchall()
        c.close()

        output = template('tpl/only_table', rows=result,columns=column_names)
        return output

    elif(request.POST.get('10')=='3'):
        c=cnx.cursor()

        if(request.POST.get('5')=='0' and request.POST.get('9')=='0' ):
            query="""SELECT * from complaint order by roll_no asc,complaint_id asc"""
        
        elif(request.POST.get('5')=='0'  and request.POST.get('9')=='1'):
            query="""SELECT * from complaint where isnull(resolved_date) order by roll_no asc,complaint_id asc"""
        elif(request.POST.get('5')=='0' and request.POST.get('9')=='2'):
            query="""SELECT * from complaint where not isnull(resolved_date) order by roll_no asc,complaint_id asc"""
        elif(request.POST.get('5')=='1' and request.POST.get('9')=='0'):
            query="""SELECT * from complaint where roll_no={} order by isnull(resolved_date) desc,complaint_id desc""".format(request.POST.get('7'))
        elif(request.POST.get('5')=='1' and request.POST.get('9')=='1'):
            query="""SELECT * from complaint where roll_no={} and isnull(resolved_date) order by complaint_id desc""".format(request.POST.get('7'))
        elif(request.POST.get('5')=='1' and request.POST.get('9')=='2'):
            query="""SELECT * from complaint where roll_no={} and not isnull(resolved_date) order by complaint_id desc""".format(request.POST.get('7'))
        





        

        try:
            c.execute(query)
        except mysql.connector.Error as err:
            return ("Failed show_it from  complaint from database: {}".format(err))
        result = c.fetchall()
        c.execute("SELECT column_name from information_schema.columns where table_name='complaint' and table_schema='hms'")
        column_names=c.fetchall()
        c.close()

        output = template('tpl/only_table', rows=result,columns=column_names)
        return output








@get('/update_visitor')
def update_visitor_get():
    if(request.get_cookie("user") is None):
        redirect('/login')
    if(request.get_cookie("user")!='0'):
        return "Access denied."

    
    

    return template('tpl/update_visitor',lolcat=request.get_cookie("user"))




@post('/update_visitor')
def update_visitor_post():

    if(request.POST.get('10') == '1'):
        c=cnx.cursor()

        query=""" INSERT into visitor(name,roll_no,contact_no,purpose) values ('{}',{},{},'{}' ) """.format(request.POST.get('1'),request.POST.get('2'),request.POST.get('3'),request.POST.get('4'))
        try:
            c.execute(query)
        except mysql.connector.Error as err:
            if err.errno == 1452:
                return ("Student doesn't exist")
            return ("Failed adding to visitor in database: {}".format(err))
        cnx.commit()
        c.close()

        c=cnx.cursor()

        query="""SELECT * from visitor where roll_no={}  order by entry_time desc limit 1""".format(request.POST.get('2'))
        try:
            c.execute(query)
        except mysql.connector.Error as err:
            return ("Failed fetching from  visitor from database: {}".format(err))
        result = c.fetchall()
        c.execute("SELECT column_name from information_schema.columns where table_name='visitor' and table_schema='hms'")
        column_names=c.fetchall()
        c.close()

        output = template('tpl/only_table', rows=result,columns=column_names)
        return output

    elif(request.POST.get('10')=='2') :
        c=cnx.cursor()

        query=""" call visitor_out({},{}) """.format(request.POST.get('1'),request.POST.get('2'))
        try:
            c.execute(query)
        except mysql.connector.Error as err:
            return ("Failed updating exit time for visitor in database: {}".format(err))
        cnx.commit()
        c.close()

        c=cnx.cursor()

        query="""SELECT * from visitor where roll_no={} and visitor_id={} """.format(request.POST.get('1'),request.POST.get('2'))
        try:
            c.execute(query)
        except mysql.connector.Error as err:
            return ("Failed fetching visitor from database: {}".format(err))
        result = c.fetchall()
        c.execute("SELECT column_name from information_schema.columns where table_name='visitor' and table_schema='hms'")
        column_names=c.fetchall()
        c.close()

        output = template('tpl/only_table', rows=result,columns=column_names)
        return output
    elif(request.POST.get('10')=='3'):
        c=cnx.cursor()

        if(request.POST.get('5')=='0' and request.POST.get('6')=='0' and request.POST.get('9')=='0' ):
            query="""SELECT * from visitor order by roll_no asc,visitor_id asc"""
        
        elif(request.POST.get('5')=='0' and request.POST.get('6')=='0' and request.POST.get('9')=='1'):
            query="""SELECT * from visitor where isnull(exit_time) order by roll_no asc,visitor_id asc"""
        elif(request.POST.get('5')=='0' and request.POST.get('6')=='1' and request.POST.get('9')=='0'):
            query="""SELECT * from visitor where name like '%{}%' order by roll_no asc,isnull(exit_time) desc, entry_time desc""".format(request.POST.get('8'))
        elif(request.POST.get('5')=='0' and request.POST.get('6')=='1' and request.POST.get('9')=='1'):
            query="""SELECT * from visitor where name like '%{}%' and isnull(exit_time) order by roll_no asc,isnull(exit_time) desc, entry_time desc""".format(request.POST.get('8'))
        elif(request.POST.get('5')=='1' and request.POST.get('6')=='0' and request.POST.get('9')=='0'):
            query="""SELECT * from visitor where roll_no={} order by isnull(exit_time) desc,entry_time desc""".format(request.POST.get('7'))
        elif(request.POST.get('5')=='1' and request.POST.get('6')=='0' and request.POST.get('9')=='1'):
            query="""SELECT * from visitor where roll_no={} and isnull(exit_time) order by entry_time desc""".format(request.POST.get('7'))
        elif(request.POST.get('5')=='1' and request.POST.get('6')=='1' and request.POST.get('9')=='0'):
            query="""SELECT * from visitor where roll_no={} and name like '%{}%' order by isnull(exit_time) desc, entry_time desc""".format(request.POST.get('7'),request.POST.get('8'))
        elif(request.POST.get('5')=='1' and request.POST.get('6')=='1' and request.POST.get('9')=='1'):
            query="""SELECT * from visitor where roll_no={} and name like '%{}%' and isnull(exit_time) order by entry_time desc""".format(request.POST.get('7'),request.POST.get('8'))





        

        try:
            c.execute(query)
        except mysql.connector.Error as err:
            return ("Failed fetching from  visitor from database: {}".format(err))
        result = c.fetchall()
        c.execute("SELECT column_name from information_schema.columns where table_name='visitor' and table_schema='hms'")
        column_names=c.fetchall()
        c.close()

        output = template('tpl/only_table', rows=result,columns=column_names)
        return output


@get('/new_emp')
def new_emp_get():
    if(request.get_cookie("user") is None):
        redirect('/login')
    if(request.get_cookie("user")!='0'):
        return "Access denied."

    return template('tpl/new_emp.tpl',lolcat=request.get_cookie("user"))

@post('/new_emp')
def new_emp_post():

    slist=[]
    for i in range(1,9):
        slist.append(request.POST.get('{}'.format(i)))

    c = cnx.cursor()

    query="""INSERT INTO employee (`name`, `employee_id`,`contact_no`, `dob`, `gender`, `address`,  `designation`, `hostel_id`) 
             VALUES (""" + "%s,"*7 +"%s);"

    

    try:
        c.execute(query,slist)
    except mysql.connector.Error as err:
        return ("Failed adding employee to database: {}".format(err))
    
    cnx.commit()
    c.close()
    c=cnx.cursor()

    query="""SELECT date_of_joining,salary from employee where employee_id={} """.format(slist[1])
    try:
        c.execute(query)
    except mysql.connector.Error as err:
        return ("Failed querying to database: {}".format(err))

    result=c.fetchone()
    cnx.commit()
    c.close()

    return '<p>The new employee was inserted into the database, the joining date  is {} and salary is {} </p>'.format(result[0],result[1])




















@get('/new_student')
def new_get():
    if(request.get_cookie("user") is None):
        redirect('/login')
    if(request.get_cookie("user")!='0'):
        return "Access denied."

    return template('tpl/new_student.tpl')

@post('/new_student')
def new_post():

    slist=[]
    for i in range(1,9):
        slist.append(request.POST.get('{}'.format(i)))
    
    # s1 = request.POST.get('1')
    # s2 = request.POST.get('2')
    # s3 = request.POST.get('3')
    # s4 = request.POST.get('4')
    # s5 = request.POST.get('5')
    # s6 = request.POST.get('6')
    # s7 = request.POST.get('7')
    # s8 = request.POST.get('8')
    # s9 = request.POST.get('9')
    # s10 = request.POST.get('10')
    # s11 = request.POST.get('11')

    c = cnx.cursor()

    query="""INSERT INTO `hms`.`student` (`name`, `roll_no`, `dob`, `gender`, `address`, `contact_no`, `year`, `branch`) 
             VALUES (""" + "%s,"*7 +"%s);"

    

    try:
        c.execute(query,slist)
    except mysql.connector.Error as err:
        if err.errno==1062:
            return ("Student roll no. already exists")
        return ("Failed adding student to database: {}".format(err))
    
    cnx.commit()
    c.close()
    c=cnx.cursor()

    query="""SELECT hostel_id,flat,room from student where roll_no={} """.format(slist[1])
    try:
        c.execute(query)
    except mysql.connector.Error as err:
        return ("Failed querying to database: {}".format(err))

    result=c.fetchone()
    cnx.commit()
    c.close()

    return '<p>The new student was inserted into the database, the alloted room is {} {} {}</p>'.format(result[0],result[1],result[2])









@get('/update_student')
def update_get():
    if(request.get_cookie("user") is None):
        redirect('/login')
    if(request.get_cookie("user")!='0'):
        return "Access denied."

    return template('tpl/update_student.tpl')

@post('/update_student')
def update_post():
    c=cnx.cursor()

    query=""" UPDATE `student` SET name='{}',contact_no={},address='{}',branch='{}' WHERE `roll_no`={};""".format(request.POST.get('11'),request.POST.get('2'),request.POST.get('3'),request.POST.get('4'),request.POST.get('1'))
    try:
        c.execute(query)
    except mysql.connector.Error as err:
        return ("Failed updating student in database: {}".format(err))
    cnx.commit()
    c.close()

    c=cnx.cursor()

    query="""SELECT * from student where roll_no={} """.format(request.POST.get('1'))
    try:
        c.execute(query)
    except mysql.connector.Error as err:
        return ("Failed fetching from  student from database: {}".format(err))
    result = c.fetchall()
    c.execute("SELECT column_name from information_schema.columns where table_name='student' and table_schema='hms'")
    column_names=c.fetchall()
    c.close()

    output = template('tpl/only_table', rows=result,columns=column_names)
    
    return output
    

    


@post('/update_student_form')
def update_student_form():
    roll_no=request.POST.get('1')



    output = template('tpl/update_student_form', roll=roll_no)
    return output


@get('/search_emp')
def search_emp_get():
    if(request.get_cookie("user") is None):
        redirect('/login')
    if(request.get_cookie("user")!='0'):
        return "Access denied."

    return template('tpl/search_emp.tpl',lolcat=request.get_cookie("user"))

@post('/namesearch_emp')
def namesearch_emp():
    c=cnx.cursor()

    query=""" SELECT * from employee where name like '%{}%' """.format(request.POST.get('1'))
    try:
        c.execute(query)
    except mysql.connector.Error as err:
        return ("Failed searching employee in database: {}".format(err))

    result=c.fetchall()

    c.execute("SELECT column_name from information_schema.columns where table_name='employee' and table_schema='hms'")
    column_names=c.fetchall()

    c.close()

    output = template('tpl/only_table', rows=result,columns=column_names)
    return output


@post('/idsearch_emp')
def idsearch_emp():
    c=cnx.cursor()

    query=""" SELECT * from employee where employee_id={} """.format(request.POST.get('1'))
    try:
        c.execute(query)
    except mysql.connector.Error as err:
        return ("Failed searching employee in database: {}".format(err))

    result=c.fetchall()

    c.execute("SELECT column_name from information_schema.columns where table_name='employee' and table_schema='hms'")
    column_names=c.fetchall()

    c.close()

    output = template('tpl/only_table', rows=result,columns=column_names)
    return output

@post('/hd_emp')
def hd_emp():
    c=cnx.cursor()

    if(request.POST.get('1')=='0' and request.POST.get('2')=='0' ) :
        query=""" SELECT * from employee order by employee_id asc"""

        
    elif(request.POST.get('1')!='0' and request.POST.get('2')=='0' ):
        query=""" SELECT * from employee where hostel_id={} order by employee_id asc""".format(request.POST.get('1'))

    elif(request.POST.get('1')!='0' and request.POST.get('2')!='0' ):
        query=""" SELECT * from employee where hostel_id={} and designation='{}' order by employee_id asc""".format(request.POST.get('1'),request.POST.get('2'))
    elif (request.POST.get('1')=='0' and request.POST.get('2')!='0' ):
        query=""" SELECT * from employee where designation='{}' order by employee_id asc""".format(request.POST.get('2'))



    try:
        c.execute(query)
    except mysql.connector.Error as err:
        return ("Failed searching employee in database: {}".format(err))

    result=c.fetchall()

    c.execute("SELECT column_name from information_schema.columns where table_name='employee' and table_schema='hms'")
    column_names=c.fetchall()

    c.close()

    output = template('tpl/only_table', rows=result,columns=column_names)
    return output










@get('/search_student')
def search_get():
    if(request.get_cookie("user") is None):
        redirect('/login')
 


    return template('tpl/search_student.tpl',lolcat=request.get_cookie("user"))

@post('/namesearch_student')
def namesearch_student():

    selector='*'

    if(request.get_cookie("user")!='0'):
        selector='name,roll_no,year,branch,hostel_id,flat,room'



    



    c=cnx.cursor()

    query=""" SELECT {} from current_students where name like '%{}%' """.format(selector,request.POST.get('1'))
    try:
        c.execute(query)
    except mysql.connector.Error as err:
        return ("Failed searching student in database: {}".format(err))

    result=c.fetchall()

    c.execute("SELECT column_name from information_schema.columns where table_name='student' and table_schema='hms'")
    column_names=c.fetchall()

    c.close()

    if(request.get_cookie("user")!='0'):
        column_names=[['name'],['roll_no'],['year'],['branch'],['hostel_id'],['flat'],['room']]

    output = template('tpl/namesearch_student', rows=result,columns=column_names)
    return output


@post('/rollsearch_student')
def rollsearch_student():
    selector='*'

    if(request.get_cookie("user")!='0'):
        selector='name,roll_no,year,branch,hostel_id,flat,room'


    c=cnx.cursor()

    query=""" SELECT {} from student where roll_no={} """.format(selector,request.POST.get('1'))
    try:
        c.execute(query)
    except mysql.connector.Error as err:
        return ("Failed searching student in database: {}".format(err))

    result=c.fetchall()

    c.execute("SELECT column_name from information_schema.columns where table_name='student' and table_schema='hms'")
    column_names=c.fetchall()

    c.close()
    if(request.get_cookie("user")!='0'):
        column_names=[['name'],['roll_no'],['year'],['branch'],['hostel_id'],['flat'],['room']]

    output = template('tpl/namesearch_student', rows=result,columns=column_names)
    return output

@post('/roomsearch_student')
def roomsearch_student():
    selector='*'

    if(request.get_cookie("user")!='0'):
        selector='name,roll_no,year,branch,hostel_id,flat,room'


    c=cnx.cursor()

    if(request.POST.get('1')=='0' and request.POST.get('2')=='0' and request.POST.get('3')=='0') :
        query=""" SELECT {} from current_students """.format(selector)

        
    elif(request.POST.get('1')!='0' and request.POST.get('2')=='0' ):
        query=""" SELECT {} from current_students where hostel_id={}""".format(selector,request.POST.get('1'))

    elif(request.POST.get('1')!='0' and request.POST.get('2')!='0' and request.POST.get('3')=='0' ):
        query=""" SELECT {} from current_students where hostel_id={} and flat={}""".format(selector,request.POST.get('1'),request.POST.get('2'))
    elif (request.POST.get('1')!='0' and request.POST.get('2')!='0' and request.POST.get('3')!='0' ):
        query=""" SELECT {} from current_students where hostel_id={} and flat={} and room='{}'""".format(selector,request.POST.get('1'),request.POST.get('2'),request.POST.get('3'))
    else:
        return "Invalid choice."


    try:
        c.execute(query)
    except mysql.connector.Error as err:
        return ("Failed searching student in database: {}".format(err))

    result=c.fetchall()

    c.execute("SELECT column_name from information_schema.columns where table_name='student' and table_schema='hms'")
    column_names=c.fetchall()

    c.close()
    if(request.get_cookie("user")!='0'):
        column_names=[['name'],['roll_no'],['year'],['branch'],['hostel_id'],['flat'],['room']]

    output = template('tpl/namesearch_student', rows=result,columns=column_names)
    return output
    


@error(403)
def mistake403(code):
    return 'There is a mistake in your url!'


@error(404)
def mistake404(code):
    return 'Sorry, this page does not exist!'


debug(True)
run(reloader=True)
# remember to remove reloader=True and debug(True) when you move your
# application from development to a productive environment