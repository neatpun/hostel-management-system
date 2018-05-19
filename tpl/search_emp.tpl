%x=(lolcat!='0')*1
%y='header{}'.format(x)
% include(y)





<div class="row">
<div class="four columns">
<form id="namesearch" action="/namesearch_emp" method="POST">
  <label for="sname">Name</label>
  <input class="u-full-width" type="text" id="sname" maxlength="39" name="1"/>
  <input class="button-primary" type="submit" name="search" value="Search">

</form>
</div>
<div class="four columns">
<form id="rollsearch" action="/idsearch_emp" method="POST">
  <label for="sroll">Employee id.</label>
  <input class="u-full-width" type="number" id="sroll" max="999999999" name="1"/>
  <input class="button-primary" type="submit" name="search" value="Search">

</form>
</div>
<div class="four columns">
<form id="roomsearch" action="/hd_emp" method="POST">
  
      <label for="shid">Hostel </label>
      <select class="u-full-width" id="shid" name="1">
      <option value="0">Any</option>

          <option value="1">Hall of residences</option>
          <option value="2">Studio Apartments</option>
          <option value="3">Silver Springs</option>
      </select>
    
    
      <label for="syear">Designation</label>
      <select class="u-full-width" id="syear" name="2">
      <option value="0">Any</option>
        <option value="cleaning">cleaning</option>
        <option value="warden">warden</option>
        <option value="mess">mess</option>
        <option value="office">office</option>
        <option value="other">other</option>
      </select>
    
    
    
  <input class="button-primary" type="submit" name="search" value="Search">
</form></div>
</form>
</div>
<div id='ajax_success' class="u-full-width"></div>


<script type="text/javascript">
    var frm = $('#namesearch');

    frm.submit(function (e) {

        e.preventDefault();

        $.ajax({
            type: frm.attr('method'),
            url: frm.attr('action'),
            data: frm.serialize(),
            success: function (data) {

              
                var output = data;
                document.getElementById("ajax_success").innerHTML =  output ;
              
$('html, body').animate({
    scrollTop: ($("#navid").offset().top ) 
}, 'slow');

                console.log('Submission was successful.');
                console.log(data);
            },
            error: function (data) {
              alert("error");
                console.log('An error occurred.');
                console.log(data);
            },
        });

    });
</script>
<script type="text/javascript">
    var frm2 = $('#rollsearch');

    frm2.submit(function (e) {

        e.preventDefault();

        $.ajax({
            type: frm2.attr('method'),
            url: frm2.attr('action'),
            data: frm2.serialize(),
            success: function (data) {

              
                var output = data;
                document.getElementById("ajax_success").innerHTML =  output ;

              $('html, body').animate({
    scrollTop: ($("#navid").offset().top ) 
}, 'slow');


                console.log('Submission was successful.');
                console.log(data);
            },
            error: function (data) {
              alert("error");
                console.log('An error occurred.');
                console.log(data);
            },
        });

    });
</script>
<script type="text/javascript">
    var frm3 = $('#roomsearch');

    frm3.submit(function (e) {

        e.preventDefault();

        $.ajax({
            type: frm3.attr('method'),
            url: frm3.attr('action'),
            data: frm3.serialize(),
            success: function (data) {

              
                var output = data;
                document.getElementById("ajax_success").innerHTML =  output ;
                $('html, body').animate({
    scrollTop: ($("#navid").offset().top ) 
}, 'slow');
              


                console.log('Submission was successful.');
                console.log(data);
            },
            error: function (data) {
              alert("error");
                console.log('An error occurred.');
                console.log(data);
            },
        });

    });
