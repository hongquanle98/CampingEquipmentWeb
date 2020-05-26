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
.pic {
	object-fit: cover;
	width: 50px;
	height: 50px;
	border-radius: 50%;
	border: 2px solid #FF4E00;
	align-items: center;
	justify-content: center;
}

*[id$=errors] {
	color: red;
	font-style: italic;
}

.btn {
	color: #828284;
}

.btn:hover {
	color: #FF4E00;
}
/* mini-cart */
.cart-thumb {
	border: 1px solid #ddd; /* Gray border */
	border-radius: 4px; /* Rounded border */
	margin-right: 20px;
	width: 150px; /* Set a small width */
}

.cart-thumb:hover {
	box-shadow: 0 0 2px 1px rgba(0, 140, 186, 0.5);
}

.search-thumb {
	border: 1px solid #ddd; /* Gray border */
	border-radius: 4px; /* Rounded border */
	margin-right: 20px;
	width: 100px; /* Set a small width */
}

.cart-thumb:hover {
	box-shadow: 0 0 2px 1px rgba(0, 140, 186, 0.5);
}

/* mini-cart */
.pro-thumb:hover {
	border-radius: 4px; /* Rounded border */
	box-shadow: 0 0 2px 1px rgba(0, 140, 186, 0.5);
}

/* CSS used here will be applied after bootstrap.css */
.badge-notify {
	color: white;
	background: red;
	position: relative;
	-moz-transform: translate(-100%, -100%); /* For Firefox */
	-ms-transform: translate(-100%, -100%); /* for IE */
	-webkit-transform: translate(-100%, -100%);
	/* For Safari, Chrome, iOS */
	-o-transform: translate(-100%, -100%);
	position: relative; /* For Opera */
}

.image-icon {
	position: relative;
}

.image-icon .imgage {
	display: block;
}

.image-icon .icon {
	position: absolute;
	top: 0;
	right: 0;
}

.sticky {
	position: -webkit-sticky;
	position: sticky;
	top: 0;
	width: 100%;
	z-index: 1020;
}
</style>
<link href="css/mini-cart.css" rel='stylesheet' type='text/css'
	media="all" />
<!-- <link href="css/success-modal.css" rel='stylesheet' type='text/css'
	media="all" /> -->
<!-- <link href="css/bootstrap.css" rel='stylesheet' type='text/css' /> -->

