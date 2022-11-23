<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>SCM</title>
<meta name="viewport" content="width=device-width, initial-scale=1  user-scalable=no" />
<!-- <link href="./css/component/swiper-bundle.min.css"  rel="stylesheet" /> -->
<link href="./bootstrap/css/bootstrap.min.css" rel="stylesheet"  type="text/css">
<script src="./bootstrap/js/bootstrap.min.js"></script>
<link href="./bootstrap/icon/bootstrap-icons.css" rel="stylesheet" >
<link href="./css/layoutM/main.css" rel="stylesheet" >
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
/* @font-face {
	font-family: 'GoyangIlsan';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_one@1.0/GoyangIlsan.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;


@font-face {
    font-family: 'BMEuljiro10yearslater';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-10-21@1.0/BMEuljiro10yearslater.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
 */



@font-face {
font-family: 'NanumBarunGothic';
 font-style: normal;
 font-weight: 400;
 src: url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWeb.eot');
 src: url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWeb.eot?#iefix') format('embedded-opentype'), url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWeb.woff') format('woff'), url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWeb.ttf') format('truetype');
}

@font-face {
   font-family: 맑은고딕, Malgun Gothic, dotum, gulim, sans-serif;
    font-weight: normal;
    font-style: normal;
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
			<div id="sidebar">
				<jsp:include page="sidebar.jsp" />
			</div>

			<div id="main" class="main">
				<header id="header" class="main  shadow-sm ">
					<jsp:include page="header.jsp" />
				</header>

				<div id="content" class="main mt-2" style="">

				</div>

	 			<div id="contentDetail" class="main">

				</div>

				<div class="mask"><!--css는  main.css  -->

				</div>

				<div class="mask2" id="mask2"><!--css는  main.css  -->
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



		<input type="hidden" name="" class="searchStartDate" >
		<input type="hidden" name="" class="searchEndDate" >
		<input type="hidden" name="" class="searchRefGubun" >
		<input type="hidden" name="" class="searchRefGubunNm" >
		<input type="hidden" name="" class="searchPoStatus" >
		<input type="hidden" name="" class="searchPoStatusNm" >
		<input type="hidden" name="" class="searchAdCd" >
		<input type="hidden" name="" class="searchAdCdNm" >
		<input type="hidden" name="" class="searchWriter" >
		<input type="hidden" name="" class="searchTitle" >
		<input type="hidden" name="" class="searchOpenYn" >
		<input type="hidden" name="" class="searchOwnNm" >

	</form>
</body>
<script>

	var height = $( window ).height()+'px';
 	var menuButton = document.querySelector('.menu-button');

	var openMenu = function () {
		swiper.slidePrev();
	};

	var swiper = new Swiper('.swiper-container', {
		slidesPerView: 'auto',
		initialSlide: 1,
		resistanceRatio: 0,
		slideToClickedSlide: true,
		on: {
			slideChangeTransitionStart: function () {
				var slider = this;
				if (slider.activeIndex === 0) {
					menuButton.classList.add('cross');
					// required because of slideToClickedSlide
					menuButton.removeEventListener('click', openMenu, true);
				} else {
					menuButton.classList.remove('cross');
				}
			}
			, slideChangeTransitionEnd: function () {
				var slider = this;
				if (slider.activeIndex === 1) {
					menuButton.addEventListener('click', openMenu, true);
				}
			},
		}
	});


	 /*경고창  type="primary:파랑색창 , danger:빨간색창" */
	 function alertBox(text, type){
		$('.mask2').css('display','block');
		var top =  Number( $(document).scrollTop() ) + ( Number(window.innerHeight)/2 ) - 100;
		$('#alertBox').children("div").children("strong").html(text);
		$('#alertBox').css("display","");
		$('#alertBox').css("top",top);
		$('#alertBox').attr("class","alert alert-"+type);
		$('#alertBox').css("width","300px");

		setTimeout(function() {
			$('#alertBox').fadeOut( "slow" );
			$('.mask2').fadeOut( "slow" );
		},3000);
	 }

	 /* function confirmBox(text, type){
			var top =  Number( $(document).scrollTop() ) + ( Number(window.innerHeight)/2 ) - 100;
			$('#confirmBox').children("div").children("strong").html(text);
			$('#confirmBox').css("display","");
			$('#confirmBox').css("top",top);
			$('#confirmBox').attr("class","alert");
			$('#confirmBox').css("width","300px");
			$('#confirmBox').css("background-color","white");
		 } */



	var phoneForm =  function(number){
		 return number.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3");

	 }


	var numberWithCommas =  function(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}



	$( document ).ready(function() {
/* 		var meuePath = $('.sidebar-dropdown').find('li').eq(0).find('.meuePath').val();
		activeClick(0);
		changeContents(meuePath,'get');
		seachInitData();
 */
		setTimeout(function(){
	  		changeHome();
		}, 200);
	});

	var changeHome = function(){
//		var menu = $('.sidebar-dropdown').find('li').eq(0);
		var menu = $('.sidebar-menu').find('.m-menu').find('.sidebar-dropdown').find('li').eq(0);
		var meuePath = menu.find('.meuePath').val();
		activeClick(0);
		if(meuePath){
			changeContents(meuePath,'get');
		}

	}


	var returnAjax =  function(type, url, data){
		$('.loadingbar').css("display","block");

		var result;

 		$.ajax({
 	        type : type,
 	        url : url,
 	        dataType : 'json',
	        async: false,
	        contentType: 'application/json',
	        data: JSON.stringify(data), //보낼데이터
 	        success        :    function(data){
 	        	result = data;
 	        },
 	        beforeSend: function() {


 		    },
 		    complete:function(){
 		    	setTimeout(function(){
 		    		$('.loadingbar').css("display","none");
 		    	}, 500);

 		    }
 		});


		return result;


	}





   /* 초기날짜 세팅 */
  function seachInitData(){

		/* 검색조건 날짜 초기설정 */
		const offset = new Date().getTimezoneOffset() * 60000;
		const today = new Date(Date.now() - offset);


		/*기본날짜 세팅  */
		var startDateBasic = new Date(Date.now() - 30 * 24 * 60 * 60 * 1000).toISOString().slice(0, 10);
		var endDateBasic = today.toISOString().slice(0, 10);

		$('.searchStartDate').val(startDateBasic);
		$('.searchEndDate').val(endDateBasic);


		$('.searchRefGubun').val('');
		$('.searchRefGubunNm').val('');
		$('.searchPoStatus').val('');
		$('.searchPoStatusNm').val('');
		$('.searchAdCd').val('');
		$('.searchAdCdNm').val('');
		$('.searchWriter').val('');
		$('.searchTitle').val('');
		$('.searchOpenYn').val('');
		$('.searchOwnNm').val('');



		//$('#startDate').datepicker("setDate",'2022-06-18');

	}

    /* 조회 클릭시 조회날짜 저장  */
	function saveSearchData(){

		var tableBox = $('#mobile-search .table-box').css('display');
		var searchOpenYn = 'N';
		if(tableBox != 'none'){
			searchOpenYn = 'Y';
		}

		$('.searchOpenYn').val(searchOpenYn);


		$('.searchStartDate').val($('#startDate').val());
		$('.searchEndDate').val($('#endDate').val());

		/*게시자 */
		var writer = $('input[name=writer]').val();
		$('.searchWriter').val(writer);

		/*대상자 */
		var writer = $('input[name=ownNm]').val();
		$('.searchOwnNm').val(writer);

		/*등록자 */
		var title = $('input[name=title]').val();
		$('.searchTitle').val(title);


		/* 자료실 구분 */
		var refGubun = $('.refGubun').find('.select').html();
		var refGubunNm = $('.refGubun').find('.select').closest('a').find('.select-value').html();
		$('.searchRefGubun').val(refGubun);
		$('.searchRefGubunNm').val(refGubunNm);


		/* 진행상태 구분 */
		var poStatus = $('.poStatusBox').find('.select').html();
		var poStatusNm = $('.poStatusBox').find('.select').closest('a').find('.select-value').html();
		$('.searchPoStatus').val(poStatus);
		$('.searchPoStatusNm').val(poStatusNm);

		/* 상품선택 구분 */
		var adCd = $('.adCdBox').find('.select').html();
		var adCdNm = $('.adCdBox').find('.select').closest('a').find('.select-value').html();
		$('.searchAdCd').val(adCd);
		$('.searchAdCdNm').val(adCdNm);

	}





	/*페이지별 검색날짜 세팅 */
	function setSearchData(){
		var searchOpenYn  = $('.searchOpenYn').val();
	  	if(searchOpenYn == 'Y'){
	  		$('.table-box').slideToggle(100);
			$('.hideButton i').toggleClass("rotate");
		}



		$('#startDate').datepicker("setDate",$('.searchStartDate').val());
		$('#endDate').datepicker("setDate",$('.searchEndDate').val());


		/*자료실 구분  */
		var searchRefGubun = $('.searchRefGubun').val();
		var searchRefGubunNm = $('.searchRefGubunNm').val();
		if(searchRefGubun){
			$('.refGubun').find('.param-data').removeClass('select');
			$('.refGubun').find('.'+searchRefGubun).addClass('select');
			$('input[name=refGubun]').val(searchRefGubun);
			$('#refGubun').attr('placeholder',searchRefGubunNm);
		}


		/*상품선택 구분  */
		var searchAdCd = $('.searchAdCd').val();
		var searchAdCdNm = $('.searchAdCdNm').val();
		if(searchAdCd){
			$('.adCdBox').find('.param-data').removeClass('select');
			$('.adCdBox').find('.'+searchAdCd).addClass('select');
			$('input[name=adCd]').val(searchAdCd);
			$('#adCdBox').val(searchAdCdNm);
		}


		/*게시자 */
		var searchWriter = $('.searchWriter').val();
		$('input[name=writer]').val(searchWriter);

		/*대상자 */
		var searchOwnNm = $('.searchOwnNm').val();
		$('input[name=ownNm]').val(searchOwnNm);


		/*등록자 */
		var searchTitle = $('.searchTitle').val();
		$('input[name=title]').val(searchTitle);


		/*진행상태 구분  */
		var searchPoStatus = $('.searchPoStatus').val();
		var searchPoStatusNm = $('.searchPoStatusNm').val();
		if(searchPoStatus){
			$('.poStatusBox').find('.param-data').removeClass('select');
			$('.poStatusBox').find('.poStatus'+searchPoStatus).addClass('select');
			$('input[name=poStatus]').val(searchPoStatus);
			$('#poStatusBox').val(searchPoStatusNm);
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



	var getDate = (paramDay) => {

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

	var copyText = (text) => {
	    const textArea = document.createElement('textarea');
	    document.body.appendChild(textArea);
	    textArea.value = text;
	    textArea.select();
	    document.execCommand('copy');
	    document.body.removeChild(textArea);

	    alertSwal("복사완료!<br>"+text, 'info', false);
	}


	var reactCall = (data) => {
		if (window.ReactNativeWebView) {

			if(data.gubun == 'qr'){
				window.ReactNativeWebView.postMessage(JSON.stringify({
					gubun : data.gubun,
					type : "REQ_CAMERA_PERMISSION"
				}));
			}else if(data.gubun == 'camera'){
				window.ReactNativeWebView.postMessage(JSON.stringify({
					gubun:"camera",
					type : "REQ_CAMERA_PERMISSION",
					soNo : F.soNo,
					xs005 : '',
					status : '',
					mgNo : '',
				}));
			}else if(data.gubun == 'gallary'){

				window.ReactNativeWebView.postMessage(JSON.stringify({
					gubun:"gallary",
					type : "REQ_CAMERA_PERMISSION",
					soNo : F.soNo,
					xs005 : '',
					status : '',
					mgNo : '',
			}));

			}
		} else {
			// 모바일이 아니라면 모바일 아님을 alert로 띄웁니다.
			alertSwal('모바일에서만 사용이 가능합니다','warning',false);
		}

	}


	/* 리액트에서 받은 데이터 */
	document.addEventListener("message", function(data) {
		var result= data.data;


		var str= result.split('/');
		var gubun= str[0];
		var qr = str[1];

		if(result == 'back'){
			F.prevPage();
		}else if(gubun == 'qr'){
			F.qrMatch(qr);
		}

		if(F.reactGubun == 'camera'){
			let image = JSON.parse(result);
			F.addImage(image);
		}else if(F.reactGubun == 'gallary'){
			let image = JSON.parse(result);
			F.addImage(image);
		}


	})




</script>
<style>

.dropdown-menu{
	z-index: 2000 !important;
}
</style>
</html>

