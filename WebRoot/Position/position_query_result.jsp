<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/position.css" /> 

<div id="position_manage"></div>
<div id="position_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="position_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="position_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="position_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="position_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="position_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="positionQueryForm" method="post">
			所属部门：<input class="textbox" type="text" id="departmentObj_departmentNo_query" name="departmentObj.departmentNo" style="width: auto"/>
			职位名称：<input type="text" class="textbox" id="positionName" name="positionName" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="position_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="positionEditDiv">
	<form id="positionEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">职位id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="position_positionId_edit" name="position.positionId" style="width:200px" />
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
	</form>
</div>
<script type="text/javascript" src="Position/js/position_manage.js"></script> 
