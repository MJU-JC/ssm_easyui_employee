$(function () {
	$("#employee_employeeNo").validatebox({
		required : true, 
		missingMessage : '请输入员工编号',
	});

	$("#employee_positionObj_positionId").combobox({
	    url:'Position/listAll',
	    valueField: "positionId",
	    textField: "positionName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#employee_positionObj_positionId").combobox("getData"); 
            if (data.length > 0) {
                $("#employee_positionObj_positionId").combobox("select", data[0].positionId);
            }
        }
	});
	$("#employee_name").validatebox({
		required : true, 
		missingMessage : '请输入姓名',
	});

	$("#employee_sex").validatebox({
		required : true, 
		missingMessage : '请输入性别',
	});

	$("#employee_birthday").datebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	$("#employee_schoolRecord").validatebox({
		required : true, 
		missingMessage : '请输入学历',
	});

	//单击添加按钮
	$("#employeeAddButton").click(function () {
		//验证表单 
		if(!$("#employeeAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
		} else {
			$("#employeeAddForm").form({
			    url:"Employee/add",
			    onSubmit: function(){
					if($("#employeeAddForm").form("validate"))  { 
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
                    //此处data={"Success":true}是字符串
                	var obj = jQuery.parseJSON(data); 
                    if(obj.success){ 
                        $.messager.alert("消息","保存成功！");
                        $("#employeeAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                    }
			    }
			});
			//提交表单
			$("#employeeAddForm").submit();
		}
	});

	//单击清空按钮
	$("#employeeClearButton").click(function () { 
		$("#employeeAddForm").form("clear"); 
	});
});
