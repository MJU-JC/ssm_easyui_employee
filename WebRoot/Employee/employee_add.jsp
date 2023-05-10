<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/employee.css" />
<div id="employeeAddDiv">
	<form id="employeeAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">员工编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="employee_employeeNo" name="employee.employeeNo" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">职位:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="employee_positionObj_positionId" name="employee.positionObj.positionId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">姓名:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="employee_name" name="employee.name" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">性别:</span>
			<span class="inputControl">
				<select id="employee_sex" name="employee.sex">
					<option value="男">男</option>
					<option value="女">女</option>
				</select>
			</span>

		</div>
		<div>
			<span class="label">员工照片:</span>
			<span class="inputControl">
				<input id="employeePhotoFile" name="employeePhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">出生日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="employee_birthday" name="employee.birthday" />

			</span>

		</div>
		<div>
			<span class="label">学历:</span>
			<span class="inputControl">
				<select id="employee_schoolRecord" name="employee.schoolRecord">
					<option value="小学">小学</option>
					<option value="初中">初中</option>
					<option value="高中">高中</option>
					<option value="大专">大专</option>
					<option value="本科">本科</option>
					<option value="硕士">硕士</option>
					<option value="博士">博士</option> 
				</select>
			</span>

		</div>
		<div>
			<span class="label">员工介绍:</span>
			<span class="inputControl">
				<textarea id="employee_employeeDesc" name="employee.employeeDesc" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="employeeAddButton" class="easyui-linkbutton">添加</a>
			<a id="employeeClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Employee/js/employee_add.js"></script> 
