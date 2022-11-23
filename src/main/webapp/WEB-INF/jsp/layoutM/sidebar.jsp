<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link href="./css/layoutM/sidebar.css" rel="stylesheet" >
<script src="./js/tab.js"></script>
	<nav class="nav-side" >
		<div id="sidebar-content">
			<div class="sidebar-brand " onclick="changeContents('/index')">
		    	<!-- <div><img src="./images/icon_logo.png"></img></div> -->
		    	<!-- <div id="band-text">현진시닝</div> -->
		    	<div class=""><img src="./images/logo_c.png" ></div>
		    </div>

		    <div class="sidebar-menu">

				<c:forEach var="categroy" items="${categroies}" varStatus="status">

					<ul class="${categroy.prgmFileName}">
						<li class="sidebar-item">
							<div class="sidebar-link ms-2">
				              	<span class="" style="font-family :GmarketSansMedium !important;">${categroy.menuName} </span>
			            		<span class="ms-3"><i class="bi bi-caret-up-fill"></i></span>
			            	</div>

							<ul class="sidebar-dropdown" >
								<c:forEach var="menu" items="${menues}" varStatus="status">
									<c:choose>
										<c:when test="${categroy.menuId eq menu.paMenuId }">
											<li class="sub-item d-flex align-items-center ps-4" style="height:40px;" onclick="changeContents('${menu.prgmPath}','get')">
												<a class="sidebar-link" >
													<!-- <i class="bi bi-caret-right me-1"></i> -->${menu.menuName}
												</a>
												<input type="hidden" class="meuePath" value="${menu.prgmPath}">
											</li>
										</c:when>
										<c:otherwise>

										</c:otherwise>
									</c:choose>

								</c:forEach>
							</ul>
						</li>

					</ul>
				</c:forEach>

			</div>

		</div>
	</nav>

	<div class="commonName">
		<input type='hidden' name="poBpCd" value="<%=(String)session.getAttribute("poBpCd")%>">
		<input type='hidden' name="poBpNm" value="<%=(String)session.getAttribute("poBpNm")%>">
	</div>

<script>
function changeContents(url, type){

  	var tabNum = 1;

	$('.nav-link').each(function (index, item) {

		if($(this).hasClass("active")){
			tabNum 	 = index+1;
		}
	});

     $.ajax({
        type: type,
        url : url,
        dataType: 'html',
        data: $("#form").serialize(), //보낼데이터
        success : function(data){
        	  $("#content").children().remove();
              $("#content").html(data);
        }
        , beforeSend: function() {
        	$('.loadingbar').css("display","block");

        },
        complete:function(){
		/* 	partner(url); */
         	tabChange(tabNum);
        // 	poStatus(url);
         	ownNmSearch();
         	//adCdSearch(url);

         	$('.loadingbar').css("display","none");
        }
       });
}

function changeContentDetail(url, type, formData, content){
	$("#content").hide();
	$("#contentDetail").hide();

	 $("#"+content).show();

    $.ajax({
       type: type,
       url : url,
       dataType: 'html',
       data: formData,
       processData: false,
       contentType: false,
       success : function(data){
       	  $("#"+content).children().remove();
          $("#"+content).html(data);
       }
       , beforeSend: function() {
    	  /*  $('.loadingbar').css("display","block"); */
       },
       complete:function(){
			/* partner(url); */
    	   /* $('.loadingbar').css("display","block"); */

       }
      });
}


$('.sidebar-link').click(function(){
	 $(this).next('.sidebar-dropdown').slideToggle(100);
	 $(this).find('.bi-caret-up-fill').toggleClass("rotate");
});

$('.sidebar-item').click(function(){
 	 $(this).addClass("active").siblings().removeClass("active");

});

$('.sub-item').click(function(){
	/* const swiper = document.querySelector('.swiper-container').swiper;
	swiper.slideNext(); */
	$('.sub-item').closest('.sidebar-menu').find('.sub-item').removeClass("active");
 	$(this).addClass("active");

  	activeMenu();

});

var activeClick = function(num){
	$('.sub-item').siblings().removeClass("active");
	$('.m-menu').find('.sidebar-dropdown').find('li').eq(num).addClass("active");
 	//$(div).addClass("active");
}



