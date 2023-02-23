<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>
<html lang="ko">
<head>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
<script src="/bootstrap/js/bootstrap.min.js"></script>
<script src="/js/jquery-3.6.3.min.js"></script>
<link href="https://uicdn.toast.com/grid/latest/tui-grid.css" rel="stylesheet"/>
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>

</head>
<body>
	<div id="file">

		<div class="fileWrap d-flex flex-wrap"  >

			<section class="sliderWarp wrap"  style=" width:50%">
				<div class="m-2">
					<div class="d-flex justify-content-center bg-dark" style="width:100%; height:400px;">
						<ul class="slider ">

					  	</ul>
				  	</div>

				</div>


			</section>

			<section  class="filesWrap wrap"   style=" width:50%">
				<div class="d-flex justify-content-end my-2">
					<div>
						<label for="fileUpload" class="btn btn-secondary p-0 py-1 px-2 me-3" style="">파일 업로드</label>
						<input  type="file" name="files" multiple="multiple"  id="fileUpload"  class="d-none fileUpload change" />
					</div>
				</div>

				<!-- 드래그인 드래그  -->
				<div>

				</div>
				<!-- 그리드 추가  -->
				<div id ="fileGrid">

				</div>
			</section>

		</div>


	</div>
</body>
<script>

$(function(){
});

const param = () => {

	let rowData = [
		  {
		    fileName: '사슴',
		    filePath: 'Ed Sheeran',
		    fileType: 'image',
		    genre: 'Pop'
		  },
		  {
		    name: 'A Head Full Of Dreams',
		    artist: 'Coldplay',
		    price: 25000,
		    genre: 'Rock'
		  }
		];
}

const fileGrid =  new tui.Grid({

	el : document.getElementById('fileGrid'),
	scrollX : true,
	scrollY : true,
	bodyHeight : window.innerHeight-720,
	rowHeight : 30,
	editingEvent: 'click',
	rowHeaders: [ {
		type:'checkbox',},'rowNum'],
	header : {
		height: 40,
		complexColumns: []
	},
	columns : [
		{
			header : '정렬', name  : 'sortBtn',
			width  : '30',   align : 'center',
		},
		{
			header : '파일명', name  : 'fileName',
			width  : '350',   align : 'left',
		},
		{
			header : '파일크기(MB)', name  : 'fileSize',
			width  : '50',        align : 'right',
		},
		{
			header : '보기', name  : 'viewBtn',
			width  : '30',    align: 'center',
		},
		{
			header : '다운로드', name  : 'downBtn',
			width  : '30',    align: 'center',
		},
		{
			header : '삭제', name  : 'delBtn',
			width  : '30',    align: 'center',
		},
	],
	columnOptions : {
		resizable : true
	},
});

tui.Grid.applyTheme('striped', {
	cell: {
		header: {
			 background : '#f2e5d7'
        },
        focused: {
        	background : '#f2e5d7'
        },

      },
   row: {
        hover: {
          background: '#ccc'
        },
        dummy: {
          background: '#ccc'
        }

    }
});




const F = {
	fileUpload : function(){
		fileUpload();
	}
}

$('#file').on('click change','.change, .click',function(e){
	if(e.type=='click'){

	}else if(e.type=='change'){
		if($(this).hasClass('fileUpload')){
			F.fileUpload();
		}
	}
});




const fileUpload = () => {

	let formData = new FormData();
	let files = $("input[name=files]")[0].files;

	$(files).each(function(i,e){
		formData.append('files' , files[i]);
	});

	let data ={};

   $.ajax({
        type : "post",
        url : "upload",
        dataType : 'json',
        enctype: 'multipart/form-data', // 필수
        processData: false, // 필수
		contentType: false, // 필수
		cache: false,
        data: formData,
        success        :    function(e){
        	data = e ;
        }
		, beforeSend: function(e) {
			console.log(e);
	    },
	    complete:function(){
	    	//fileSizeDown(data);
	    }
	 });

}

const fileSizeDown = function(data){

	   	let flag = true;
	   	let result = '';
	   	let files = {};
	   	files.data = data;

		if(flag){

		 	let formData = new FormData();
			formData.delete('status');
			formData.append("status" , "I");
			let files = $("input[name=files]")[0].files;

			$(files).each(function(i,e){
				formData.append('files' , files[i]);
			});

			formData.append('data',JSON.stringify(data));


	 	     $.ajax({
		        type : "post",
		        url : "fileSizeDown",
		        dataType : 'json',
		        enctype: 'multipart/form-data', // 필수
		        processData: false, // 필수
				contentType: false, // 필수
				cache: false,
		        data: formData,
		        success        :    function(data){

		        },beforeSend: function() {

			    },complete:function(){

			    }
			 });
		}


	}

</script>
<style>

	/*공통*/
	.tui-grid-cell-header {
		background-color: #f2e5d7;
	}

	.wrap{
			width:50% !important;
		}

	/* PC */
	@media all and (min-width:1024px) {
	}

	/* Tab */
	@media screen and (max-width:1020px) {

	}

	/* Mobile  */
	@media screen and (max-width:767px) {
		.wrap{
			width:100% !important;
		}

	}


</style>
</html>
