<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<base href="${pageContext.servletContext.contextPath}/">
<style type="text/css">
.home {
	font-size: large;
	font-weight: bold;
	color: #828284;
}

.home:hover {
	color: #FF4E00;
}

::placeholder {
	opacity: 0.5;
}

*[id$=errors], .error {
	color: red;
	font-style: italic;
}

.success {
	color: green;
	font-style: italic;
}
</style>
<script>
	addEventListener("load", function() {
		setTimeout(hideURLbar, 0);
	}, false);
	function hideURLbar() {
		window.scrollTo(0, 1);
	}
</script>
<!-- <link href="css/login-register.css" rel='stylesheet' type='text/css'
	media="all" /> -->
<link href="css/style-login-register.css" rel='stylesheet'
	type='text/css' media="all" />
<link href="css/all.css" rel="stylesheet">

<link
	href="https://fonts.googleapis.com/css?family=Pacifico&display=swap&subset=vietnamese"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css?family=Josefin+Sans:400,400i,700,700i&display=swap&subset=vietnamese"
	rel="stylesheet">
</head>
<!-- This snippet uses Font Awesome 5 Free as a dependency. You can download it at fontawesome.io! -->
<body>
	<h1 class="header-w3ls">QUÊN MẬT KHẨU</h1>
	<div class="art-bothside">
		<div class="mid-cls">
			<div class="art-right-w3ls">
				<div class="letter-w3ls">
					<form:form action="forgetPass.html" method="post">
						<div class="form-right-w3ls">
							<span class="error">${mess0}</span>
							<input type="email" name="email" placeholder="Email"
								required="required"								
								pattern="^[a-z][a-z0-9_\.]{5,32}@[a-z0-9]{2,}(\.[a-z0-9]{2,4}){1,2}$"
								oninvalid="this.setCustomValidity('Email sai định dạng!')"
								oninput="this.setCustomValidity('')" />
						</div>
						<div class="error">${msg}</div>
						<div class="success">${message}</div>
						
						<div class="clear"></div>
						<div class="btnn text-center">
							<button type="submit">TIẾP TỤC</button>
						</div>
						<br>
					</form:form>


				</div>
				<div class="banner-agileits-btm">
					<br>
					<div class="text-center">
						<a href="index.html" class="home"><i class="fas fa-arrow-left"></i>
							TRANG CHỦ</a>
					</div>
				</div>
			</div>
			<div class="art-left-w3ls">
				<img src="images/banner1.jpg" class="img-fluid" alt="">
			</div>
		</div>
	</div>
	<div class="copy">
		<p class="copy-right text-center ">&copy; 2019 The Camp. All
			Rights Reserved | Design by Hồng Quân</p>
	</div>
</body>
</html>