$('.sidebar-brand').click(function(){
	/* const swiper = document.querySelector('.swiper-container').swiper;
	swiper.slideNext(); */
	$('.sidebar-item').removeClass("active");
	$('.sub-item').removeClass("active");
	$('#menu-nav span').css("display","none");

});


var partner = function(url){


	 var pts = JSON.parse('${pts}');

	 var poBpCd = '<%=(String)session.getAttribute("bpCd")%>';
	 var poBpNm = '<%=(String)session.getAttribute("bpNm")%>';
/*
	 var poBpCd = $('input[name=bpCd]').val();
	 var poBpNm =$('input[name=bpNm]').val(); */

	 var data ='';
	 if(pts.length == 1){
		data =
			'<div class="dropdown">'+
			'	<div class="dropdown-input">'+
			'		<input type="text"  style="height:26px;"  class="drop3btn form-control w-100 rounded-pill text-center" placeholder="'+poBpNm+'" >  '+
			'	</div>                                              '+
			'	 <div class="dropdown-content shadow-lg poBpCd d-none" style="border-radius: 13px;">   '+
			'		<a class="">                         '+
			'			<span class="d-none param-data select">'+poBpCd+'</span>     '+
			'			<span class="select-value">'+poBpNm+'</span>    '+
			'		</a>        										';

	  }else{
		data =

			'<div class="dropdown">'+
			'	<div class="dropdown-input">'+
			'		<input type="text"  style="height:26px;"  class="drop3btn form-control w-100 rounded-pill ps-3" placeholder="전체" '+
			'			onclick="" onkeyup="filterFunction(this)">  '+
			'		<i class="bi bi-chevron-down down-icon"></i>    '+
			'	</div>                                              '+
			'	 <div class="dropdown-content shadow-lg poBpCd" style="border-radius: 13px;">   '+
			'<a class=" ">                         '+
			'	<span class="d-none param-data select"></span>     '+
			'	<span class="select-value ">전체</span>    '+
			'</a>        										';



		for(var i=0; i<pts.length; i++){
			if(pts[i].bpCd == poBpCd){
				data +=
					'<a class=" ">                         '+
					'	<span class="d-none param-data select">'+pts[i].bpCd+'</span>     '+
					'	<span class="select-value ">'+pts[i].bpNm+'</span>    '+
					'</a>        										';
			}else{
				data +=
					'<a class="">                         '+
					'	<span class="d-none param-data">'+pts[i].bpCd+'</span>     '+
					'	<span class="select-value">'+pts[i].bpNm+'</span>    '+
					'</a>        										';
			}


		}

	}

	data +=
		'	</div>                                              '+
		'</div>      											';


	$('.partner').children().remove();
	$('.partner').append(data);

}




//검색창 진행상태 콤보
var poStatus = function(page){
	const formData = new FormData();
	formData.append("page",page);
	var url= 'status';
	var content = ''
	$.ajax({
    	type        :    "post",
   	 	url : url,
    	dataType    :    'json',
        data: formData, //보낼데이터
        processData: false,
        contentType: false,
    	success        :    function(data){

			content =
    			'<div class="dropdown">'+
    			'	<div class="dropdown-input">'+
    			'		<input type="text" id="poStatusBox" class="drop3btn form-control w-100" placeholder="진행상태" '+
    			'			onkeyup="filterFunction(this)">                             '+
    			'		<i class="bi bi-chevron-down down-icon"></i>                      '+
    			'	</div>                                                                         '+
    			'	 <div class="dropdown-content rounded poStatusBox">                              '+
    			'			<a class="">                                                  '+
    			'				<span class="d-none param-data"></span>       '+
    			'				<span class="select-value">전체</span>            '+
    			'			</a>                                                                   ';


    		for (var i = 0; i < data.length;i++) {

    			content +=	'			<a class="">                                                  '+
    			'				<span class="d-none param-data poStatus'+data[i].poStatusCd+'">'+data[i].poStatusCd+'</span>       '+
    			'				<span class="select-value">'+data[i].poStatusNm+'</span>            '+
    			'			</a>                                                                   ';

    		}
    		content +='	</div>                                                                         '+
 			'</div>';
    	}
    	,beforeSend: function() {
    	},
    	complete:function(){

     		$('.poStatus').children().remove();
    		$('.poStatus').append(content);
    }
   });
}

