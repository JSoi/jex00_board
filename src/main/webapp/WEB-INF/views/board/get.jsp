<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "httpL//www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>

<div class="row">
	<div class="col-lg=12">
		<h1 class="page-header">Board Read</h1>
	</div>
</div>

<div class="row">
	<div class="col-lg=12">
		<div class="panel panel-default"></div>
		<div class="panel-heading">Board Read Page</div>
		<div class="panel-body">

			<form role="form" action="/board/register" method="post">
				<div class="form-group">
					<label>Bno</label> <input class="form-control" name='bno'
						value='<c:out value="${board.bno }"/>' readonly="readonly">
				</div>
				<div class="form-group">
					<label>Title</label> <input class="form-control" name='title'
						value='<c:out value="${board.title }"/>' readonly="readonly">
				</div>
				<div class="form-group">
					<label>Text Area</label>
					<textarea class="form-control" rows"
						="3" name='content'
						readonly="readonly">
					<c:out value="${board.content}"></c:out></textarea>
				</div>
				<div class="form-group">
					<label>Writer</label> <input class="form-control" name='writer'
						value='<c:out value="${board.writer }"/>' readonly="readonly">
				</div>
				
				<button data-oper='modify' class="btn btn-default">Modify</button>
				<button data-oper='list' class="btn btn-info">List</button>
			</form>
		</div>
	</div>
	<form id='operForm' action="/board/modify" method="get">
		<input type='hidden' id='bno' name='bno'
			value='<c:out value="${board.bno}"/>'>
	</form>
</div>
<%@include file="../includes/footer.jsp"%>
<script type="text/javascript">
$(document).ready(function(){
	var operForm =$("#operForm");
	$("button[data-oper='modify']").on("click",function(e){
		operForm.attr("action", "/board/modify").submit();'
	});
	
	$("button[data-oper]='list']").on("click",function(e){
		operForm.find("#bno").remove();
		operForm.attr("action", "/board/list")
		operForm.submit();'
	});
});
</script>