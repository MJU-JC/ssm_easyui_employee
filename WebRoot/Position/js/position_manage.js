var position_manage_tool = null; 
$(function () { 
	initPositionManageTool(); //建立Position管理对象
	position_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#position_manage").datagrid({
		url : 'Position/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "positionId",
		sortOrder : "desc",
		toolbar : "#position_manage_tool",
		columns : [[
			{
				field : "positionId",
				title : "职位id",
				width : 70,
			},
			{
				field : "departmentObj",
				title : "所属部门",
				width : 140,
			},
			{
				field : "positionName",
				title : "职位名称",
				width : 140,
			},
			{
				field : "baseSalary",
				title : "基本工资",
				width : 70,
			},
			{
				field : "sellPercent",
				title : "销售提成",
				width : 140,
			},
		]],
	});

	$("#positionEditDiv").dialog({
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
				if ($("#positionEditForm").form("validate")) {
					//验证表单 
					if(!$("#positionEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#positionEditForm").form({
						    url:"Position/" + $("#position_positionId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#positionEditForm").form("validate"))  {
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
			                        $("#positionEditDiv").dialog("close");
			                        position_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#positionEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#positionEditDiv").dialog("close");
				$("#positionEditForm").form("reset"); 
			},
		}],
	});
});

function initPositionManageTool() {
	position_manage_tool = {
		init: function() {
			$.ajax({
				url : "Department/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#departmentObj_departmentNo_query").combobox({ 
					    valueField:"departmentNo",
					    textField:"departmentName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{departmentNo:"",departmentName:"不限制"});
					$("#departmentObj_departmentNo_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#position_manage").datagrid("reload");
		},
		redo : function () {
			$("#position_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#position_manage").datagrid("options").queryParams;
			queryParams["departmentObj.departmentNo"] = $("#departmentObj_departmentNo_query").combobox("getValue");
			queryParams["positionName"] = $("#positionName").val();
			$("#position_manage").datagrid("options").queryParams=queryParams; 
			$("#position_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#positionQueryForm").form({
			    url:"Position/OutToExcel",
			});
			//提交表单
			$("#positionQueryForm").submit();
		},
		remove : function () {
			var rows = $("#position_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var positionIds = [];
						for (var i = 0; i < rows.length; i ++) {
							positionIds.push(rows[i].positionId);
						}
						$.ajax({
							type : "POST",
							url : "Position/deletes",
							data : {
								positionIds : positionIds.join(","),
							},
							beforeSend : function () {
								$("#position_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#position_manage").datagrid("loaded");
									$("#position_manage").datagrid("load");
									$("#position_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#position_manage").datagrid("loaded");
									$("#position_manage").datagrid("load");
									$("#position_manage").datagrid("unselectAll");
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
			var rows = $("#position_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Position/" + rows[0].positionId +  "/update",
					type : "get",
					data : {
						//positionId : rows[0].positionId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (position, response, status) {
						$.messager.progress("close");
						if (position) { 
							$("#positionEditDiv").dialog("open");
							$("#position_positionId_edit").val(position.positionId);
							$("#position_positionId_edit").validatebox({
								required : true,
								missingMessage : "请输入职位id",
								editable: false
							});
							$("#position_departmentObj_departmentNo_edit").combobox({
								url:"Department/listAll",
							    valueField:"departmentNo",
							    textField:"departmentName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#position_departmentObj_departmentNo_edit").combobox("select", position.departmentObjPri);
									//var data = $("#position_departmentObj_departmentNo_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#position_departmentObj_departmentNo_edit").combobox("select", data[0].departmentNo);
						            //}
								}
							});
							$("#position_positionName_edit").val(position.positionName);
							$("#position_positionName_edit").validatebox({
								required : true,
								missingMessage : "请输入职位名称",
							});
							$("#position_baseSalary_edit").val(position.baseSalary);
							$("#position_baseSalary_edit").validatebox({
								required : true,
								validType : "number",
								missingMessage : "请输入基本工资",
								invalidMessage : "基本工资输入不对",
							});
							$("#position_sellPercent_edit").val(position.sellPercent);
							$("#position_sellPercent_edit").validatebox({
								required : true,
								missingMessage : "请输入销售提成",
							});
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