//검색창 대상차 필드
var ownNmSearch = function(){
	var data =
		'<input type="text" name="ownNm" class="form-control input-bottom-border ownNm" placeholder="대상자" />';
	$('.ownNmSearch').children().remove();
	$('.ownNmSearch').append(data);
}


//검색창 상담결과 콤보
var adCdSearch = function(page){
/* 	const formData = new FormData();
	formData.append("majorCd","CM009");
 */
 	var url= 'api/minor';
	var content = ''

	var data  = {
			majorCd : 'CM009',
	};

	$.ajax({
    	type : "post",
   	 	url : url,
   	    dataType : 'json',
        async: false,
        contentType: 'application/json',
        data: JSON.stringify(data), //보낼데이터
    	success        :    function(data){
			content =
    			'<div class="dropdown">'+
    			'	<div class="dropdown-input">'+
    			'		<input type="text" id="adCdBox" class="drop3btn form-control w-100" placeholder="상담결과" '+
    			'			onkeyup="filterFunction(this)">                             '+
    			'		<i class="bi bi-chevron-down down-icon"></i>                      '+
    			'	</div>                                                                         '+
    			'	 <div class="dropdown-content rounded adCdBox">                              '+
    			'			<a class="">                                                  '+
    			'				<span class="d-none param-data"></span>       '+
    			'				<span class="select-value">전체</span>            '+
    			'			</a>                                                                   ';


    		for (var i = 0; i < data.length;i++) {

    			content +=	'			<a class="">                                                  '+
    			'				<span class="d-none param-data '+data[i].code+'">'+data[i].code+'</span>       '+
    			'				<span class="select-value">'+data[i].codeName+'</span>            '+
    			'			</a>                                                                   ';

    		}
    		content +='	</div>                                                                         '+
 			'</div>';
    	}
    	,beforeSend: function() {
    	},
    	complete:function(){
     		$('.adCdSearch').children().remove();
    		$('.adCdSearch').append(content);
    }
   });
}

//min Status 상태값 가져오기
var minPostatus = function(soNo){
	const formData = new FormData();
	formData.append("soNo",soNo);

	var result ='';
	var url = 'minPoStatus';
    $.ajax({
        type        :    "post",
        url : url,
        dataType    :    'json',
        data: formData, //보낼데이터
        processData: false,
        contentType: false,
        async : false,
        success        :    function(data){

        	result = data.msgCd;

            if(data.msgCd == '3'){
	            alertBox(data.msgText, "danger");
             }
        }
	    , beforeSend: function() {
			$('.loadingbar').css("display","block");
	    },
	    complete:function(){
	     	$('.loadingbar').css("display","none");
	    }
	});

    return result;

}

var maxStatus = function(soNo){
	const formData = new FormData();
	formData.append("soNo",soNo);

	var result ='';
	var url = 'maxPoStatus';
    $.ajax({
        type        :    "post",
        url : url,
        dataType    :    'json',
        data: formData, //보낼데이터
        processData: false,
        contentType: false,
        async : false,
        success        :    function(data){

        	result = data.msgCd;

            if(data.msgCd == '3'){
	            alertBox(data.msgText, "danger");
             }
        }
	    , beforeSend: function() {
			$('.loadingbar').css("display","block");
	    },
	    complete:function(){
	     	$('.loadingbar').css("display","none");
	    }
	});

    return result;

}




/* 공통 화면 조절 */

$('body').on('click', '.poBpCd a', function(e){
	var poBpCd = $(this).find('.param-data').html();
	var poBpNm = $(this).find('.select-value').html();

	$('input[name=poBpCd]').val(poBpCd);
	$('input[name=poBpNm]').val(poBpNm);



	var data  = {
	    	    "poBpCd" : poBpCd,
	    	    "poBpNm" : poBpNm,
	};

	var list ='';

	$.ajax({
        type : "post",
        url : "session/poBpCd",
        dataType : 'json',
        contentType: 'application/json',
        data: JSON.stringify(data), //보낼데이터
        success        :    function(data){

        }
	});


});



</script>
