﻿var employee_manage_tool = null; 
$(function () { 
	initEmployeeManageTool(); //建立Employee管理对象
	employee_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#employee_manage").datagrid({
		url : 'Employee/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "employeeNo",
		sortOrder : "desc",
		toolbar : "#employee_manage_tool",
		columns : [[
			{
				field : "employeeNo",
				title : "员工编号",
				width : 140,
			},
			{
				field : "positionObj",
				title : "职位",
				width : 140,
			},
			{
				field : "name",
				title : "姓名",
				width : 140,
			},
			{
				field : "sex",
				title : "性别",
				width : 140,
			},
			{
				field : "employeePhoto",
				title : "员工照片",
				width : "70px",
				height: "65px",
				formatter: function(val,row) {
					return "<img src='" + val + "' width='65px' height='55px' />";
				}
 			},
			{
				field : "birthday",
				title : "出生日期",
				width : 140,
			},
			{
				field : "schoolRecord",
				title : "学历",
				width : 140,
			},
		]],
	});

	$("#employeeEditDiv").dialog({
		title : "修改管理",
		top: "50px",
		width : 700,
		height : 515,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#employeeEditForm").form("validate")) {
					//验证表单 
					if(!$("#employeeEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#employeeEditForm").form({
						    url:"Employee/" + $("#employee_employeeNo_edit").val() + "/update",
						    onSubmit: function(){
								if($("#employeeEditForm").form("validate"))  {
				                	$.messager.progress({
										text : "正在提交数据中...",
									});
				                	return true;
				                } else { 
				                    return false; 
				                }
						    },
						    success:function(data){
						    	$.messager.progress("close");
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#employeeEditDiv").dialog("close");
			                        employee_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#employeeEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#employeeEditDiv").dialog("close");
				$("#employeeEditForm").form("reset"); 
			},
		}],
	});
});

function initEmployeeManageTool() {
	employee_manage_tool = {
		init: function() {
			$.ajax({
				url : "Position/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#positionObj_positionId_query").combobox({ 
					    valueField:"positionId",
					    textField:"positionName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{positionId:0,positionName:"不限制"});
					$("#positionObj_positionId_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#employee_manage").datagrid("reload");
		},
		redo : function () {
			$("#employee_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#employee_manage").datagrid("options").queryParams;
			queryParams["employeeNo"] = $("#employeeNo").val();
			queryParams["positionObj.positionId"] = $("#positionObj_positionId_query").combobox("getValue");
			queryParams["name"] = $("#name").val();
			queryParams["birthday"] = $("#birthday").datebox("getValue"); 
			$("#employee_manage").datagrid("options").queryParams=queryParams; 
			$("#employee_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#employeeQueryForm").form({
			    url:"Employee/OutToExcel",
			});
			//提交表单
			$("#employeeQueryForm").submit();
		},
		remove : function () {
			var rows = $("#employee_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var employeeNos = [];
						for (var i = 0; i < rows.length; i ++) {
							employeeNos.push(rows[i].employeeNo);
						}
						$.ajax({
							type : "POST",
							url : "Employee/deletes",
							data : {
								employeeNos : employeeNos.join(","),
							},
							beforeSend : function () {
								$("#employee_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#employee_manage").datagrid("loaded");
									$("#employee_manage").datagrid("load");
									$("#employee_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#employee_manage").datagrid("loaded");
									$("#employee_manage").datagrid("load");
									$("#employee_manage").datagrid("unselectAll");
									$.messager.alert("消息",data.message);
								}
							},
						});
					}
				});
			} else {
				$.messager.alert("提示", "请选择要删除的记录！", "info");
			}
		},
		edit : function () {
			var rows = $("#employee_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Employee/" + rows[0].employeeNo +  "/update",
					type : "get",
					data : {
						//employeeNo : rows[0].employeeNo,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (employee, response, status) {
						$.messager.progress("close");
						if (employee) { 
							$("#employeeEditDiv").dialog("open");
							$("#employee_employeeNo_edit").val(employee.employeeNo);
							$("#employee_employeeNo_edit").validatebox({
								required : true,
								missingMessage : "请输入员工编号",
								editable: false
							});
							$("#employee_positionObj_positionId_edit").combobox({
								url:"Position/listAll",
							    valueField:"positionId",
							    textField:"positionName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#employee_positionObj_positionId_edit").combobox("select", employee.positionObjPri);
									//var data = $("#employee_positionObj_positionId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#employee_positionObj_positionId_edit").combobox("select", data[0].positionId);
						            //}
								}
							});
							$("#employee_name_edit").val(employee.name);
							$("#employee_name_edit").validatebox({
								required : true,
								missingMessage : "请输入姓名",
							});
							$("#employee_sex_edit").val(employee.sex);
							$("#employee_sex_edit").validatebox({
								required : true,
								missingMessage : "请输入性别",
							});
							$("#employee_employeePhoto").val(employee.employeePhoto);
							$("#employee_employeePhotoImg").attr("src", employee.employeePhoto);
							$("#employee_birthday_edit").datebox({
								value: employee.birthday,
							    required: true,
							    showSeconds: true,
							});
							$("#employee_schoolRecord_edit").val(employee.schoolRecord);
							$("#employee_schoolRecord_edit").validatebox({
								required : true,
								missingMessage : "请输入学历",
							});
							$("#employee_employeeDesc_edit").val(employee.employeeDesc);
						} else {
							$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
