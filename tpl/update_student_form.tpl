<form id="reg" action="/update_student" method="POST" ><!-- onsubmit=func()-->

<input class="u-full-width" type="number" id="rolli" maxlength="10" name="1" value={{roll}} style="display: none;" />
<div class="row">
  <label for="sname">Name</label>
  <%
  config = {
  'user': 'root',
  'password': 'not@SQL',
  'host': '127.0.0.1',
  'database': 'hms',
  'raise_on_warnings': True,
}
import mysql.connector
import collections
from mysql.connector import errorcode
cnx = mysql.connector.connect(**config)


 c = cnx.cursor()
  query="""SELECT name from student where roll_no={} """.format(roll)
    c.execute(query)


    result=c.fetchone()
    c.close()
    %>
  <input class="u-full-width" type="text" id="sname" maxlength="39" name="11" value={{result[0]}} />
</div>
<%
 c = cnx.cursor()
  query="""SELECT contact_no from student where roll_no={} """.format(roll)
    c.execute(query)


    result=c.fetchone()
    c.close()
    %>
  <div class="row">
    
    
      <label for="scon">Contact no.</label>
      <input class="u-full-width" type="number" id="scon" maxlength="10" name="2" value={{result[0]}} />
    
  </div>
<%
 c = cnx.cursor()
  query="""SELECT address from student where roll_no={} """.format(roll)
    c.execute(query)


    result=c.fetchone()
    print(result)
    c.close()
    %>
<div class="row">
  <label for="sadd">Address</label>
  
  <textarea class="u-full-width" type="text" id="sadd" name="3" maxlength="190" >{{result[0]}}</textarea>
</div>


<%
 c = cnx.cursor()
  query="""SELECT branch from student where roll_no={} """.format(roll)
    c.execute(query)


    result=c.fetchone()
    c.close()
    %>
  <div class="row">
    
    
      <label for="sbranch">Branch</label>
      <select class="u-full-width" id="sbranch" name="4" value={{result[0]}}>
        <option value="cse">CSE</option>
        <option value="ee">EE</option>
        <option value="me">ME</option>
        <option value="ce">CE</option>
        <option value="mems">MEMS</option>
      </select>
    
  </div>






  <input class="button-primary" type="submit" name="save" value="Update">

</form>



