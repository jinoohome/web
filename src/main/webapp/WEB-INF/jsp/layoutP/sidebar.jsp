<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link href="./css/layout/sidebar.css" rel="stylesheet" >
<script src="./js/tab.js"></script>
	<nav class="nav-side"  >

		<div id="sidebar-content" onmouseleave=" mouseOutMenu() ">

		    <div class="sidebar-menu  d-flex justify-content-center"  >

				<c:forEach var="categroy" items="${categroies}" varStatus="status">

					<ul class="${categroy.prgmFileName}"  style="cursor:pointer; "  onmouseenter="mouseOverMenu()">
						<li class="sidebar-item border-1">
							<div class="sidebar-link mb-3 ps-3">
				              	<span class="align-middle fw-bold"  style="color:gray;font-family :GmarketSansMedium !important; font-size: calc(0.26vw + 11.08pt)!important;">${categroy.menuName} </span>
			            	<!-- 	<span><i class="bi bi-caret-up-fill"></i></span> -->
			            	</div>

							<ul class="sidebar-dropdown" style="" >
								<c:forEach var="menu" items="${menues}" varStatus="status">
									<c:choose>
										<c:when test="${categroy.menuId eq menu.paMenuId }">
											<li class="sub-item d-flex align-items-center  w-100 ${menu.prgmPath}" style="height:50px;" onclick="changeContents('${menu.prgmPath}','get')">
											 	<a class="sidebar-link fw-bold"  style="width:180px;">
											 		<!-- <i class="bi bi-caret-right me-1"></i> -->
											 		${menu.menuName}</a>
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
		<input type='hidden' name="bpCd" value="<%=(String)session.getAttribute("bpCd")%>">
		<input type='hidden' name="bpNm" value="<%=(String)session.getAttribute("bpNm")%>">
		<input type='hidden' class="url" value="">
	</div>

<script>
function changeContents(url, type){

	$('.url').val(url);


  	var tabNum = 1;

	$('.nav-link').each(function (index, item) {

		if($(this).hasClass("active")){
			tabNum 	 = index+1;
		}
	});

	var bpCd = $('.poBpCd').find('.select').html();
	//var bpCd =	 $('.headBpCd').val();
	var usrId =	 $('.headUsrId').val();

	var data =
	{
		bpCd : bpCd	,
		usrId : usrId	,

	};


     $.ajax({
        type: type,
        url : url,
        dataType: 'html',
        data: data, //보낼데이터
        success : function(data){

        	  $("#content").children().remove();
              $("#content").html(data);
        }
        , beforeSend: function() {
        	$('.loadingbar').css("display","block");

        },
        complete:function(){
         	tabChange(tabNum);
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
	 //$(this).next('.sidebar-dropdown').slideToggle(100);
	 $(this).find('.bi-caret-up-fill').toggleClass("rotate");
});

/* $('.sidebar-item').click(function(){
 	 $(this).addClass("active").siblings().removeClass("active");

}); */

$('.sub-item').click(function(){
	/* const swiper = document.querySelector('.swiper-container').swiper;
	swiper.slideNext(); */
	$('.sub-item').closest('.sidebar-menu').find('.sub-item').removeClass("active");
 	$(this).addClass("active");
	/* activeClick($(this));
 */
//  	activeMenu();

});

var activeClick = function(div){

	$('.sub-item').removeClass("active");
	div.addClass("active");
	//$('.sidebar-dropdown').find('li').eq(div.index()).addClass("active");
 	//$(div).addClass("active");
 	mouseOutMenu();
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
			'		<input type="text" class="drop3btn form-control w-100 rounded-pill ps-3" placeholder="'+poBpNm+'" >  '+
			'	</div>                                              '+
			'	 <div class="dropdown-content shadow-lg poBpCd d-none" style="border-radius: 13px;">   '+
			'		<a class="">                         '+
			'			<span class="d-none param-data select">'+poBpCd+'</span>     '+
			'			<span class="select-value ">'+poBpNm+'</span>    '+
			'		</a>        										';

	  }else{
		data =

			'<div class="dropdown">'+
			'	<div class="dropdown-input">'+
			'		<input type="text" class="drop3btn form-control w-100 rounded-pill ps-3" placeholder="전체" '+
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
    			'		<input type="text" class="drop3btn form-control w-100" placeholder="진행상태" '+
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
    			'				<span class="d-none param-data">'+data[i].poStatusCd+'</span>       '+
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

var ownNmSearch = function(){
	var data =
		'<input type="text" name="ownNm" class="form-control input-bottom-border" placeholder="대상자" />';
	$('.ownNmSearch').children().remove();
	$('.ownNmSearch').append(data);
}

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
    			'		<input type="text" class="drop3btn form-control w-100" placeholder="상담결과" '+
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
    			'				<span class="d-none param-data">'+data[i].code+'</span>       '+
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





/* 공통 화면 조절 */

/* 리액트에서 받은 데이터 */
document.addEventListener("message", function(data) {
	var result= data.data;

	if(result == 'upload'){
		refreshPic();
	}else if(result == 'back'){
		$( "#prevPage" ).trigger( "click" );
	}


})


$( window ).ready(function() {
	//activeMenu();
});

</script>
