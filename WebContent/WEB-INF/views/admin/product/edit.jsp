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


</head>
<body class="cbp-spmenu-push">
	<div class="main-content">
		<jsp:include page="../left-sidebar-header.jsp"></jsp:include>
		<div id="page-wrapper">
			<div class="main-page"></div>
			<!-- content -->

			<div class="error">${msg}</div>
			<div class="success" style="">${message}</div>

			<form:form action="admin/product/edit/${id}.html"
				modelAttribute="product" enctype="multipart/form-data" method="post">
				<div class="form-group">
					<label>Loại sản phẩm: </label>
					<form:select path="category.cateId" class="form-control" id="selectCategory">
						<c:forEach var="c" items="${allCategories}">
							<option value="${c.cateId}"
								${product.category.cateId == c.cateId ? 'selected' : ''}>${c.cateName}</option>
						</c:forEach>
					</form:select>

				</div>

				<form:hidden path="id" />
				<form:hidden path="display" />
				<div class="form-group">
					<label>Hình sản phẩm: </label>
					<div>
						<img alt="${product.name}" src="${product.image}"
							class="cart-thumb">
					</div>
					<input type="file" name="photo" accept="image/*" id="inputImage"
						value="/${product.image}" />
					<form:hidden path="image"/>
				</div>

				<div class="form-group">
					<label>Tên sản phẩm: </label>
					<form:input path="name" value="${name}" class="form-control" id="inputName"
						maxlength="255" />
				</div>
				<div class="form-row">
					<div class="form-group col">
					<label>Giá sản phẩm(VNĐ): </label>
					<form:input path="price" class="form-control" type="number" min="0" id="inputPrice" value="${price}"
						aria-describedby="priceHelp" required="required" />
					<small id="priceHelp" class="form-text text-muted"></small>
				</div>
				<div class="form-group col">
					<label>Giảm giá(%): </label>
					<input class="form-control" id="inputDiscount"
						aria-describedby="discountHelp" type="number" min="0" max="100"
						step="1" required="required"
						oninvalid="this.setCustomValidity('Giảm giá không hợp lệ! (0 - 100)')"
						oninput="this.setCustomValidity('')" />
					<small id="discountHelp" class="form-text text-muted"></small>
					<form:hidden path="discount" value="${discount}" id="h_discount"/>
				</div>
				<div class="form-group col">
					<label>Giảm thực bán(VNĐ): </label>
					<input class="form-control" id="inputRealPrice"
						aria-describedby="RealPriceHelp" type="text" readonly="true"/>
					<small id="RealPriceHelp" class="form-text text-muted"></small>
					<input value="" id="h_realPrice" hidden/>
				</div>
				</div>
				<div class="form-group">
					<label>Mô tả: </label>
					<form:textarea path="description" value="${description}" id="inputDescription"
						class="form-control" rows="5" maxlength="2000" />
				</div>
				<div class="form-group">
					<label>Thông tin: </label>
					<form:textarea path="information" value="${information}" id="inputInformation"
						class="form-control" rows="5" maxlength="2000" />
				</div>

				<div>
					<form:button class="btn btn-primary" type="submit"
						onclick="return confirm('Bạn có chắc chắn sửa sản phẩm này?')">Sửa</form:button>
				</div>
				
				
				
			</form:form>

				<%-- <form:form action="admin/product/preview.html" id="previewForm"
					modelAttribute="product" enctype="multipart/form-data">
					<form:hidden path="category.cateId" value="${product.category.cateId}" id="hiddenCategory"/>
					<input type="file" name="photo" accept="image/*" id="hiddenImage"
						value="/${product.image}" />
					<form:hidden path="image"
						value="${product.image}" id="hiddenImage"/>
					<form:hidden path="name" value="${product.name}" id="hiddenName"/>
					<form:hidden path="price" value="${product.price}" id="hiddenPrice"/>
					<form:hidden path="discount" value="${product.discount}" id="hiddenDiscount"/>
					<form:hidden path="description" value="${product.description}" id="hiddenDescription"/>
					<form:hidden path="information" value="${product.information}" id="hiddenInformation"/>
					<div class="text-right">
					<form:button id="previewButton"><i
							class="fas fa-eye"></i>Xem truớc</form:button>
							</div>
				</form:form> --%>
					<%-- <a href="single/${product.id}.html" target="_blank"><i
						class="fas fa-eye"></i> Xem trước</a> --%>
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

