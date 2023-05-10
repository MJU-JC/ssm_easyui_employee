$(function () {
	$.ajax({
		url : "Position/" + $("#position_positionId_edit").val() + "/update",
		type : "get",
		data : {
			//positionId : $("#position_positionId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (position, response, status) {
			$.messager.progress("close");
			if (position) { 
				$("#position_positionId_edit").val(position.positionId);
				$("#position_positionId_edit").validatebox({
					required : true,
					missingMessage : "请输入职位id",
					editable: false
				});
				$("#position_departmentObj_departmentNo_edit").combobox({
					url:"../Department/listAll",
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

	$("#positionModifyButton").click(function(){ 
		if ($("#positionEditForm").form("validate")) {
			$("#positionEditForm").form({
			    url:"Position/" +  $("#position_positionId_edit").val() + "/update",
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
                	var obj = jQuery.parseJSON(data);
                    if(obj.success){
                        $.messager.alert("消息","信息修改成功！");
                        location.href="frontlist";
                    }else{
                        $.messager.alert("消息",obj.message);
                    } 
			    }
			});
			//提交表单
			$("#positionEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
		}
	});
});
