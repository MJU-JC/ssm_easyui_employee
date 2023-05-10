$(function () {
	$.ajax({
		url : "Employee/" + $("#employee_employeeNo_edit").val() + "/update",
		type : "get",
		data : {
			//employeeNo : $("#employee_employeeNo_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (employee, response, status) {
			$.messager.progress("close");
			if (employee) { 
				$("#employee_employeeNo_edit").val(employee.employeeNo);
				$("#employee_employeeNo_edit").validatebox({
					required : true,
					missingMessage : "请输入员工编号",
					editable: false
				});
				$("#employee_positionObj_positionId_edit").combobox({
					url:"../Position/listAll",
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
				$("#employee_employeePhotoImg").attr("src", "../" +　employee.employeePhoto);
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

	$("#employeeModifyButton").click(function(){ 
		if ($("#employeeEditForm").form("validate")) {
			$("#employeeEditForm").form({
			    url:"Employee/" +  $("#employee_employeeNo_edit").val() + "/update",
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
			$("#employeeEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
		}
	});
});
