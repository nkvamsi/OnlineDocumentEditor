<!doctype html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<% 
	if(request.getSession().getAttribute("user_id") == null)
		response.sendRedirect("index.jsp");
%>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Home Page</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<!-- Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<!-- font-awesome -->
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.6.3/css/all.css">
<!-- CSS -->
<link href="css/style.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Josefin+Sans:600"
	rel="stylesheet">
<script type="text/javascript">
window.onload = function () {
	/* location.href=document.getElementById("selectbox").value; */
    var fileupload = document.getElementById("FileUpload1");
    var filePath = document.getElementById("spnFilePath");
    var image = document.getElementById("imgFileUpload");
    image.onclick = function () {
        fileupload.click();
    };
};
function encodeImageFileAsURL(element) {
var file = element.files[0];
var reader = new FileReader();
reader.onloadend = function() {
var base64 = (reader.result);
document.getElementById("pic").value = base64;
var form = document.getElementById("picture");
form.submit();
}
reader.readAsDataURL(file);
}
</script>
</head>
<body>
	<!-- Main Container -->
	<div class="p-3 bg-dark text-white">Documents</div>
	<!-- nav Section -->
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item"><a class="nav-link text-dark"
					href="home.jsp">Home</a></li>
				<li class="nav-item"><a class="nav-link text-dark"
					href="shared_Docs.jsp">Shared Docs</a></li>
				<li class="nav-item"><a class="nav-link text-dark" href="LogOut.jsp">Log Out</a></li>
			</ul>
			<form action="SearchServlet" method = "POST" class="form-inline my-2 my-lg-0">
				<input class="form-control mr-sm-2" type="search" placeholder="Search" name="search">
				<button type="submit" class="btn btn-light">
					<i class="fas fa-search"></i>
				</button>
			</form>
		</div>
	</nav>
	<%
	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "root");
		String user_id = request.getSession().getAttribute("user_id").toString();
		PreparedStatement ps = con.prepareStatement("select * from document where user_id=?");
		ps.setString(1, user_id);
		PreparedStatement us = con.prepareStatement("select * from user where id=?");
		us.setString(1, user_id);
		if (request.getParameter("tag") != null) {
			ps = con.prepareStatement("select * from document where user_id=? and tag=?");
			ps.setString(1, user_id);
			ps.setString(2, request.getParameter("tag").toString());
		}
		if(request.getParameter("search") != null){
			String search = request.getParameter("search").toString();
			ps = con.prepareStatement("select * from document where (user_id = ? or id in (select doc_id from sharing where user_email = (select email from user where id = ?))) and name like '%"+search+"%';");
			ps.setString(1, user_id);
			ps.setString(2, user_id);
		}

		ResultSet rs = ps.executeQuery();
		ResultSet urs = us.executeQuery();
		urs.next();
	%>
	<!-- Banner Section -->
	<div class="p-3 bg-dark text-white">
		<div class="container">
			<div class="row">
				<div class="col-sm">
					<br><br><br><br>
					<h2 class="mb-3">Welcome</h2>
					<h3><%=request.getSession().getAttribute("name").toString()%></h3>
				</div>
				<div class="col-sm">
				<form id="picture" action="PictureServlet" method="POST">
					<% String dp = urs.getString("display_picture");
					if(dp != null){ %>
						<img class="img-circle" id="imgFileUpload" title="Change Picture" src="<%=urs.getString("display_picture") %>" style="cursor: pointer;width: 50%;border-radius: 20%">
						<span id="spnFilePath"></span>
						<input type="hidden" name= "pic" id = "pic"/>
   						<input type="file" id="FileUpload1" style="display: none" onchange="encodeImageFileAsURL(this)" />
					<% 		}
					else{%>
						<img class="img-circle" id="imgFileUpload" title="Change Picture" src="images/profile.png" style="cursor: pointer;">
						<span id="spnFilePath"></span>
						<input type="hidden" name= "pic" id = "pic"/>
   						<input type="file" id="FileUpload1" style="display: none" onchange="encodeImageFileAsURL(this)" />
					<%} %>
				</form>
				</div>
			</div>
		</div>
	</div>
	<button type="submit" class="btn btn-light ml-3 float-left"
		title="Create New Document"
		onclick="location.href = 'CreateDocument.jsp';">
		<i class="fas fa-plus"></i> New
	</button>
	<select onchange="javascript:location.href = this.value;" class="btn btn-secondary dropdown-toggle mt-2 mb-2 mr-4"
		name="tag" style="float: right;">
		<option>Select Tag</option>
		<option value="http://localhost:8080/editor/home.jsp?tag=Yellow" class="bg-warning text-dark">Yellow</option>
		<option value="http://localhost:8080/editor/home.jsp?tag=Blue" class="bg-info text-dark">Blue</option>
		<option value="http://localhost:8080/editor/home.jsp?tag=Green" class="bg-success text-dark">Green</option>
		<option value="http://localhost:8080/editor/home.jsp?tag=Red" class="bg-danger text-dark">Red</option>
		<option value="http://localhost:8080/editor/home.jsp?tag=Grey" class="bg-secondary text-dark">Grey</option>
		<option value="http://localhost:8080/editor/home.jsp?tag=None" class="text-dark bg-light">None</option>
	</select>

	<div class="bg-light">
		<div class="card-columns p-5">
			<%
				while (rs.next()) {
						String color = rs.getString("tag");
						if (color.equals("Yellow"))
							color = "warning";
						else if (color.equals("Red"))
							color = "danger";
						else if (color.equals("Blue"))
							color = "info";
						else if (color.equals("Grey"))
							color = "secondary";
						else if (color.equals("Green"))
							color = "success";
						else
							color = "light";
			%>
			<div class="card bg-<%=color%>">
				<img class="card-img-top p-3" src="images/icon.png" alt="image_icon">
				<div class="card-body">
					<a href="ViewDocument.jsp?id=<%=rs.getString("id")%>"><h5 class="card-title"><%=rs.getString("name")%></h5></a>
					<p class="card-text"><%=rs.getString("tag")%></p>	
					<form action="DeleteServlet" method="POST">
						 <input type="hidden" name="delete_id" value="<%=rs.getString("id")%>">
						<button type="submit" class="btn btn-light" title="Delete">
						<i class="fa fa-trash" aria-hidden="true"></i>
					</button>
					</form>

				</div>
			</div>
			<%
				}
			%>
		</div>
	</div>
	<%
		con.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
	%>
	<!-- Footer Section -->
	<div class="p-3 mt-3 bg-dark text-white">View Your Documents</div>
	<!-- Main Container Ends -->
</body>
</html>