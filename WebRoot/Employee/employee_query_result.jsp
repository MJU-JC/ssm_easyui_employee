<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/employee.css" /> 

<div id="employee_manage"></div>
<div id="employee_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="employee_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="employee_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="employee_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="employee_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="employee_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="employeeQueryForm" method="post">
			员工编号：<input type="text" class="textbox" id="employeeNo" name="employeeNo" style="width:110px" />
			职位：<input class="textbox" type="text" id="positionObj_positionId_query" name="positionObj.positionId" style="width: auto"/>
			姓名：<input type="text" class="textbox" id="name" name="name" style="width:110px" />
			出生日期：<input type="text" id="birthday" name="birthday" class="easyui-datebox" editable="false" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="employee_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="employeeEditDiv">
	<form id="employeeEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">员工编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="employee_employeeNo_edit" name="employee.employeeNo" style="width:200px" />
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
				<select id="employee_sex_edit" name="employee.sex" >
					<option value="男">男</option>
					<option value="女">女</option>
				</select>
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
				<select id="employee_schoolRecord_edit" name="employee.schoolRecord">
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
				<textarea id="employee_employeeDesc_edit" name="employee.employeeDesc" rows="8" cols="60"></textarea>

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="Employee/js/employee_manage.js"></script> 