<!-- ajax mini cart -->
<script src="js/jquery-2.2.3.min.js"></script>
<script type="text/javascript">
	$(document)
			.ready(
					function() {
						$('button[type=delete]')
								.click(
										function(e) {
											//e.preventDefault();
											var id = $(this).attr("id");
											$
													.ajax(
															{
																url : 'deleteCartItem.html',
																type : 'GET',
																/* dataType : 'html', */
																data : {
																	id : id
																}
															/* $('form[id=' + id + ']').serialize() */
															})
													.done(
															function(result) {
																alert('Xoá sản phẩm thành công!');
																/* if (result.length > 0) { */
																$("body").html(
																		result);
																$(
																		'.owl-carousel')
																		.owlCarousel(
																				{
																					loop : true,
																					margin : 10,
																					responsiveClass : true,
																					responsive : {
																						0 : {
																							items : 1,
																							nav : true
																						},
																						600 : {
																							items : 2,
																							nav : false
																						},
																						900 : {
																							items : 3,
																							nav : false
																						},
																						1000 : {
																							items : 4,
																							nav : true,
																							loop : false,
																							margin : 20
																						}
																					}
																				});
																$(
																		'#horizontalTab')
																		.easyResponsiveTabs(
																				{
																					type : 'default', //Types: default, vertical, accordion           
																					width : 'auto', //auto or any width like 600px
																					fit : true, // 100% fit in a container
																					closed : 'accordion', // Start closed if in accordion view
																					activate : function(
																							event) { // Callback function if tab is switched
																						var $tab = $(this);
																						var $info = $('#tabInfo');
																						var $name = $(
																								'span',
																								$info);
																						$name
																								.text($tab
																										.text());
																						$info
																								.show();
																					}
																				});
																$(
																		'#verticalTab')
																		.easyResponsiveTabs(
																				{
																					type : 'vertical',
																					width : 'auto',
																					fit : true
																				});
																$(
																		'[data-quantity="plus"]')
																		.click(
																				function(
																						e) {
																					// Stop acting like a button
																					e
																							.preventDefault();
																					// Get the field name
																					fieldName = $(
																							this)
																							.attr(
																									'data-field');
																					// Get its current value
																					var currentVal = parseInt($(
																							'input[name='
																									+ fieldName
																									+ ']')
																							.val());
																					// If is not undefined
																					if (!isNaN(currentVal)) {
																						// Increment
																						$(
																								'input[name='
																										+ fieldName
																										+ ']')
																								.val(
																										currentVal + 1);
																					} else {
																						// Otherwise put a 0 there
																						$(
																								'input[name='
																										+ fieldName
																										+ ']')
																								.val(
																										0);
																					}
																				});
																// This button will decrement the value till 0
																$(
																		'[data-quantity="minus"]')
																		.click(
																				function(
																						e) {
																					// Stop acting like a button
																					e
																							.preventDefault();
																					// Get the field name
																					fieldName = $(
																							this)
																							.attr(
																									'data-field');
																					// Get its current value
																					var currentVal = parseInt($(
																							'input[name='
																									+ fieldName
																									+ ']')
																							.val());
																					// If it isn't undefined or its greater than 0
																					if (!isNaN(currentVal)
																							&& currentVal > 0) {
																						// Decrement one
																						$(
																								'input[name='
																										+ fieldName
																										+ ']')
																								.val(
																										currentVal - 1);
																					} else {
																						// Otherwise put a 0 there
																						$(
																								'input[name='
																										+ fieldName
																										+ ']')
																								.val(
																										0);
																					}
																				});

																/* } */
															}).fail(
															function(result) {
																/* if (result.length > 0) { */
																alert('Lỗi!');
																/* } */
															});

										});
						$('.search-dropdown').on(
								'click',
								'a',
								function() {
									var text = $(this).html();
									var htmlText = text
											+ ' <span class="caret"></span>';
									$(this).closest('.dropdown').find(
											'.dropdown-toggle').html(htmlText);
								});
					});
</script>

