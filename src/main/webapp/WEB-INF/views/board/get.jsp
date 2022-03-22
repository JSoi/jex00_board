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

<div class="col-lg=12">
	<div class="panel panel-default"></div>
	<div class="panel-heading">Board Read Page</div>
	<div class="panel-body">

		<div class="form-group">
			<label>Bno</label> <input class="form-control" name='bno'
				value='<c:out value="${board.bno}"/>' readonly="readonly">
		</div>
		<div class="form-group">
			<label>Title</label> <input class="form-control" name='title'
				value='<c:out value="${board.title }"/>' readonly="readonly">
		</div>
		<div class="form-group">
			<label>Text Area</label>
			<textarea class="form-control" rows="3" name='content'
				readonly="readonly"><c:out value="${board.content}"></c:out></textarea>
		</div>
		<div class="form-group">
			<label>Writer</label> <input class="form-control" name='writer'
				value='<c:out value="${board.writer }"/>' readonly="readonly">
		</div>
		<form id='operForm' action="/board/modify" method="get">
			<input type='hidden' id='bno' name='bno'
				value='<c:out value="${board.bno}"/>'> <input type='hidden'
				name='pageNum' value='<c:out value="${cri.pageNum}"/>'> <input
				type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
			<button data-oper='modify' class="btn btn-default"
				onclick="location.href='/board/modify?bno=<c:out value="${board.bno}"/>'">Modify</button>
			<button data-oper='list' class="btn btn-info"
				onclick="location.href='/board/list?pageNum=<c:out value="${cri.pageNum}"/>'">List</button>
		</form>
	</div>
</div>

<%@include file="../includes/footer.jsp"%>
<script type="text/javascript">
$(document).ready(function() {
	var operForm = $("#operForm");
	
	$("button[data-oper='modify']").on("click",function(e){
		operForm.attr("action", "/board/modify").submit();'
	});

	$("button[data-oper='list']").on("click",function(e){
		operForm.find("#bno").remove();
		operForm.attr("action", "/board/list")
		operForm.submit();
	});
});
</script>