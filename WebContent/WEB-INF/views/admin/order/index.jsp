<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE HTML>
<html>
<head>
<title>The Camp - Camping Equipment Website</title>
<base href="${pageContext.servletContext.contextPath}/">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords"
	content="Glance Design Dashboard Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template, 
SmartPhone Compatible web template, free WebDesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design" />

<link href="css/discount-tag.css" rel='stylesheet' type='text/css' />
<!-- Bootstrap Core CSS -->
<link href="css/bootstrap.css" rel='stylesheet' type='text/css' />

<!-- Custom CSS -->
<link href="css/style-admin.css" rel='stylesheet' type='text/css' />

<!-- font-awesome icons CSS -->
<link href="css/all.css" rel="stylesheet">
<!-- //font-awesome icons CSS-->


<!-- side nav css file -->
<link href='css/SidebarNav.min.css' media='all' rel='stylesheet'
	type='text/css' />
<!-- //side nav css file -->

<!-- js-->
<script src="js/jquery-1.11.1.min.js"></script>
<script src="js/modernizr.custom.js"></script>

<!--webfonts-->
<link
	href="//fonts.googleapis.com/css?family=PT+Sans:400,400i,700,700i&amp;subset=cyrillic,cyrillic-ext,latin-ext"
	rel="stylesheet">
<!--//webfonts-->

<!-- Metis Menu -->
<script src="js/metisMenu.min.js"></script>
<script src="js/custom.js"></script>
<link href="css/custom.css" rel="stylesheet">
<!--//Metis Menu -->

<link href="admin/vendor/datatables/dataTables.bootstrap4.min.css"
	rel="stylesheet">
<!-- ajax mini cart -->
<script src="js/jquery-2.2.3.min.js"></script>
<script type="text/javascript">
	 $(document).ready(function() {
		$('a[id=cancel]').click(function(e) {
			$('body').addClass('wait');
			e.preventDefault();
			var id = $(this).attr("data-id");
			$.ajax({
				url : 'admin/order/action.html',
				type : 'GET',
				data : { id : id , action : "cancel"}
			}).always(function(result) {
				$("body").html(result);
				$('body').removeClass('wait');

			}).fail(function(result) {
				$('body').removeClass('wait');
				alert('Lỗi!');
				
			});
		});
		$('a[id=submit]').click(function(e) {
			$('body').addClass('wait');
			e.preventDefault();
			var id = $(this).attr("data-id");
			$.ajax({
				url : 'admin/order/action.html',
				type : 'GET',
				data : { id : id , action : "submit"}
			}).always(function(result) {
				$("body").html(result);
				$('body').removeClass('wait');

			}).fail(function(result) {
				$('body').removeClass('wait');
				alert('Lỗi!');
				
			});
		});
		$('a[id=delivered]').click(function(e) {
			$('body').addClass('wait');
			e.preventDefault();
			var id = $(this).attr("data-id");
			$.ajax({
				url : 'admin/order/action.html',
				type : 'GET',
				data : { id : id , action : "delivered"}
			}).always(function(result) {
				$("body").html(result);
				$('body').removeClass('wait');

			}).fail(function(result) {
				$('body').removeClass('wait');
				alert('Lỗi!');
				
			});
		});
	});
