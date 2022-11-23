<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="./css/layoutM/header.css" rel="stylesheet" >



<meta name="viewport" content="width=device-width, initial-scale=1">

	<div id="header-contents" class="h-100">


		<div class="item " id="menuBtn" onClick="activeMenu()"  style="flex-basis:20%; min-width:70px;">
		 	<!-- <i class="bi bi-grid-3x3-gap-fill"></i> -->
		 	 <div class="menuIcon">＜메뉴</div>
			 <div id="menu-nav" style=""></div>
		</div>

		<div class="d-flex justify-content-center align-items-center" style="flex-basis:50%; ">

			<div class="partner" style="width:95%;height:80%;">
		</div>

		</div>


		<div class="item" id="funcBtn"  style="flex-basis:30%; min-width:80px;">
			<div class="hearder-item d-flex align-items-center justify-content-end" >
				<!-- <div id="homeBtn" onclick="changeContents('index')"><i class="bi bi-house-door-fill"></i></div> -->
				<div id="dropContent" class="pt-2">
					<div id="dropBtn" class="dropBtn dropBtnBox"  onclick="checkConfirm()">
						<span class="dropBtnBox"><i class="bi bi-person-circle" style="font-size: 18pt !important;"></i></span>
						<c:if test="${sessionScope.rollCd eq '9999'}">
							<span class="dropBtnBox text-white">${mypage.usrNm}  <!-- <i class="bi bi-caret-down-fill dropBtnBox"></i> --></span>
						</c:if>
					</div>

				</div>
			</div>
		</div>
	</div>


<script>
	$(window).ready(function(){
		partner();
	});


	activemenu = 1;

	function activeMenu(){
		if(activemenu == 0){
			$("#sidebar>nav #sidebar-content").css("display","none");
			$("#sidebar").removeClass('show');
			activemenu = 1;

			$(".mask").css("display","none");

		}else{
			$("#sidebar>nav #sidebar-content").css("display","block");
			$("#sidebar").toggleClass('show');
			activemenu = 0;

			setTimeout(function(){
				$(".mask").css("width",$('#main').width());
				$(".mask").css("height","100%");
				$(".mask").css("display","block");
			},400)
		}

	//	seachInitData();

	/* 	$(".mask").css("display","none"); */

	}

	$('body').on('click', '.mask', function(e){
		activemenu =0;
		//activeMenu();
	});


	$('#dropBtn').click(function(){
		$('#dropmenu').toggleClass("show");
	});

	$('#homeBtn').click(function(){
		$('.sidebar-item').removeClass("active");
		$('.sub-item').removeClass("active");


	});


	var checkConfirm = function (){
		var result = confirm('마이페이지로 이동하시겠습니까?');

		if(result) {
			changeContents('myPage');
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
				activeMenu();
			}
		}else{
		}

	});

</script>

