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
		$('a[id=hideCate]').click(function(e) {
			$('body').addClass('wait');
			e.preventDefault();
			var id = $(this).attr("data-id");
			$.ajax({
				url : 'admin/category/display.html',
				type : 'GET',
				data : { id : id }
			}).always(function(result) {
				$("body").html(result);
				$('body').removeClass('wait');

			}).fail(function(result) {
				$('body').removeClass('wait');
				alert('Lỗi!');
				
			});
		});
		$('a[id=deleteCate]').click(function(e) {
			$('body').addClass('wait');
			e.preventDefault();
			var id = $(this).attr("data-id");
			$.ajax({
				url : 'admin/category/delete.html',
				type : 'GET',
				data : { id : id }
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
						<a href="admin/category/insert.html" class="btn btn-primary"><i
							class="fas fa-plus"></i> Thêm loại sản phẩm</a>
					</div>
					<div class="card-body">
						<div class="table-responsive">
							<table class="table table-bordered" id="dataTable" width="100%"
								cellspacing="0">
								<thead>
									<tr>
										<th>Hình ảnh</th>
										<th>Tên loại sản phẩm</th>
										<th>Chức năng</th>
									</tr>
								</thead>

								<tbody>
									<c:forEach var="c" items="${adminCategories}">

										<tr>
											<td><a href="category/${c.cateId}/1.html"><img
													src="${c.cateImage}" class="cart-thumb" /></a></td>
											<td>${c.cateName}</td>
											<td><a class="btn btn-secondary"
												href="admin/category/edit/${c.cateId}.html"
												title="Sửa sản phẩm"><i class="fas fa-edit"></i></a> <a
												class="btn btn-danger ${c.products.size() == 0 ? '':'disabled'}"
												href="admin/category/delete.html"
												title="Xoá loại sản phẩm" id="deleteCate" data-id="${c.cateId}"
												onclick="return confirm('Bạn có chắc chắn xoá loại sản phẩm này?')">
													<i class="fas fa-trash-alt"></i>
											</a> <a class="btn btn-${c.display == true ? 'light':'dark'}"
												href="admin/category/display.html" id="hideCate" data-id="${c.cateId}"
												title="${c.display == true ? 'Ẩn loại sản phẩm':'Hiện loại sản phẩm'}">
													<i
													class="${c.display == true ? 'far fa-eye':'far fa-eye-slash'}"></i>
											</a></td>
										</tr>

									</c:forEach>
								</tbody>
								<tfoot>
									<tr>
										<th>Hình ảnh</th>
										<th>Tên loại sản phẩm</th>
										<th>Chức năng</th>
									</tr>
								</tfoot>
							</table>
						</div>
					</div>
				</div>

			</div>
			<!-- /.container-fluid -->
			<!-- content -->
			<%-- <div>
				<a href="admin/category/insert.html" class="btn btn-primary"><i
					class="fas fa-plus"></i> Thêm loại sản phẩm</a>
			</div>
			<c:if test="${listCategory.size() != 0}">
				<div class="text-center">
					<c:forEach var="i" begin="0" end="${totalPage - 1}"
						varStatus="status">

						<c:if test="${status.index == 0 && currentPage > 1}">
							<a href="admin/category/${cateId}/${currentPage-1}.html"
								class="btn btn-outline-primary">&laquo</a>
						</c:if>

						<a class="btn btn-outline-primary"
							href="admin/category/${cateId}/${i+1}.html"
							${status.index + 1 == currentPage ? 'style="background-color: #007bff;"':''}>
							<span
							${status.index + 1 == currentPage ? 'style="color: white;"':''}>
								${i+1}</span>
						</a>

						<c:if
							test="${status.index == totalPage-1 && currentPage <= totalPage-1}">
							<a href="admin/category/${cateId}/${currentPage+1}.html"
								class="btn btn-outline-primary">&raquo;</a>
						</c:if>

					</c:forEach>
				</div>

			</c:if>

			<br>

			<c:if test="${listCategory.size() == 0}">
				<div class="text-center">
					<h3>Không tìm thấy loại sản phẩm hợp lệ!</h3>
				</div>

			</c:if>

			<table class="table-striped table-bordered" style="width: 100%;">
				<tr>
					<th>Hình ảnh</th>
					<th>Tên loại sản phẩm<i class="fas fa-sort btn"></i></th>
					<th>Chức năng</th>
				</tr>
				<c:forEach var="c" items="${listCategory}">

					<tr>
						<td><a href="category/${c.cateId}/1.html"><img
								src="${c.cateImage}" class="cart-thumb" /></a></td>
						<td>${c.cateName}</td>
						<td><a class="btn btn-primary"
							href="admin/category/edit/${c.cateId}.html" title="Sửa sản phẩm"><i
								class="fas fa-edit"></i></a> <a
							class="btn btn-primary ${c.products.size() == 0 ? '':'disabled'}"
							href="admin/category/delete/${c.cateId}.html"
							title="Xoá loại sản phẩm"
							onclick="return confirm('Bạn có chắc chắn xoá loại sản phẩm này?')">
								<i class="fas fa-trash-alt"></i>
						</a> <a class="btn btn-primary"
							href="admin/category/display/${c.cateId}.html"
							title="${c.display == true ? 'Ẩn loại sản phẩm':'Hiện loại sản phẩm'}">
								<i
								class="${c.display == true ? 'far fa-eye':'far fa-eye-slash'}"></i>
						</a></td>
					</tr>

				</c:forEach>
				<tfoot>
					<tr>
						<th>Hình ảnh</th>
						<th>Tên loại sản phẩm<i class="fas fa-sort btn"></i></th>
						<th>Chức năng</th>
					</tr>
				</tfoot>
			</table>
			<br>
			<c:if test="${listCategory.size() != 0}">
				<div class="text-center">
					<c:forEach var="i" begin="0" end="${totalPage - 1}"
						varStatus="status">

						<c:if test="${status.index == 0 && currentPage > 1}">
							<a href="admin/category/${cateId}/${currentPage-1}.html"
								class="btn btn-outline-primary">&laquo</a>
						</c:if>

						<a class="btn btn-outline-primary"
							href="admin/category/${cateId}/${i+1}.html"
							${status.index + 1 == currentPage ? 'style="background-color: #007bff;"':''}>
							<span
							${status.index + 1 == currentPage ? 'style="color: white;"':''}>
								${i+1}</span>
						</a>

						<c:if
							test="${status.index == totalPage-1 && currentPage <= totalPage-1}">
							<a href="admin/category/${cateId}/${currentPage+1}.html"
								class="btn btn-outline-primary">&raquo;</a>
						</c:if>

					</c:forEach>
				</div>

			</c:if> --%>
			<!-- content -->
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
	<!-- <script type="text/javascript">
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
</body>
</html>