</script>
<!--
<form id="reg" action="/new_student" method="POST" ><!- - onsubmit=func()- ->
  <label for="sname">Name</label>
  <input class="u-full-width" type="text" id="sname" maxlength="39" name="1"/>

  <div class="row">
    <div class="six columns">
      <label for="sroll">Roll no.</label>
      <input class="u-full-width" type="number" id="sroll" maxlength="10" name="2"/>
    </div>
    <div class="six columns">
      <label for="scon">Contact no.</label>
      <input class="u-full-width" type="number" id="scon" maxlength="10" name="6"/>
    </div>
  </div>

  <div class="row">
    <div class="six columns">
      <label for="sdob">Date of birth</label>
      <input class="u-full-width" type="date" id="sdob"  name="3"/>
    </div>
    <div class="six columns">
      <label for="sgender">Gender</label>
      <select class="u-full-width" id="sgender" name="4">
        <option value="f">Female</option>
        <option value="m">Male</option>
      </select>
    </div>
  </div>

  <label for="sadd">Address</label>
  <textarea class="u-full-width" id="sadd" name="5" maxlength="190"></textarea>

  <div class="row">
    <div class="six columns">
      <label for="syear">Year</label>
      <select class="u-full-width" id="syear" name="7">
        <option value="1">First</option>
        <option value="2">Second</option>
        <option value="3">Third</option>
        <option value="4">Fourth</option>
      </select>
    </div>
    <div class="six columns">
      <label for="sbranch">Branch</label>
      <select class="u-full-width" id="sbranch" name="8">
        <option value="cse">CSE</option>
        <option value="ee">EE</option>
        <option value="me">ME</option>
        <option value="ce">CE</option>
        <option value="mems">MEMS</option>
      </select>
    </div>
  </div>




  <div class="row">
    <div class="four columns">
      <label for="shid">Hostel </label>
      <select class="u-full-width" id="shid" name="9">
          <option value="1">Hall of residences</option>
          <option value="2">Studio Apartments</option>
          <option value="3">Silver Springs</option>
      </select>
    </div>
    <div class="four columns">
      <label for="sflat">Flat no.</label>
      <input class="u-full-width" type="number" id="sflat" min="100" max="999" placeholder="100-999"  name="10"/>
    </div>
    <div class="four columns">
      <label for="sroom">Room </label>
      <select class="u-full-width" id="sroom" name="11">
        <option value="A">A</option>
        <option value="B">B</option>
        <option value="C">C</option>
        <option value="D">D</option>
        <option value="E">E</option>
        <option value="H">H</option>
      </select>
    </div>
  </div>

  <input class="button-primary" type="submit" name="save" value="save">

</form> 


<script type="text/javascript">
    var frm = $('#reg');

    frm.submit(function (e) {

        e.preventDefault();

        $.ajax({
            type: frm.attr('method'),
            url: frm.attr('action'),
            data: frm.serialize(),
            success: function (data) {

              
                var output = data;
                document.getElementById("ajax_success").innerHTML = '<h5><i>' + output + '</i></h5>';
               $('html, body').animate({
    scrollTop: $("#ajax_success").offset().top - ($("#all").offset().top - $("#all").scrollTop()) -100
}, 'slow');


                console.log('Submission was successful.');
                console.log(data);
            },
            error: function (data) {
              alert("error");
                console.log('An error occurred.');
                console.log(data);
            },
        });

    });
</script>
</div>
<!- -       <form>
  <div class="row">
    <div class="six columns">
      <label for="exampleEmailInput">Your email</label>
      <input class="u-full-width" type="email" placeholder="test@mailbox.com" id="exampleEmailInput">
    </div>
    <div class="six columns">
      <label for="exampleRecipientInput">Reason for contacting</label>
      <select class="u-full-width" id="exampleRecipientInput">
        <option value="Option 1">Questions</option>
        <option value="Option 2">Admiration</option>
        <option value="Option 3">Can I get your number?</option>
      </select>
    </div>
  </div>
  <label for="exampleMessage">Message</label>
  <textarea class="u-full-width" placeholder="Hi Dave …" id="exampleMessage"></textarea>
  <label class="example-send-yourself-copy">
    <input type="checkbox">
    <span class="label-body">Send a copy to yourself</span>
  </label>
  <input class="button-primary" type="submit" value="Submit">
</form> - ->-->



    
</div>
<!-- End Document
  –––––––––––––––––––––––––––––––––––––––––––––––––– -->
</body>


</html>