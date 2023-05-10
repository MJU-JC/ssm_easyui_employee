<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_user_logstate.jsp"/>
<!DOCTYPE html>
<html>
<head>
<title>修改页面</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/easyui/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/easyui/themes/icon.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/position.css" />
</head>
<body style="margin:0px; font-size:14px; background-image:url(../images/bg.jpg); background-position:bottom; background-repeat:repeat;">
<div id="position_editDiv">
	<form id="positionEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">职位id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="position_positionId_edit" name="position.positionId" value="<%=request.getParameter("positionId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">所属部门:</span>
			<span class="inputControl">
				<input class="textbox"  id="position_departmentObj_departmentNo_edit" name="position.departmentObj.departmentNo" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">职位名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="position_positionName_edit" name="position.positionName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">基本工资:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="position_baseSalary_edit" name="position.baseSalary" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">销售提成:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="position_sellPercent_edit" name="position.sellPercent" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="positionModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/locale/easyui-lang-zh_CN.js" ></script>
<script src="${pageContext.request.contextPath}/Position/js/position_modify.js"></script> 
</body>
</html>
