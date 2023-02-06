<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>SCM</title>
<meta name="viewport" content="width=device-width, initial-scale=1  user-scalable=no" />
<!-- <link href="./css/component/swiper-bundle.min.css"  rel="stylesheet" /> -->
<link href="./bootstrap/css/bootstrap.min.css" rel="stylesheet"  type="text/css">
<link href="./bootstrap/icon/bootstrap-icons.css" rel="stylesheet" >
<link href="./css/layout/main.css" rel="stylesheet" >
<link href="./css/normalize.css" rel="stylesheet">
<script src="./js/priceComma.js"></script>
<script src="./js/validate.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" rel="stylesheet" />

<script src="./bootstrap/js/jquery-3.6.0.min.js"></script>
<!-- <script src="./bootstrap/js/jquery-ui.js"></script> -->
<script src="./js/swiper-bundle.min.js"></script>
<script src="./js/jquery.fileDownload.js"></script>

<link rel="shortcut icon" type="image/x-icon" href=images/favicon.ico />
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
<link rel="stylesheet" href="./css/component/loadingbar.css" />
<link href="./css/component/selectSearch.css" rel="stylesheet">
<link href="./css/component/tableScroll.css" rel="stylesheet">

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>




<style>
@font-face {
   font-family: 맑은고딕, Malgun Gothic, dotum, gulim, sans-serif;
    font-weight: normal;
    font-style: normal;
}


@font-face {
font-family: 'NanumBarunGothic';
 font-style: normal;
 font-weight: 400;
 src: url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWeb.eot');
 src: url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWeb.eot?#iefix') format('embedded-opentype'), url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWeb.woff') format('woff'), url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWeb.ttf') format('truetype');
}

@font-face {
 	font-family: 'GmarketSansMedium';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}

body{
	font-family :NanumBarunGothic !important;
}


</style>


</head>


<body>
	<form id="form" name="form">

		<div id="wrapper"  class="">


			<div id="main" class="main">
				 <header id="header" class="main shadow-sm ">
					<jsp:include page="header.jsp" />
				</header>

				<div id="sidebar" class="shadow-sm">
					<jsp:include page="sidebar.jsp" />
				</div>

				<div id="content" class="main px-5" style="margin-top:10px;">
					<%-- <jsp:include page="<%=contentPage%>" /> --%>


				</div>

	 			<div id="contentDetail" class="main">

				</div>


				<div class="mask">

				</div>
			</div>

			<!--공지사항  -->
			<div class="modal fade" tabindex="-1" role="dialog" id="announce">
				<div class="modal-dialog modal-xl d-flex justify-content-center" role="document" >
					<div class="modal-content" style="width:90%" >
						<div class="modal-body p-0 ">
							<div>
								<div class="d-flex justify-content-between py-1 border-bottom-1"  style="background-color:">
									<div class="ms-2 ">
										<span style="color:#FFB432" class="me-1">[공지] </span><span>경조사 신청 및 지원문의</span>
									</div>
									<div class="me-2">
										<button style="color:white;" type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button>
									</div>
								</div>

							</div>

							<div class="d-flex justify-content-center">
								<img src="./images/test.png"  style="object-fit: scale-down;width:90%">
							</div>


						</div>
					</div>
				</div>
			</div>

		</div>


		<div class="loadingbar">
			<div class="loadingMask d-flex justify-content-center">
					<div class="spinner-grow text-secondary me-1" role="status">
						<span class="sr-only"></span>
					</div>
					<div class="spinner-grow text-danger me-1" role="status">
						<span class="sr-only"></span>
					</div>
					<div class="spinner-grow text-warning" role="status">
					 	<span class="sr-only"></span>
					</div>
			</div>
		</div>



		<div id="alertBox" class="alert alert-danger" style="position:absolute; z-index:1200 ;display:none;left:50%;width:80%;transform: translate(-50%);box-shadow : rgba(0,0,0,0.5) 0 0 0 9999px;text-align:center">
			<div><strong></strong></div>
		</div>

		<div id="confirmBox" class="alert alert-danger" style="position:absolute; ;display:none;left:50%;width:80%;transform: translate(-50%);box-shadow : rgba(0,0,0,0.5) 0 0 0 9999px;text-align:center">
			<div class="mt-4"><strong></strong></div>

			<div class="d-flex justify-content-end mt-5">
				<div class="me-2">
					 <button type="button" id="confirmYBtn" class=" btn btn-primary shadow-sm p-0">
						<div style="font-size: calc(0.26vw + 8.6pt); padding:4px 14px">확인</div>
				   	</button>
				</div>

				<div class="me-2">
					 <button type="button" id="confirmNBtn" class=" btn btn-secondary shadow-sm p-0">
						<div style="font-size: calc(0.26vw + 8.6pt); padding:4px 14px">취소</div>
				   	</button>
				</div>


			</div>
		</div>

	</form>
