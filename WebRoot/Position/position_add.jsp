<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/position.css" />
<div id="positionAddDiv">
	<form id="positionAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">所属部门:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="position_departmentObj_departmentNo" name="position.departmentObj.departmentNo" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">职位名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="position_positionName" name="position.positionName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">基本工资:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="position_baseSalary" name="position.baseSalary" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">销售提成:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="position_sellPercent" name="position.sellPercent" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="positionAddButton" class="easyui-linkbutton">添加</a>
			<a id="positionClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Position/js/position_add.js"></script> 
