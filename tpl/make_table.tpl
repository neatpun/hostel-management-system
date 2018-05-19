%x=(lolcat!='0')*1
%y='header{}'.format(x)
% include(y)




<!--
<style>
#customers {
    font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
    border-collapse: collapse;
    width: 100%;
}

#customers td, #customers th {
    border: 1px solid #ddd;
    padding: 8px;
}

#customers tr:nth-child(even){background-color: #f2f2f2;}

#customers tr:hover {background-color: #ddd;}

#customers th {
    padding-top: 12px;
    padding-bottom: 12px;
    text-align: left;
    background-color: #4CAF50;
    color: white;
}
</style>
-->


<table id="customers" class="u-full-width">
  <tr>
    %for name in columns:
    %for subname in name:
      <th>{{subname}}</th>
      %end
    %end

   

  </tr>
  %for row in rows:
  <tr>
  %for col in row:
    <td>{{col}}</td>
  %end
  </tr>
  %end
 
</table>

    

<!-- End Document
  –––––––––––––––––––––––––––––––––––––––––––––––––– -->
</body>

</html>