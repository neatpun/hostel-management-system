%include('header0.tpl')


<div id='ajax_success' class="u-full-width" ></div>

<br/>
<div class="row">
<div class="six columns">
<form id="generator" action="/update_student_form" method="POST" >
<label for="sroll">Roll no.</label>

  <input class="u-full-width" type="number" id="sroll" maxlength="10" name="1"/>
  <input class="button-primary" type="submit" name="supdate" value="Update student">

</form>
</div></div>
<div id="forumspace" class="u-full-width"></div>



<script type="text/javascript">
    var frm2 = $('#generator');


    frm2.submit(function (e) {

        e.preventDefault();

        $.ajax({
            type: frm2.attr('method'),
            url: frm2.attr('action'),
            data: frm2.serialize(),
            success: function (data) {

              
                var output = data;
                document.getElementById("forumspace").innerHTML = output;
               $('html, body').animate({
    scrollTop: ($("#navid").offset().top ) 
}, 'slow');


                console.log('Submission was successful.');
                console.log(data);
            },
            error: function (data) {
              alert("error: please provide an existing roll_no");
                console.log('An error occurred.');
                console.log(data);
            },
        });

    });
</script>
</div>
<!--       <form>
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
</form> -->



    

<!-- End Document
  –––––––––––––––––––––––––––––––––––––––––––––––––– -->
</body>


</html>