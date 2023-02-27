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
						<div class="dropzone" style="border: 3px dashed lightsalmon;">
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

Dropzone.autoDiscover = false; // deprecated 된 옵션. false로 해놓는걸 공식문서에서 명시
const dropzone = new Dropzone('div.dropzone', {

   url: 'https://httpbin.org/post', // 파일을 업로드할 서버 주소 url.
   method: 'post', // 기본 post로 request 감. put으로도 할수있음
   headers: {
      // 요청 보낼때 헤더 설정
    //  Authorization: 'Bearer ' + token, // jwt
   },

   autoProcessQueue: false, // 자동으로 보내기. true : 파일 업로드 되자마자 서버로 요청, false : 서버에는 올라가지 않은 상태. 따로 this.processQueue() 호출시 전송
   clickable: true, // 클릭 가능 여부
   autoQueue: false, // 드래그 드랍 후 바로 서버로 전송
   createImageThumbnails: true, //파일 업로드 썸네일 생성

   thumbnailHeight: 120, // Upload icon size
   thumbnailWidth: 120, // Upload icon size

   maxFiles: 100, // 업로드 파일수
   maxFilesize: 1000, // 최대업로드용량 : 100MB
   paramName: 'image', // 서버에서 사용할 formdata 이름 설정 (default는 file)
   parallelUploads: 2, // 동시파일업로드 수(이걸 지정한 수 만큼 여러파일을 한번에 넘긴다.)
   uploadMultiple: true, // 다중업로드 기능
   timeout: 300000, //커넥션 타임아웃 설정 -> 데이터가 클 경우 꼭 넉넉히 설정해주자

   addRemoveLinks: true, // 업로드 후 파일 삭제버튼 표시 여부
   dictRemoveFile: '삭제', // 삭제버튼 표시 텍스트
   acceptedFiles: '.jpeg,.jpg,.png,.gif,.JPEG,.JPG,.PNG,.GIF,.mp4', // 이미지 파일 포맷만 허용

   init: function () {
      // 최초 dropzone 설정시 init을 통해 호출
      console.log('최초 실행');
      let myDropzone = this; // closure 변수 (화살표 함수 쓰지않게 주의)

      // 서버에 제출 submit 버튼 이벤트 등록
      document.querySelector('버튼').addEventListener('click', function () {
         console.log('업로드');

         // 거부된 파일이 있다면
         if (myDropzone.getRejectedFiles().length > 0) {
            let files = myDropzone.getRejectedFiles();
            console.log('거부된 파일이 있습니다.', files);
            return;
         }

         myDropzone.processQueue(); // autoProcessQueue: false로 해주었기 때문에, 메소드 api로 파일을 서버로 제출
      });

      // 파일이 업로드되면 실행
      this.on('addedfile', function (file) {
         // 중복된 파일의 제거
         if (this.files.length) {
            // -1 to exclude current file
            var hasFile = false;
            for (var i = 0; i < this.files.length - 1; i++) {
               if (
                  this.files[i].name === file.name &&
                  this.files[i].size === file.size &&
                  this.files[i].lastModifiedDate.toString() === file.lastModifiedDate.toString()
               ) {
                  hasFile = true;
                  this.removeFile(file);
               }
            }
            if (!hasFile) {
               addedFiles.push(file);
            }
         } else {
            addedFiles.push(file);
         }
      });

      // 업로드한 파일을 서버에 요청하는 동안 호출 실행
      this.on('sending', function (file, xhr, formData) {
         console.log('보내는중');
      });

      // 서버로 파일이 성공적으로 전송되면 실행
      this.on('success', function (file, responseText) {
         console.log('성공');
      });

      // 업로드 에러 처리
      this.on('error', function (file, errorMessage) {
         alert(errorMessage);
      });
   },

});


$("div.dropzone").dropzone({

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