</head>
<body>
	<header class="sticky bg-light">
		<div class="row">
			<div class="col-md-3 top-info text-left mt-lg-4">
				<h6>
					<i class="fas fa-phone"></i> Hỗ trợ
				</h6>
				<ul>
					<c:forEach var="u" items="${users}">
						<c:if test="${u.roleId == 1}">
							<li class="number-phone mt-3">${u.phone}(${u.name})</li>
						</c:if>
					</c:forEach>
				</ul>
			</div>
			<div class="col-md-6 logo-w3layouts text-center">
				<h1 class="logo-w3layouts">
					<a class="navbar-brand" href="index.html"> The Camp </a>
				</h1>
			</div>

			<div class="col-md-3 top-info-cart text-right mt-lg-4">
				<ul class="cart-inner-info">

					<c:choose>
						<c:when test="${userLogin == null}">
							<div>
								<a href="signin.html" role="button"><span class="btn"><i
										class="fas fa-sign-in-alt"></i> Đăng nhập</span></a> <a
									href="signup.html" role="button"><span class="btn"><i
										class="fas fa-user-plus"></i> Đăng ký</span></a>
							</div>
						</c:when>
						<c:otherwise>

							<li class="dropdown"><span class="btn"><img
									class="pic" alt="${userLogin.name}" src="${userLogin.avatar}">
									${userLogin.name}</span>
								<div class="dropdown-menu dropdown-menu-right text-center"
									style="width: 200px;">
									<c:if test="${userLogin.roleId == 1}">
										<a href="admin/${userLogin.id}.html" role="button"><span
											class="btn" style="padding: 8px 0px 0px 0px;">Quản lý
												trang web <i class="fas fa-user-shield"></i>
										</span></a>
										<div class="dropdown-divider"></div>
									</c:if>
									<%-- <c:choose>									
										<c:when test="${userLogin.lock == true}">
											<a href="signup.html" role="button"
												onclick="return alert('Tài khoản đã bị khoá!')"><span
												class="btn" style="padding: 8px 0px 0px 0px;">Thông
													tin tài khoản <i class="fas fa-user-cog"></i>
											</span></a>
										</c:when>
										<c:otherwise> --%>
									<a href="user/edit/${userLogin.id}.html" role="button"><span
										class="btn" style="padding: 8px 0px 0px 0px;">Thông tin
											tài khoản <i class="fas fa-user-cog"></i>
									</span></a>
									<%-- </c:otherwise>
									</c:choose> --%>

									<div class="dropdown-divider"></div>
									<a href="order.html"><span class="btn"
										style="padding: 0px 0px 0px 0px;">Thông tin đơn mua <i
											class="fas fa-file-invoice"></i>
									</span></a>
									<div class="dropdown-divider"></div>
									<a href="signout.html"><span class="btn"
										style="padding: 0px 0px 8px 0px;">Đăng xuất <i
											class="fas fa-sign-out-alt"></i></span></a>
								</div></li>

							<div style="display: inline;">
								<li class="dropdown"><a href="checkout.html" role="button"
									class="btn"> <i class="fas fa-shopping-cart fa-lg"></i> <span
										class="badge badge-notify">${totalItem}</span>
								</a>
									<ul class="dropdown-menu dropdown-menu-right"
										style="margin: 0; padding: 0; list-style: none;">
										<c:choose>
											<c:when test="${totalItem == 0}">
												<div class="text-center" style="margin: 20px;">
													<span style="font-size: large;">Giỏ hàng trống!</span>
												</div>
											</c:when>
											<c:otherwise>
												<li
													style="padding: 30px 30px 0px 30px; margin: unset; display: block;"><c:forEach
														var="i" items="${listCartItem}">

														<div style="display: inline-flex;">


															<div class="image-icon">
																<a href="single/${i.product.id}.html"><img
																	src="${i.product.image}" class="cart-thumb image"
																	alt="${i.product.name}" /></a>
																<c:if
																	test="${i.product.discount > 0 && i.product.discount <= 1}">
																	<span class="fa-stack fa-lg icon"> <i
																		class="fa fa-tag fa-stack-2x"></i> <i
																		class="fa fa-stack-1x fa-inverse">&nbsp;-<fmt:formatNumber
																				value="${i.product.discount}" type="percent" /></i>
																	</span>
																</c:if>
															</div>

															<div>
																<button id="${i.id}" class="btn" style="float: right;"
																	type="delete">
																	<i class="far fa-trash-alt"></i>
																</button>

																<h6 style="width: 200px;">
																	<a href="single/${i.product.id}.html">${i.product.name}</a>
																</h6>

																<p>
																	${i.quantity} x <span><fmt:formatNumber
																			value=" ${i.unitPrice}" type="number"
																			pattern="###,###" /> đ</span>
																</p>

															</div>

														</div>
														<hr>

													</c:forEach></li>


												<div class="text-center">
													<strong>Tạm tính: </strong><span class="money"><fmt:formatNumber
															value="${totalPrice}" type="number" pattern="###,###" />
														VNĐ</span> <br> <span class="btn">(Chưa bao gồm thuế
														và PVC!)</span>
												</div>
												<hr>
												<div class="text-center" style="padding-bottom: 20px;">
													<a href="checkout.html" class="btn btn-default btn-cart">Thanh
														toán</a>
												</div>
											</c:otherwise>
										</c:choose>


									</ul></li>
							</div>

						</c:otherwise>
					</c:choose>


				</ul>




				<%-- <div class="overlay-login text-left">
					<button type="button" class="overlay-close1">
						<i class="fa fa-times" aria-hidden="true"></i>
					</button>
					<div class="wrap">
						<h5 class="text-center mb-4">Đăng nhập</h5>
						<div class="login p-5 bg-dark mx-auto mw-100">
							<form action="#" method="post">
								<div class="form-group">
									<label class="mb-2">Email</label> <input type="email"
										class="form-control" id="exampleInputEmail1"
										aria-describedby="emailHelp" placeholder="" required="">
									<small id="emailHelp" class="form-text text-muted">Chúng
										tôi sẽ không chia sẻ email của bạn.</small>
								</div>
								<div class="form-group">
									<label class="mb-2">Mật khẩu</label> <input type="password"
										class="form-control" id="exampleInputPassword1" placeholder=""
										required="">
								</div>
								<div class="form-check mb-2">
									<input type="checkbox" class="form-check-input"
										id="exampleCheck1"> <label class="form-check-label"
										for="exampleCheck1">Check me out</label>
								</div>
								<button type="submit" class="btn btn-primary submit mb-4">Đăng
									nhập</button>

							</form>
						</div>

					</div>
				</div> --%>

			</div>
		</div>


		<!-- <div class="search"> -->

		<!-- <div class="mobile-nav-button">
				<button id="trigger-overlay" type="button">
					<i class="fas fa-search"></i>
				</button>
			</div> -->
		<!-- open/close -->
		<%-- <div class="overlay overlay-door">
				<button type="button" class="overlay-close">
					<i class="fa fa-times" aria-hidden="true"></i>
				</button>
				<form action="#" method="post" class="d-flex">
					<input class="form-control" type="search"
						placeholder="Search here..." required="">
					<button type="submit" class="btn btn-primary submit">
						<i class="fas fa-search"></i>
					</button>
				</form>

			</div> --%>
		<!-- open/close -->
		<!-- </div> -->

		<nav
			class="navbar navbar-expand-lg navbar-light bg-light top-header mb-2">

			<!-- <button class="navbar-toggler mx-auto" type="button"
				data-toggle="collapse" data-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"> </span>
			</button> -->

			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav nav-mega mx-auto">
					<c:choose>
						<c:when test="${baseURL == 'index'}">
							<li class="nav-item active"><a class="nav-link ml-lg-0"
								href="index.html">Trang chủ <span class="sr-only">(current)</span>
							</a></li>
							<!-- <li class="nav-item"><a class="nav-link" href="about.html">Về
							chúng tôi</a></li> -->
							<li class="nav-item dropdown"><a
								class="nav-link dropdown-toggle" href="shop/1.html"
								id="navbarDropdown" role="button" aria-haspopup="true"
								aria-expanded="false">Sản phẩm</a>
								<ul class="dropdown-menu mega-menu ">
									<li>
										<div class="row">
											<div class="col-md-4 media-list span4 text-left">
												<h5 class="tittle-w3layouts-sub">Top sản phẩm bán chạy</h5>
												<ul>
													<c:forEach begin="0" end="1" var="fp"
														items="${featurePros}">
														<li>
															<div class="image-icon">
																<a href="single/${fp.product.id}.html"> <img
																	style="margin: 20px;" class="pro-thumb image"
																	alt="${fp.product.name}" src="${fp.product.image}"
																	title="${fp.product.name}" /></a>
																<c:if
																	test="${fp.product.discount > 0 && fp.product.discount <= 1}">
																	<span class="fa-stack fa-lg icon"> <i
																		class="fa fa-tag fa-stack-2x "></i> <i
																		class="fa fa-stack-1x fa-inverse">&nbsp;-<fmt:formatNumber
																				value="${fp.product.discount}" type="percent" /></i>
																	</span>
																</c:if>

															</div>

														</li>
													</c:forEach>
												</ul>
											</div>
											<div class="col-md-4 media-list span4 text-left">
												<br>
												<ul>
													<c:forEach begin="2" end="3" var="fp"
														items="${featurePros}">
														<li>
															<div class="image-icon">
																<a href="single/${fp.product.id}.html"> <img
																	class="pro-thumb image" alt="${fp.product.name}"
																	src="${fp.product.image}" title="${fp.product.name}" /></a>
																<c:if
																	test="${fp.product.discount > 0 && fp.product.discount <= 1}">
																	<span class="fa-stack fa-lg icon"> <i
																		class="fa fa-tag fa-stack-2x "></i> <i
																		class="fa fa-stack-1x fa-inverse">&nbsp;-<fmt:formatNumber
																				value="${fp.product.discount}" type="percent" /></i>
																	</span>
																</c:if>

															</div>

														</li>
													</c:forEach>
													<%-- <c:forEach begin="0" end="1" var="rp"
												items="${recommendPros}">
												<li><div class="image-icon">
													<a
													href="single/${rp.id}.html"> <img
														class="pro-thumb image" alt="${rp.name}"
														src="${rp.image}" title="${rp.name}"/></a>
													<c:if
														test="${rp.discount > 0 && rp.discount <= 1}">
														<span class="fa-stack fa-lg icon"> <i
															class="fa fa-tag fa-stack-2x"></i> <i
															class="fa fa-stack-1x fa-inverse">&nbsp;-<fmt:formatNumber
																	value="${rp.discount}" type="percent" /></i>
														</span>
													</c:if>

												</div></li>
											</c:forEach> --%>
												</ul>
											</div>
											<div class="col-md-4 media-list span4 text-left">
												<h5 class="tittle-w3layouts-sub">Danh mục sản phẩm</h5>
												<ul>
													<c:forEach var="c" items="${categories}">
														<li class="media-mini mt-3"><img src="${c.cateImage}"
															height="20px" /><a href="category/${c.cateId}/1.html">
																${c.cateName} </a></li>
													</c:forEach>
												</ul>
											</div>

										</div>
										<hr>
									</li>
								</ul></li>
							<%-- <li>
								<form:form class="form-inline my-2 my-lg-0">
									<form:input class="form-control mr-sm-2" type="search" path="search"
										placeholder="Nhập tên sản phẩm" aria-label="Search"/>
									<form:button class="btn"
										type="submit"><i class="fas fa-search"></i></form:button>
								</form:form>
							</li> --%>
							<!-- <li class="nav-item"><a class="nav-link" href="contact.html">Liên
							hệ</a></li> -->
							<li class="dropdown"><a onclick="myFunction()" class="btn"
								id="menu1"><i class="fas fa-search"></i> TÌM KIẾM</a>

								<div id="myDropdown" class="dropdown-content search-dropdown"
									role="menu" aria-labelledby="menu1">
									<input type="text" placeholder="Tên sản phẩm.." id="myInput"
										onkeyup="filterFunction()">
									<c:forEach var="p" items="${products}">
										<div style="display: inline-flex;" class="search-item">

											<img src="${p.image}" class="search-thumb" alt="${p.name}" />

											<!-- <h6 style="width: 200px;"> -->
											<a href="single/${p.id}.html">${p.name}</a>
											<!-- </h6> -->

											<span style="color: #828284;"><fmt:formatNumber
													value="${p.price - p.price*p.discount}" type="number"
													pattern="###,###" /> đ</span>

											<hr>
										</div>
									</c:forEach>
								</div></li>
						</c:when>
						<c:otherwise>
							<li class="nav-item"><a class="nav-link ml-lg-0"
								href="index.html">Trang chủ <span class="sr-only">(current)</span>
							</a></li>
							<!-- <li class="nav-item"><a class="nav-link" href="about.html">Về
							chúng tôi</a></li> -->
							<li class="nav-item dropdown active"><a
								class="nav-link dropdown-toggle" href="shop/1.html"
								id="navbarDropdown" role="button" aria-haspopup="true"
								aria-expanded="false">Sản phẩm</a>
								<ul class="dropdown-menu mega-menu ">
									<li>
										<div class="row">
											<div class="col-md-4 media-list span4 text-left">
												<h5 class="tittle-w3layouts-sub">Top sản phẩm bán chạy</h5>
												<ul>
													<c:forEach begin="0" end="1" var="fp"
														items="${featurePros}">
														<li>
															<div class="image-icon">
																<a href="single/${fp.product.id}.html"> <img
																	class="pro-thumb image" alt="${fp.product.name}"
																	src="${fp.product.image}" title="${fp.product.name}" /></a>
																<c:if
																	test="${fp.product.discount > 0 && fp.product.discount <= 1}">
																	<span class="fa-stack fa-lg icon"> <i
																		class="fa fa-tag fa-stack-2x "></i> <i
																		class="fa fa-stack-1x fa-inverse">&nbsp;-<fmt:formatNumber
																				value="${fp.product.discount}" type="percent" /></i>
																	</span>
																</c:if>

															</div>

														</li>
													</c:forEach>
												</ul>
											</div>
											<div class="col-md-4 media-list span4 text-left">
												<br>
												<ul>
													<c:forEach begin="2" end="3" var="fp"
														items="${featurePros}">
														<li>
															<div class="image-icon">
																<a href="single/${fp.product.id}.html"> <img
																	class="pro-thumb image" alt="${fp.product.name}"
																	src="${fp.product.image}" title="${fp.product.name}" /></a>
																<c:if
																	test="${fp.product.discount > 0 && fp.product.discount <= 1}">
																	<span class="fa-stack fa-lg icon"> <i
																		class="fa fa-tag fa-stack-2x "></i> <i
																		class="fa fa-stack-1x fa-inverse">&nbsp;-<fmt:formatNumber
																				value="${fp.product.discount}" type="percent" /></i>
																	</span>
																</c:if>

															</div>

														</li>
													</c:forEach>
													<%-- <c:forEach begin="0" end="1" var="rp"
												items="${recommendPros}">
												<li><div class="image-icon">
													<a
													href="single/${rp.id}.html"> <img
														class="pro-thumb image" alt="${rp.name}"
														src="${rp.image}" title="${rp.name}"/></a>
													<c:if
														test="${rp.discount > 0 && rp.discount <= 1}">
														<span class="fa-stack fa-lg icon"> <i
															class="fa fa-tag fa-stack-2x"></i> <i
															class="fa fa-stack-1x fa-inverse">&nbsp;-<fmt:formatNumber
																	value="${rp.discount}" type="percent" /></i>
														</span>
													</c:if>

												</div></li>
											</c:forEach> --%>
												</ul>
											</div>
											<div class="col-md-4 media-list span4 text-left">
												<h5 class="tittle-w3layouts-sub">Danh mục sản phẩm</h5>
												<ul>
													<c:forEach var="c" items="${categories}">
														<li class="media-mini mt-3"><img src="${c.cateImage}"
															height="20px" /><a href="category/${c.cateId}/1.html">
																${c.cateName} </a></li>
													</c:forEach>
												</ul>
											</div>

										</div>
										<hr>
									</li>
								</ul></li>
							<!-- <li class="nav-item"><a class="nav-link" href="contact.html">Liên
							hệ</a></li> -->
						</c:otherwise>
					</c:choose>
				</ul>
			</div>
		</nav>
	</header>

	<script type="text/javascript">
		/* When the user clicks on the button,
		toggle between hiding and showing the dropdown content */
		function myFunction() {
			document.getElementById("myDropdown").classList.toggle("show");
		}

		function filterFunction() {
			var input, filter, ul, li, a, i, img, span;
			input = document.getElementById("myInput");
			filter = input.value.toUpperCase();
			div = document.getElementById("myDropdown");
			a = div.getElementsByTagName("a");
			img = div.getElementsByTagName("img");
			span = div.getElementsByTagName("span");
			for (i = 0; i < a.length; i++) {
				txtValue = a[i].textContent || a[i].innerText;
				if (txtValue.toUpperCase().indexOf(filter) > -1) {
					a[i].style.display = "";
					img[i].style.display = "";
					span[i].style.display = "";
				} else {
					a[i].style.display = "none";
					img[i].style.display = "none";
					span[i].style.display = "none";
				}
			}
		}
	</script>
	<!-- 	<script type="text/javascript">
		var stickyOffset = $('.sticky').offset().top;

		$(window).scroll(function() {
			var sticky = $('.sticky'), scroll = $(window).scrollTop();

			if (scroll >= stickyOffset)
				sticky.addClass('fixed');
			else
				sticky.removeClass('fixed');
		});
	</script> -->
	<!-- ajax mini cart -->
</body>
</html>