<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>
<html lang="ko">
<head>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="/bootstrap/css/bootstrap.min.css" rel="stylesheet"  type="text/css">
<script src="/bootstrap/js/bootstrap.min.js"></script>
<script src="/js/jquery-3.6.3.min.js"></script>

</head>
<body>
	<div id="file">


		<div>
			<label for="fileUpload" class="btn btn-secondary p-0 py-1 px-2 me-3" style="min-width:3.8rem">파일 업로드</label>
			<input  type="file" name="files" multiple="multiple"  id="fileUpload"  class="d-none fileUpload change" />
			<!-- <div><button type="button" class="mx-1 btn btn-secondary p-1 clientPicUpBtn d-none" style="min-width:3.8rem"></button></div> -->
		</div>

	</div>


</body>
<script>

$(function(){
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
				, beforeSend: function() {
			    },
			    complete:function(){
			    }
		 });

}
</script>
</html>
