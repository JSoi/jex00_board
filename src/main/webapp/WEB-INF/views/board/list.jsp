<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "httpL//www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<%@include file="../includes/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!-- Page Heading -->
<h1 class="h3 mb-2 text-gray-800">Tables</h1>
<p class="mb-4">
	DataTables is a third party plugin that is used to generate the demo
	table below. For more information about DataTables, please visit the <a
		target="_blank" href="https://datatables.net">official DataTables
		documentation</a>.
</p>
<!-- Begin Page Content -->

<!-- DataTales Example -->
<div class="card shadow mb-4">
	<div class="card-header py-3">
		<h6 class="m-0 font-weight-bold text-primary">DataTables Example</h6>
	</div>

	<div class="card-body">
		<div class="table-responsive">
			<table class="table table-bordered" id="dataTable" width="100%"
				cellspacing="0">
				<thead>
					<tr>
						<th>#번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>수정일</th>
					</tr>
				</thead>
				<c:forEach items="${list}" var="board">
					<tr>
						<td><c:out value="${board.bno} " /></td>
						<td><a href='/board/get?bno=<c:out value="${board.bno}"/>'>
						<c:out value="${board.title} " /></a></td>
						<td><c:out value="${board.writer} " /></td>
						<td><fmt:formatDate pattern="yyyy-MM-dd"
								value="${board.regdate}" /></td>
						<td><fmt:formatDate pattern="yyyy-MM-dd"
								value="${board.updateDate}" /></td>
					</tr>
				</c:forEach>
				<tfoot>
					<tr>
						<th>#번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>수정일</th>
					</tr>
				</tfoot>

				</tbody>
			</table>
		</div>
	</div>
	<!-- /.container-fluid -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="moddal-title" id="myModalLabel">Modal Title</h4>
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
				</div>

				<div class="modal-body">처리가 완료되었습니다.</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary">Save changes</button>
				</div>
			</div>
		</div>
	</div>
	<div class="panel-heading">
		Board List Page
		<button id='regBtn' type="Button" class="btn btn-xs pull-right">Register
			New Brand</button>
	</div>
</div>
<!-- End of Main Content -->
<%@include file="../includes/footer.jsp"%>
<script type="text/javascript">
	$(document).ready(
			function() {
				var result = '<c:out value="${result}"/>';
				checkModal(result);
				history.replaceState({},null,null);
				function checkModal(result) {
					if (result === '' || history.state) {
						return;
					}
					if (parseInt(result) > 0) {
						$(".modal-body").html(
								"게시글 " + parseInt(result) + " 번이 등록되었습니다.");
					}
					$("#myModal").modal("show");
				}
				$("#regBtn").on("click", function() {
					self.location = "/board/register";
				});
			});
</script>