</script>
<!-- ajax mini cart -->
</head>
<body class="cbp-spmenu-push">
	<div class="main-content">
		<jsp:include page="../left-sidebar-header.jsp"></jsp:include>
		<div id="page-wrapper">
			<div class="main-page"></div>

			<!-- Begin Page Content -->
			<div class="container-fluid">


				<!-- DataTales Example -->
				<div class="card shadow mb-4">
					<div class="card-header py-3">
						<c:if test="${adminBaseURL == 'admin/order'}">
							<a href="admin/order/insert.html" class="btn btn-primary"><i
								class="fas fa-plus"></i> Thêm đơn hàng mới</a>
						</c:if>
						<c:if test="${adminBaseURL == 'admin/user/order'}">
							<img class="pic" alt="${user.name}" src="${user.avatar}"> ${user.username}
						</c:if>
					</div>
					<div class="card-body">
						<div class="table-responsive">
							<table class="table table-bordered" id="dataTable" width="100%"
								cellspacing="0">
								<thead>
									<tr>
										<th>Ngày đặt</th>
										<th>Mã đơn hàng</th>
										<th>Thông tin đặt hàng</th>
										<th>Tổng tiền phải trả</th>
										<th>Thanh toán</th>
										<th>Trạng thái</th>
										<th>Chức năng</th>
									</tr>
								</thead>

								<tbody>

									<c:if test="${adminBaseURL == 'admin/user/order'}">
										<c:set var="listOrder" value="${userOrders}" />
									</c:if>
									<c:if test="${adminBaseURL == 'admin/order'}">
										<c:set var="listOrder" value="${adminOrders}" />
									</c:if>
									<c:forEach var="o" items="${listOrder}">

										<tr>
											<td>${o.buyDate}</td>
											<td>${o.id}</td>
											<td>
												<div>${o.name}</div>
												<div>${o.phone}</div>
												<div>${o.address}</div>
											</td>
											<td><c:set var="total" value="${0}"></c:set> <c:forEach
													var="ci" items="${o.cartItems}">
													<c:set var="total"
														value="${total + ci.unitPrice * ci.quantity}"></c:set>
												</c:forEach> <fmt:formatNumber value=" ${total + total*0.12}"
													type="number" pattern="###,###" /> đ</td>
											<td>${o.payment}</td>
											<td><c:if test="${o.status == 0}">
													<p style="color: #CEA285;">Chờ xác nhận</p>
												</c:if> <c:if test="${o.status == 1}">
													<p style="color: #007BFF;">Đang giao...</p>
												</c:if> <c:if test="${o.status == 2}">
													<p style="color: green;">Đã giao</p>
												</c:if> <c:if test="${o.status == 3}">
													<p style="color: red;">Đã huỷ</p>
												</c:if></td>

											<td><a
												class="btn btn-secondary ${o.status == 0 ? '' : 'disabled'}"
												href="admin/order/edit/${o.id}.html" title="Sửa đơn hàng">
													<i class="fas fa-edit"></i>
											</a>
												<button class="btn btn-info" title="Chi tiết đơn hàng"
													data-toggle="modal" data-target="#orderDetail${o.id}">
													<i class="fas fa-info-circle"></i>
												</button></td>
										</tr>



										<!-- Modal -->
										<div class="modal fade" id="orderDetail${o.id}" tabindex="-1"
											role="dialog" aria-labelledby="exampleModalCenterTitle"
											aria-hidden="true">
											<div
												class="modal-dialog modal-dialog-centered modal-lg mw-100 w-75"
												role="document">
												<div class="modal-content">
													<div class="modal-header">
														<h5 class="modal-title" id="exampleModalLongTitle">Chi
															tiết đơn hàng</h5>
														<button type="button" class="close" data-dismiss="modal"
															aria-label="Close">
															<span aria-hidden="true">&times;</span>
														</button>
													</div>
													<div class="modal-body">
														<div class="row">
															<div class="col-md-6">
																<label>Mã đơn hàng: ${o.id}</label>
															</div>
															<div class="col-md-6 text-right">
																<c:if test="${o.status == 0}">
																	<label style="color: #CEA285;">Chờ xác nhận</label>
																</c:if>
																<c:if test="${o.status == 1}">
																	<label style="color: #007BFF;">Đang giao...</label>
																</c:if>
																<c:if test="${o.status == 2}">
																	<label style="color: green;">Đã giao</label>
																</c:if>
																<c:if test="${o.status == 3}">
																	<label style="color: red;">Đã huỷ</label>
																</c:if>
															</div>
														</div>
														<hr>
														<!-- <div> -->
														<c:set var="total" value="${0}"></c:set>
														<c:forEach var="ci" items="${o.cartItems}">
															<c:set var="total"
																value="${total + ci.unitPrice * ci.quantity}"></c:set>

															<span> <a href="single/${ci.product.id}.html"><img
																	src="${ci.product.image}" class="cart-thumb image"
																	alt="${ci.product.name}" /></a> <a
																href="single/${ci.product.id}.html">${ci.product.name}</a>
															</span>
															<span style="float: right;"> ${ci.quantity} <i>
																	x </i> <fmt:formatNumber value=" ${ci.unitPrice}"
																	type="number" pattern="###,###" /> đ
															</span>

															<hr>
														</c:forEach>
														<!-- </div> -->

														<div class="info-left row">
															<div class="col-md-6 info-basket">
																<h4>Thông tin đơn hàng</h4>

																<ul style="list-style: none;">
																	<li>Ngày đặt: <span>${o.buyDate}</span></li>
																	<li>Tên người nhận: <span>${o.name}</span></li>
																	<li>Số điện thoại: <span>${o.phone}</span></li>
																	<li>Email: <span>${o.email}</span></li>
																	<li>Địa chỉ: <span>${o.address}</span></li>
																	<li>Ghi chú: <span>${o.note}</span></li>
																</ul>
															</div>

															<div class="col-md-6 checkout-left-basket">
																<h4>Thông tin thanh toán</h4>

																<ul style="list-style: none;">
																	<li>Tổng tiền hàng: <span><fmt:formatNumber
																				value="${total}" type="number" pattern="###,###" />
																			đ</span></li>
																	<li>Thuế VAT(10%) + PVC: <span><fmt:formatNumber
																				value="${total * 0.12}" type="number"
																				pattern="###,###" /> đ</span></li>
																	<li>Tổng tiền phải trả: <span
																		style="font-size: large; color: #FF4E00;"><fmt:formatNumber
																				value="${total + total*0.12}" type="number"
																				pattern="###,###" /> đ</span></li>
																	<li>Phương thức thanh toán: <span>${o.payment}</span></li>

																</ul>
															</div>
														</div>


													</div>
													<hr>
													<div class="my-3 border-top">

														<c:if test="${o.status == 0}">
															<div class="row">
																<div class="col-md-6">
																	<a class="btn btn-danger" id="cancel" data-id="${o.id}"
																		href="admin/order/action.html">Huỷ đơn
																		hàng</a>
																</div>
																<div class="col-md-6 text-right">
																	<a class="btn btn-primary" id="submit" data-id="${o.id}"
																		href="admin/order/action.html">Xác nhận
																		đơn hàng</a>
																</div>
															</div>


														</c:if>
														<c:if test="${o.status == 1}">
															<div class="text-right mt-3 mr-3">
																<a class="btn btn-success" id="delivered" data-id="${o.id}"
																	href="admin/order/action.html">Đã giao
																	hàng</a>
															</div>

														</c:if>

													</div>
												</div>
											</div>
										</div>


									</c:forEach>
									
								</tbody>
								<tfoot>
									<tr>
										<th>Ngày đặt</th>
										<th>Mã đơn hàng</th>
										<th>Thông tin đặt hàng</th>
										<th>Tổng tiền phải trả</th>
										<th>Thanh toán</th>
										<th>Trạng thái</th>
										<th>Chức năng</th>
									</tr>
								</tfoot>
							</table>
						</div>
					</div>
				</div>

			</div>
			<!-- /.container-fluid -->

		</div>
	</div>



	<!--scrolling js-->
	<script src="js/jquery.nicescroll.js"></script>
	<script src="js/scripts.js"></script>
	<!--//scrolling js-->

	<!-- side nav js -->
	<script src='js/SidebarNav.min.js' type='text/javascript'></script>
	<script>
		$('.sidebar-menu').SidebarNav()
	</script>
	<!-- //side nav js -->

	<!-- Bootstrap Core JavaScript -->
	<script src="js/bootstrap.js">
		
	</script>
	<!-- //Bootstrap Core JavaScript -->
	<!-- sort-table -->
	<!-- 	<script type="text/javascript">
	 const getCellValue = (tr, idx) => tr.children[idx].innerText || tr.children[idx].textContent;

	const comparer = (idx, asc) => (a, b) => ((v1, v2) => 
	    v1 !== '' && v2 !== '' && !isNaN(v1) && !isNaN(v2) ? v1 - v2 : v1.toString().localeCompare(v2)
	    )(getCellValue(asc ? a : b, idx), getCellValue(asc ? b : a, idx));

	// do the work...
	document.querySelectorAll('th').forEach(th => th.addEventListener('click', (() => {
	    const table = th.closest('table');
	    Array.from(table.querySelectorAll('tr:nth-child(n+2)'))
	        .sort(comparer(Array.from(th.parentNode.children).indexOf(th), this.asc = !this.asc))
	        .forEach(tr => table.appendChild(tr) );
	}))); 
	
	</script> -->
	<!-- sort-table -->
	<script src="admin/vendor/jquery/jquery.min.js"></script>
	<script src="admin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script src="admin/vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="admin/js/sb-admin-2.min.js"></script>

	<!-- Page level plugins -->
	<script src="admin/vendor/datatables/jquery.dataTables.min.js"></script>
	<script src="admin/vendor/datatables/dataTables.bootstrap4.min.js"></script>

	<!-- Page level custom scripts -->
	<script src="admin/js/demo/datatables-demo.js"></script>

	<!-- orderDetail -->
	<script type="text/javascript">
		function showOrderDetail(id) {
			var x = document.getElementById(id);
			if (x.style.display === "none") {
				x.style.display = "block";
			} else {
				x.style.display = "none";
			}
		}
	</script>
	<!-- orderDetail -->
</body>
</html>