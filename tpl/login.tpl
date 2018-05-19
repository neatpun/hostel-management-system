<!DOCTYPE html>
<html lang="en">

<!-- Mirrored from getskeleton.com/ by HTTrack Website Copier/3.x [XR&CO'2014], Sun, 15 Oct 2017 16:09:58 GMT -->
<!-- Added by HTTrack --><meta http-equiv="content-type" content="text/html;charset=utf-8" /><!-- /Added by HTTrack -->
<head>

  <!-- Basic Page Needs
  –––––––––––––––––––––––––––––––––––––––––––––––––– -->
  <meta charset="utf-8">
  <title>Skeleton: Responsive CSS Boilerplate</title>
  <meta name="description" content="">
  <meta name="author" content="">

  <!-- Mobile Specific Metas
  –––––––––––––––––––––––––––––––––––––––––––––––––– -->
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- FONT
  –––––––––––––––––––––––––––––––––––––––––––––––––– -->
  <link href='http://127.0.0.1:8000/css/fonts.css' rel='stylesheet' type='text/css'>

  <!-- CSS
  –––––––––––––––––––––––––––––––––––––––––––––––––– -->
  <link rel="stylesheet" href="http://127.0.0.1:8000/dist/css/normalize.css">
  <link rel="stylesheet" href="http://127.0.0.1:8000/dist/css/skeleton.css">
  <link rel="stylesheet" href="http://127.0.0.1:8000/css/custom.css">


  <!-- Scripts
  –––––––––––––––––––––––––––––––––––––––––––––––––– -->
  <script src="http://127.0.0.1:8000/scripts/jquery.min.js"></script>
  <script src="http://127.0.0.1:8000/scripts/run_prettify.js"></script>
  <link rel="stylesheet" href="http://127.0.0.1:8000/css/github-prettify-theme.css">
  <script src="http://127.0.0.1:8000/js/site.js"></script>

  <!-- Favicon
  –––––––––––––––––––––––––––––––––––––––––––––––––– -->
  <link rel="icon" type="image/png" href="http://getskeleton.com/dist/images/favicon.png">






  <!-- SCRIPT -->





</head>
<body class="code-snippets-visible">

  <!-- Primary Page Layout
  –––––––––––––––––––––––––––––––––––––––––––––––––– -->
  <div class="container" id="all">
    <section class="header" style="margin-top:5rem;">
      <h2 class="title">Hostel Management System</h2>


    </section>



    <!-- Why use Skeleton -->



<!-- <div class="docs-section" id="forms">
      <h6 class="docs-header">Add new student</h6>
      
      <div class="docs-example docs-example-forms">
        
<form action="/new_student" method="POST">
Name:
  <input type="text"  size="70" maxlength="70" name="name">
 <br>Roll no:
  <input type="number"  name="roll_no">
  <br>Year:
  <input type="number"  name="year">
  <br>Hostel id:
  <input type="number"  name="hostel_id">
  <br>Flat:
  <input type="number"  min="100" max="999" name="flat">
  <br>Room:
  <input type="text"  size="1" maxlength="1" name="room">
  <br>
  <input type="submit" name="save" value="save">
</form>
      </div>
      </div> -->
<!-- `name`, `roll_no`, `dob`, `gender`, `address`, `contact_no`, `year`, `branch`, `hostel_id`, `flat`, `room`)  -->

<br/>


<div class="row">

<div class="six columns offset-by-three" >
<div id='ajax_success' class="u-full-width"></div>
<form id="loginn" action="/login" method="POST">


  <label for="purp">User id.</label>
  <input class="u-full-width" type="number" id="purp" max="999999999" name="1"/>

    <label for="purp2">Password</label>
  <input class="u-full-width" type="password" id="purp2" max="999999999" name="2"/>



  <input class="button-primary" type="submit" name="search" value="Login">

</form>
</div>



</div>




<script type="text/javascript">
    var frm3 = $('#loginn');

    frm3.submit(function (e) {

        e.preventDefault();

        $.ajax({
            type: frm3.attr('method'),
            url: frm3.attr('action'),
            data: frm3.serialize(),
            success: function (data) {
              if (data.redirect) {
            // data.redirect contains the string URL to redirect to
            
            window.location.replace(data.redirect); 
        }else{


              
                var output = data.text;
                document.getElementById("ajax_success").innerHTML =  output ;
              
$('html, body').animate({
    scrollTop: ($("#navid").offset().top ) 
}, 'slow');

                console.log('Submission was successful.');
                console.log(data);}
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