<!-- realtime price, payment -->
<script src="js/jquery-2.2.3.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$('#inputDiscount').val($('#h_discount').val()*100);
		$(document).on('keyup', '#inputPrice', function () {		
			$('#priceHelp').text(Math.ceil(parseInt($('#inputPrice').val())).toFixed(0).replace(/(\d)(?=(\d\d\d)+(?!\d))/g,"$1,")+ ' đ - '+DocTienBangChu($('#inputPrice').val())+' đồng');
			$('#inputRealPrice').val(Math.ceil($('#inputPrice').val() - $('#inputPrice').val() * $('#h_discount').val()).toFixed(0).replace(/(\d)(?=(\d\d\d)+(?!\d))/g,"$1,")+ ' đ');
			$('#h_realPrice').val($('#inputPrice').val() - $('#inputPrice').val() * $('#h_discount').val());
			$('#RealPriceHelp').text(DocTienBangChu($('#h_realPrice').val())+' đồng');
			//$('#hiddenPrice').val($('#inputPrice').val());
		});	
		
		$(document).on('keyup', '#inputDiscount', function () {
			$('#discountHelp').text($('#inputDiscount').val() +'%');
			$('#h_discount').val($('#inputDiscount').val()/100);
			$('#inputRealPrice').val(Math.ceil($('#inputPrice').val() - $('#inputPrice').val() * $('#h_discount').val()).toFixed(0).replace(/(\d)(?=(\d\d\d)+(?!\d))/g,"$1,")+ ' đ');
			$('#h_realPrice').val($('#inputPrice').val() - $('#inputPrice').val() * $('#h_discount').val());
			$('#RealPriceHelp').text(DocTienBangChu($('#h_realPrice').val())+' đồng');
			//$('#hiddenDiscount').val($('#inputDiscount').val()/100);
		});	
		
		/* $(document).on('keyup', '#inputName', function () {
			$('#hiddenName').val($('#inputName').val());
		});
		$(document).on('keyup', '#inputDescription', function () {
			$('#hiddenDescription').val($('#inputDescription').val());
		});
		$(document).on('keyup', '#inputInformation', function () {
			$('#hiddenInformation').val($('#inputInformation').val());
		});
		$(document).on('keyup', '#inputImage', function () {
			$('#hiddenImage').val($('#inputImage').val());
		}); */
	});
</script>
<script type="text/javascript">
var ChuSo=new Array(" không "," một "," hai "," ba "," bốn "," năm "," sáu "," bảy "," tám "," chín ");
var Tien=new Array( "", " nghìn", " triệu", " tỷ", " nghìn tỷ", " triệu tỷ");

//1. Hàm đọc số có ba chữ số;
function DocSo3ChuSo(baso)
{
    var tram;
    var chuc;
    var donvi;
    var KetQua="";
    tram=parseInt(baso/100);
    chuc=parseInt((baso%100)/10);
    donvi=baso%10;
    if(tram==0 && chuc==0 && donvi==0) return "";
    if(tram!=0)
    {
        KetQua += ChuSo[tram] + " trăm ";
        if ((chuc == 0) && (donvi != 0)) KetQua += " linh ";
    }
    if ((chuc != 0) && (chuc != 1))
    {
            KetQua += ChuSo[chuc] + " mươi";
            if ((chuc == 0) && (donvi != 0)) KetQua = KetQua + " linh ";
    }
    if (chuc == 1) KetQua += " mười ";
    switch (donvi)
    {
        case 1:
            if ((chuc != 0) && (chuc != 1))
            {
                KetQua += " mốt ";
            }
            else
            {
                KetQua += ChuSo[donvi];
            }
            break;
        case 5:
            if (chuc == 0)
            {
                KetQua += ChuSo[donvi];
            }
            else
            {
                KetQua += " lăm ";
            }
            break;
        default:
            if (donvi != 0)
            {
                KetQua += ChuSo[donvi];
            }
            break;
        }
    return KetQua;
}

//2. Hàm đọc số thành chữ (Sử dụng hàm đọc số có ba chữ số)

function DocTienBangChu(SoTien)
{
    var lan=0;
    var i=0;
    var so=0;
    var KetQua="";
    var tmp="";
    var ViTri = new Array();
    if(SoTien<0) return "Âm";
    if(SoTien==0) return "Không";
    if(SoTien>0)
    {
        so=SoTien;
    }
    else
    {
        so = -SoTien;
    }
    if (SoTien > 8999999999999999)
    {
        //SoTien = 0;
        return "Quá nhiều ";
    }
    ViTri[5] = Math.floor(so / 1000000000000000);
    if(isNaN(ViTri[5]))
        ViTri[5] = "0";
    so = so - parseFloat(ViTri[5].toString()) * 1000000000000000;
    ViTri[4] = Math.floor(so / 1000000000000);
     if(isNaN(ViTri[4]))
        ViTri[4] = "0";
    so = so - parseFloat(ViTri[4].toString()) * 1000000000000;
    ViTri[3] = Math.floor(so / 1000000000);
     if(isNaN(ViTri[3]))
        ViTri[3] = "0";
    so = so - parseFloat(ViTri[3].toString()) * 1000000000;
    ViTri[2] = parseInt(so / 1000000);
     if(isNaN(ViTri[2]))
        ViTri[2] = "0";
    ViTri[1] = parseInt((so % 1000000) / 1000);
     if(isNaN(ViTri[1]))
        ViTri[1] = "0";
    ViTri[0] = parseInt(so % 1000);
  if(isNaN(ViTri[0]))
        ViTri[0] = "0";
    if (ViTri[5] > 0)
    {
        lan = 5;
    }
    else if (ViTri[4] > 0)
    {
        lan = 4;
    }
    else if (ViTri[3] > 0)
    {
        lan = 3;
    }
    else if (ViTri[2] > 0)
    {
        lan = 2;
    }
    else if (ViTri[1] > 0)
    {
        lan = 1;
    }
    else
    {
        lan = 0;
    }
    for (i = lan; i >= 0; i--)
    {
       tmp = DocSo3ChuSo(ViTri[i]);
       KetQua += tmp;
       if (ViTri[i] > 0) KetQua += Tien[i];
       if ((i > 0) && (tmp.length > 0)) KetQua += ',';//&& (!string.IsNullOrEmpty(tmp))
    }
   if (KetQua.substring(KetQua.length - 1) == ',')
   {
        KetQua = KetQua.substring(0, KetQua.length - 1);
   }
   KetQua = KetQua.substring(1,2).toUpperCase()+ KetQua.substring(2);
   return KetQua;//.substring(0, 1);//.toUpperCase();// + KetQua.substring(1);
}


	</script>


</body>
</html>