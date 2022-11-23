<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- <link href="./css/layout/header.css" rel="stylesheet" > -->
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>



	<div id="header-contents" class="d-flex align-items-center w-100 pb-1 h-100" >

		<div>
			<input type="hidden" class="headBpCd" value="${mypage.bpCd}" />
			<input type="hidden" class="headUsrId" value="${mypage.usrId}" />
			<input type="hidden" class="headUsrNm" value="${mypage.usrNm}" />
		</div>


	<!-- 	<div class="item" id="menuBtn" onClick="activeMenu()" style="flex-basis: 3%;display:flex;">
			<div class="d-flex align-items-center ms-2">
			 	<i class="bi bi-grid-3x3-gap-fill" style="color:#FF8C0A;font-weight:bold;cursor:pointer;
					font-size: calc(0.26vw + 15.08pt);margin-right:10px;padding-top:0px;"></i>
			</div>
		</div>
 -->

		<div class="d-flex justify-content-center align-items-center ps-4 pe-5" style="flex-basis: 6%; cursor:pointer" >
			<div class="" onClick="changeHome()">
				<img src="/images/logo.png"
				onerror="this.src='/images/logo.png'"
				style="height:38px!important;">
			</div>
		</div>




		<div class="d-flex" style="flex-basis:71%">
			<!-- <div class="item upperBpCd me-2" style="width:200px;" >
			</div>
			<div class="item lowerBpCd" style="width:300px;" >
			</div> -->

			<div class="item partner" style="width:300px;" >
			</div>


		</div>

		<div class="item d-flex justify-content-end align-items-end " id="funcBtn" style="flex-basis: 20%;">
			<div class="hearder-item d-flex justify-content-end align-items-end pt-2" >
				<!-- <div id="homeBtn" class="me-2 text-white" style="cursor:pointer;font-size: calc(0.26vw + 13.08pt)!important" onclick="changHome()"><i class="bi bi-house-door-fill  "></i></div> -->
				<div id="dropContent">
					<div id="dropBtn" class="dropBtn dropBtnBox d-flex align-items-center "  onclick="checkConfirm()">
						<span style="cursor:pointer;font-size: calc(0.26vw + 16.08pt)!important" class="dropBtnBox me-2 text-white"><i class="bi bi-person-circle "></i></span>
						<span style="cursor:pointer;font-size: calc(0.26vw + 10.08pt)!important;" class="me-2 dropBtnBox text-white">${mypage.usrNm}  <!-- <i class="bi bi-caret-down-fill dropBtnBox"></i> --></span>
					</div>

				</div>
			</div>
		</div>




</div>


<script>
	$(window).ready(function(){
		partner();
	});

	var activemenu = 0;


	function mouseOverMenu(){
		if(activemenu == 0 ){
			$("#sidebar-content").toggleClass('show');
			$("#header-contents").toggleClass('show');
			$(".align-middle").addClass('active');
			activemenu = 1;
		}
	}
	function mouseOutMenu(){
		if(activemenu == 1 ){
			$("#sidebar-content").removeClass('show');
			$("#header-contents").removeClass('show');
			$(".align-middle").removeClass('active');
			activemenu = 0;
		}
	}

	$('body').on('click', '.mask', function(e){
		activemenu =0;
		//activeMenu();
	});


	$('#dropBtn').click(function(){
		$('#dropmenu').toggleClass("show");
	});

	$('#homeBtn').click(function(){
		changeHome();


	});


	var checkConfirm = function (){
		var result = confirm('마이페이지로 이동하시겠습니까?');

		if(result) {
			changeContents('myPage','get');
		} else {

		}

	};


	$("#header-contents").click(function(e){
		if (!$(e.target).hasClass("dropBtnBox")) {
			if($('#dropmenu').hasClass("show")){
				 $('#dropmenu').removeClass("show");
			}
	   	}

	});


	$("#wrapper").click(function(e){
		if ($(e.target).hasClass("mask")) {
			if(activemenu == 0){
				/* activeMenu(); */
			}
		}else{
		}

	});

	function closePage(){

	}




	/* 공통 화면 조절 */

	$('body').on('click', '.poBpCd a', function(e){
		var bpCd = $(this).find('.param-data').html();
		var bpNm = $(this).find('.select-value').html();


		$('.headBpCd').val(bpCd);
		$('.headBpNm').val(bpNm);

		var url = $('.url').val();

		changeContents(url,'get');

	});






	var crmZlowerBpcdS02 = function(data){
   		var result;

 		$.ajax({
 	        type : "post",
 	        url : "/crmZlowerBpcdS02",
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

 		    }
 		});

 		return result;
	}



	var returnAjax =  function(type, url, data){

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
 		    	}, 1000);

 		    }
 		});


		return result;


	}




</script>

<style>

#header-contents.show{
	position:absolute;
	top:0;
	height:70px !important;
	z-index:20;
	background-color: #293042;

}


@media all and (min-width:1024px){

}

@media screen and (max-width:1020px){

	#header-contents>.item:nth-child(3) .hearder-item #homeBtn{
		display:none;
	}

/* 	#header-contents>.item:nth-child(3) .hearder-item #dropBtn span:nth-child(1){
		display:none;
	} */

}


@media screen and (max-width:767px){


	#header-contents #funcBtn {
	    flex-basis: 30%;
	}


	#header-contents .hearder-item #homeBtn{
	/* 	display:none; */

	}

}



</style>


