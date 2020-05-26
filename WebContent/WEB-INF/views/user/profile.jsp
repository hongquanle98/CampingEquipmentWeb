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

.btn, .sign-out {
	font-size: large;
	font-weight: bold;
}

.sign-out:hover {
	color: #FF4E00;
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
	<h1 class="header-w3ls">THÔNG TIN TÀI KHOẢN</h1>
	<div class="art-bothside">
		<div class="mid-cls">
			<div class="art-right-w3ls">
				<!-- <h2>Astronauts sign up and login</h2>
				<p>consectetur adipiscing elit, sed do eiusmod tempor incididunt
					Lorem ipsum dolor sit amet</p> -->

				<div class="error">${msg}</div>
				<div class="success" style="">${message}</div>

				<form:form action="user/edit/${id}.html" modelAttribute="user"
					onsubmit="return confirm('Bạn có chắc chắn sửa?');"
					enctype="multipart/form-data" method="post">
					<div class="text-center">
						<img class="avatar" alt="${user.name}" src="${user.avatar}">
					</div>

					<div class="text-center">
						<input type="file" name="photo" accept="image/*"
							value="/${user.avatar}" />
					</div>
					<div class="main">
						<form:hidden path="id" />
						<form:hidden path="username" />
						<form:hidden path="password" />
						<form:hidden path="avatar" />
						<form:hidden path="roleId" />
						<div class="form-left-to-w3l">
							<form:input type="text" path="name" placeholder="Họ tên"
								value="${name}" required="required"
								oninvalid="this.setCustomValidity('Họ tên không hợp lệ!')"
								oninput="this.setCustomValidity('')" />
						</div>
						<div class="form-right-w3ls">
							<form:errors path="email" />
							<form:input type="email" path="email" placeholder="Email"
								value="${email}" required="required"
								pattern="^[a-z][a-z0-9_\.]{5,32}@[a-z0-9]{2,}(\.[a-z0-9]{2,4}){1,2}$"
								oninvalid="this.setCustomValidity('Email sai định dạng!')"
								oninput="this.setCustomValidity('')" />
						</div>
					</div>
					<div class="main">
						<div class="form-left-to-w3l">
							<form:input type="text" path="phone" placeholder="Số điện thoại"
								value="${phone}" required="required"
								pattern="(03|05|07|08|09)+([0-9]{8})\b"
								oninvalid="this.setCustomValidity('Số điện thoại sai định dạng!')"
								oninput="this.setCustomValidity('')" />
						</div>
						<div class="form-left-to-w3l">
							<form:input type="text" path="address" placeholder="Địa chỉ"
								value="${address}" />
						</div>
						<div class="form-left-to-w3l">
							<form:errors path="password" />
							<input type="password" name="pass" placeholder="Mật khẩu hiện tại"
								required="required"
								oninvalid="this.setCustomValidity('Vui lòng điền mật khẩu hiện tai')"
								oninput="this.setCustomValidity('')" /><span class="error">${mess0}</span>
						</div>
					</div>

					<div class="text-center">
						<h3 style="color: #FF4E00; font-size: x-large;">Đổi mật khẩu</h3>
					</div>

					<div class="main">
						<div class="form-left-to-w3l">
							<input type="password" placeholder="Mật khẩu mới"
								name="newPassword" pattern="([a-z]|[A-Z]|[0-9]){1,8}"
								oninvalid="this.setCustomValidity('Mật khẩu bao gồm 8 ký tự chữ, số!')"
								oninput="this.setCustomValidity('')" /><span class="error">${mess1}</span>
						</div>
						<div class="form-left-to-w3l">
							<input type="password" placeholder="Xác nhận mật khẩu mới"
								name="confirmNewPass" pattern="([a-z]|[A-Z]|[0-9]){1,8}"
								oninvalid="this.setCustomValidity('Mật khẩu bao gồm 8 ký tự chữ, số!')"
								oninput="this.setCustomValidity('')" /><span class="error">${mess2}</span>
						</div>

					</div>

					<form:button type="submit" style="float: right; margin: unset;">
						<i class="fas fa-edit"></i>Sửa
						</form:button>

					<div class="clear"></div>
					<br>
					<div class="text-center">
						<a href="signout.html" class="sign-out">ĐĂNG XUẤT <i
							class="fas fa-sign-out-alt"></i></a>
					</div>



				</form:form>


				<div class="banner-agileits-btm">
					<div class="w3layouts_more-buttn">
						<h3>
							Bạn chưa có tài khoản? <a href="signup.html" class="play-icon">Đăng
								ký ngay</a>
						</h3>
					</div>
					<br>
					<div class="text-center">
						<a href="index.html" class="home"><i class="fas fa-arrow-left"></i>
							TRANG CHỦ</a>
					</div>
				</div>
			</div>
			<div class="art-left-w3ls">
				<img src="images/banner6.jpg" class="img-fluid"
					style="height: 100%;">
			</div>
		</div>
	</div>
	<div class="copy">
		<p class="copy-right text-center ">&copy; 2019 The Camp. All
			Rights Reserved | Design by Hồng Quân</p>
	</div>

	<script src="js/jquery-2.2.3.min.js"></script>

</body>
</html>