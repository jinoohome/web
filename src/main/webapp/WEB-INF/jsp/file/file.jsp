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
<script src="https://unpkg.com/dropzone@5/dist/min/dropzone.min.js"></script>
<link rel="stylesheet" href="https://unpkg.com/dropzone@5/dist/min/dropzone.min.css" type="text/css"/>

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
				<!-- 드래그인 드래그  -->
				<div class="m-2">
					<div>
						<div class="" style="border: 3px dashed lightsalmon;">
							<div class="dz-message" data-dz-message><span>파일을 마우스로 끌어 오세요</span></div>
						</div>
					</div>

				</div>

				<div class="d-flex justify-content-end my-2">
					<div class="w-100 mx-2">
						<label for="fileUpload" class="btn btn-secondary p-0 py-1 px-2 me-3 w-100" style="">사진&영상 추가하기</label>
						<input  type="file" name="files" multiple="multiple"  id="fileUpload"  class="d-none fileUpload change" />
					</div>
				</div>


				<!-- 그리드 추가  -->
				<div id ="fileGrid">

				</div>


				<div class="w-100 mx-2">
					<label for="saveFile" class="btn btn-primary p-0 py-1 px-2 me-3 w-100" style="">저장하기</label>
					<input  type="button" name="files" multiple="multiple"  id="saveFile"  class="d-none saveFile click" />
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
		height: 0,
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
	},
	saveFile : function(){
		saveFile();
	}
}

$('#file').on('click change','.change, .click',function(e){
	if(e.type=='click'){
		if($(this).hasClass('saveFile')){
			F.saveFile();
		}

	}else if(e.type=='change'){
		if($(this).hasClass('fileUpload')){
			F.fileUpload();
		}
	}
});


const formData = new FormData();

const fileUpload = () => {

	let files = $("input[name=files]")[0].files;

	$(files).each(function(i,e){
		formData.append('files' , files[i]);
	});

}

const saveFile = function(){

    $.ajax({
        type : "post",
        url : "uploadTui",
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
