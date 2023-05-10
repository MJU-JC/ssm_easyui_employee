<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_user_logstate.jsp"/>
<!DOCTYPE html>
<html>
<head>
<title>修改页面</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/easyui/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/easyui/themes/icon.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/employee.css" />
</head>
<body style="margin:0px; font-size:14px; background-image:url(../images/bg.jpg); background-position:bottom; background-repeat:repeat;">
<div id="employee_editDiv">
	<form id="employeeEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">员工编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="employee_employeeNo_edit" name="employee.employeeNo" value="<%=request.getParameter("employeeNo") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">职位:</span>
			<span class="inputControl">
				<input class="textbox"  id="employee_positionObj_positionId_edit" name="employee.positionObj.positionId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">姓名:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="employee_name_edit" name="employee.name" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">性别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="employee_sex_edit" name="employee.sex" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">员工照片:</span>
			<span class="inputControl">
				<img id="employee_employeePhotoImg" width="200px" border="0px"/><br/>
    			<input type="hidden" id="employee_employeePhoto" name="employee.employeePhoto"/>
				<input id="employeePhotoFile" name="employeePhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">出生日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="employee_birthday_edit" name="employee.birthday" />

			</span>

		</div>
		<div>
			<span class="label">学历:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="employee_schoolRecord_edit" name="employee.schoolRecord" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">员工介绍:</span>
			<span class="inputControl">
				<textarea id="employee_employeeDesc_edit" name="employee.employeeDesc" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="employeeModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/locale/easyui-lang-zh_CN.js" ></script>
<script src="${pageContext.request.contextPath}/Employee/js/employee_modify.js"></script> 
</body>
</html>