</body>
<script>

	var height = $( window ).height()+'px';
 	var menuButton = document.querySelector('.menu-button');



	 /*경고창  type="primary:파랑색창 , danger:빨간색창" */
	 function alertBox(text, type){

		var top =  Number( $(document).scrollTop() ) + ( Number(window.innerHeight)/2 ) - 100;
		var width =  (text.length * 10)+200;

		$('#alertBox').children("div").children("strong").html(text);
		$('#alertBox').css("display","");
		$('#alertBox').css("top",top);
		$('#alertBox').attr("class","alert alert-"+type);
		$('#alertBox').css("width", width);
		setTimeout(function() {
			$('#alertBox').fadeOut( "slow" );
		},3000);
	 }


	var phoneForm =  function(number){
		 return number.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3");

	 }


	var numberWithCommas =  function(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}



	$( document ).ready(function() {
		//changeContents('so','get');
		//activeClick(1);
		//$("#announce").modal('show');

	  	setTimeout(function(){
	  		changeHome();
		}, 200);


	});

	var changeHome = function(){
		var menu = $('.sidebar-dropdown').find('li').eq(0);
		var meuePath = menu.find('.meuePath').val();
		activeClick(menu);
		if(meuePath){
			changeContents(meuePath,'get');
		}

	}

	/* alert UI */
	async function alertSwal(text, icon, confirmBtn){

		var yesBtnColor = '';
		var noBtnColor = '';
		var resultData = false;

		if(icon == 'warning'){
			yesBtnColor = '#e63316';
			noBtnColor = '#7f7f7f';

			}else if(icon == 'success' || icon == 'error' || icon == "info"){
				yesBtnColor = '#0f67bc';

				}

		if(confirmBtn){
			await Swal.fire({

				title: text,
				icon: icon,
				showCancelButton: confirmBtn,
				confirmButtonColor: yesBtnColor,
				confirmButtonText: '확인',
				cancelButtonColor: noBtnColor,
				cancelButtonText: '취소',
				}).then((result) => {
					resultData = result.isConfirmed;
					/* console.log(result.isConfirmed); */

					/* if (result.isConfirmed) {
						alertSwal("완료되었습니다.", "success", false);
						} else {
							//alertSwal("실패하였습니다. 다시시도해주세요.", "error", false);
						}*/
					})


		} else {
			await Swal.fire({

				icon: icon,
				title: text,
				showCancelButton :confirmBtn,
				confirmButtonColor: yesBtnColor,
				confirmButtonText: '확인',
			})

			resultData = true;
		}



		return resultData;

	} // alertSwal

	let getDate = (paramDay) => {

		if(!paramDay){
			paramDay = 0;
		}

		let date  = new Date();
		 	date  = new Date(date.setDate(date.getDate() + paramDay));
		let year  = date.getFullYear();
		let month = new String(date.getMonth() + 1);
			month = month >= 10 ? month : '0' + month; // month 두자리로 저장
		let day   = new String(date.getDate());
			day   = day >= 10 ? day : '0' + day; //day 두자리로 저장

		let result    = year + "-" + month + "-" + day;

		return result;

	}


</script>
<style>

.dropdown-menu{
	z-index: 2000 !important;
}
</style>
</html>

