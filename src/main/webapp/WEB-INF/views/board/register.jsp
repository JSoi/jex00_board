<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "httpL//www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>

<div class="row">
	<div class="col-lg=12">
		<h1 class="page-header">Board Register</h1>
	</div>
</div>

<div class="col-lg=12">
	<div class="panel panel-default"></div>
	<div class="panel-heading">Board Register</div>
	<div class="panel-body">
		<form role="form" action="/board/register" method="post">
			<div class="form-group">
				<label>Title</label> <input class="form-control" name='title'>
			</div>
			<div class="form-group">
				<label>Text Area</label>
				<textarea class="form-control" rows"="3" name='content'></textarea>
			</div>
			<div class="form-group">
				<label>Writer</label><input class="form-control" name='writer'>
			</div>
			<button type="submit" class="btn btn-default">Submit Button</button>
			<button type="reset" class="btn btn-default">Reset Button</button>
		</form>
	</div>
	<div class="row">
		<div class="col-lg=12">
			<div class="panel panel-default">
				<div class="panel-heading">File Attach</div>
				<div class="panel-body">
					<div class="form-group uploadDiv">
						<input type="file" name='uploadFile' multiple>
					</div>
					<div class='uploadResult'>
						<ul></ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<style>
.uploadResult {
	width: 100%;
	background-color: gray;
}

.uploadResult ul {
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}

.uploadResult ul li {
	list-style: none;
	padding: 10px;
	align-content: center;
	text-align: center;
}

.uploadResult ul li img {
	width: 100px;
}

.uploadResult ul li span {
	color: white;
}

.bigPictureWrapper {
	position: absolute;
	display: none;
	justify-content: center;
	align-items: center;
	top: 0%;
	width: 100%;
	height: 100%;
	background-color: gray;
	z-index: 100;
	background: rgba(255, 255, 255, 0.5);
}

.bigPicture {
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
}

.bigPicture img {
	width: 600px;
}
</style>

<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
<script>
	$(document).ready(function(e) {
		var formObj = $("form[role='form']");
		$("button[type='submit']").on("click", function(e) {
			e.preventDefault();
			console.log("submit Clicked");

			var str = "";
			$(".uploadResult ul li").each(function(i, obj) {
				var jobj = $(obj);
				console.dir(jobj);
				str += "<input type ='hidden' name ='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
				str += "<input type ='hidden' name ='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
				str += "<input type ='hidden' name ='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
				str += "<input type ='hidden' name ='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>";
			});
			console.log("str check(register) : " + str);
			formObj.append(str).submit();
		});
		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		var maxSize = 5242880;
		function checkExtension(fileName, fileSize) {
			if (fileSize > maxSize) {
				alert("?????? ????????? ??????");
				return false;
			}
			if (regex.test(fileName)) {
				alert("?????? ????????? ????????? ???????????? ??? ????????????.");
				return false;
			}
			return true;
		}
		$("input[type='file']").change(function(e) {
			var formData = new FormData();
			var inputFile = $("input[name='uploadFile']");
			var files = inputFile[0].files;
			for (var i = 0; i < files.length; i++) {
				if (!checkExtension(files[i].name, files[i].size)) {
					return false;
				}
				formData.append("uploadFile", files[i]);
			}
			console.log("formData : " + formData);
			$.ajax({
				url : '/uploadAjaxAction',
				processData : false,
				contentType : false,
				data : formData,
				type : 'POST',
				dataType : 'json',
				success : function(result) {
					console.log(result);
					showUploadResult(result);
					alert("Uploaded--ready");
				}
			}); // ajax end
		});
		$(".uploadResult").on("click", "button", function(e) {
			console.log("delete file");
			var targetFile = $(this).data("file");
			var type = $(this).data("type");
			var targetLi = $(this).closest("li");
			$.ajax({
				url : '/deleteFile',
				data : {
					fileName : targetFile,
					type : type
				},
				type : 'POST',
				success : function(result) {
					alert(result);

				}
			});// ajax end
			targetLi.remove();
		});

	});
	function showUploadResult(uploadResultArr) {
		console.log("showingresult");
		if (!uploadResultArr || uploadResultArr.length === 0) {
			return;
		}
		var uploadUL = $(".uploadResult ul");
		var str = "";
		$(uploadResultArr)
				.each(
						function(i, obj) {
							console.log("i : " + i);
							console.log("obj : " + obj);
							if (obj.fileType) { // image
								var fileCallPath = encodeURIComponent(obj.uploadPath
										+ "/s_" + obj.uuid + "_" + obj.fileName);
								str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.fileType+"'><div>";
								str += "<span>" + obj.fileName + "</span>";
								str += "<button type='button' data-type='image' data-file='"+fileCallPath+"' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
								str += "<img src='/display?fileName="
										+ fileCallPath + "'>";
								str += "</div>";
								str += "</li>";
							} else {
								var fileCallPath = encodeURIComponent(obj.uploadPath
										+ "/" + obj.uuid + "_" + obj.fileName);
								var fileLink = fileCallPath.replace(new RegExp(
										/\\/g), "/");
								str += "<li data-path='" + obj.uploadPath
										+ "' data-uuid='" + obj.uuid
										+ "' data-fileName='" + obj.fileName
										+ "' data-type='" + obj.fileType
										+ "'><div>";
								str += "<span> " + obj.fileName + "</span>";
								str += "<button type='button' data-type='file' data-file='"+fileCallPath+"' class='btn btn-warning btn-circle'> <i class='fa fa-times'></i></button><br>";
								str += "<img src='/resources/img/attach.png'>";
								str += "</div></li>";

							}
						});
		console.log("str : " + str);
		uploadUL.append(str);
		// 		$.ajax({
		// 			url : '/uploadAjaxAction',
		// 			processData : false,
		// 			contentType : false,
		// 			data : formData,
		// 			type : 'POST',
		// 			dataType : 'json',
		// 			success : function(result) {
		// 				console.log(result);
		// 				showUploadResult(result);
		// 			}
		// 		}); // ajax end
	}
</script>
<%@include file="../includes/footer.jsp"%>