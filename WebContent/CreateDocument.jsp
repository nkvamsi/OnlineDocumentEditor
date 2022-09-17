<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
    <link
      rel="stylesheet"
      href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
      integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
      crossorigin="anonymous"
    />
     <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
        crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
        crossorigin="anonymous"></script>
    <!-- font-awesome -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/"
        crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css?family=Josefin+Sans:600" rel="stylesheet">
<script src="https://cloud.tinymce.com/stable/tinymce.min.js?apiKey=qagffr3pkuv17a8on1afax661irst1hbr4e6tbv888sz91jc"></script>
<script src = "script.js"></script>
<script>
	tinymce
			.init({
				selector : 'textarea',
				height : 500,
				theme : 'modern',
				plugins : 'print preview fullpage powerpaste searchreplace autolink directionality advcode visualblocks visualchars fullscreen image link media template codesample table charmap hr pagebreak nonbreaking anchor toc insertdatetime advlist lists textcolor wordcount tinymcespellchecker a11ychecker imagetools mediaembed  linkchecker contextmenu colorpicker textpattern help',
				toolbar1 : 'formatselect | bold italic strikethrough forecolor backcolor | link | alignleft aligncenter alignright alignjustify  | numlist bullist outdent indent  | removeformat',
				image_advtab : true,
				branding: false,
				templates : [ {
					title : 'Test template 1',
					content : 'Test 1'
				}, {
					title : 'Test template 2',
					content : 'Test 2'
				} ],
				content_css : [
						'//fonts.googleapis.com/css?family=Lato:300,300i,400,400i',
						'//www.tinymce.com/css/codepen.min.css' ]
			});
</script>
<title></title>
</head>
<body class="bg-light" style="font-family: Josefin Sans, sans-serif;">
<!-- nav Section -->
<nav class="navbar navbar-expand-lg bg-dark">
       <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
           aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
           <span class="navbar-toggler-icon"></span>
       </button>
       <div class="collapse navbar-collapse" id="navbarSupportedContent">
           <ul class="navbar-nav">
               <li class="nav-item">
                   <a class="nav-link text-light" href="home.jsp">Home</a>
               </li>
               <li class="nav-item">
                   <a class="nav-link text-light" href="shared_Docs.jsp">Shared Docs</a>
               </li>
               <li class="nav-item">
                   <a class="nav-link text-light" href="LogOut.jsp">Log Out</a>
               </li>
           </ul>
       </div>
   </nav>
    <br> 
	<form action="SaveServlet" method="post">
	<span>Title : <input type="text" name="title"/></span>
	<input type="text" id="speech_text" class = "float-right">
	<button type="button" class="btn btn-light mr-3 float-right" title="Speech to Text" onclick="recognition.start()"><i class="fas fa-microphone"></i></button>
	<textarea name="content"></textarea>
	
	<br>
	<button type="submit" class="btn btn-light mr-3 float-right">Save</button>
	<select class="btn btn-light dropdown-toggle ml-3" title="Select Tag" name="tag">
	  	<option class="bg-light text-dark">None</option>
        <option class="bg-warning text-dark">Yellow</option>
        <option class="bg-info text-dark">Blue</option>
        <option class="bg-success text-dark">Green</option>
        <option class="bg-danger text-dark">Red</option>
        <option class="bg-secondary text-dark">Grey</option>
      </select>
	</form>
</body>
</html>