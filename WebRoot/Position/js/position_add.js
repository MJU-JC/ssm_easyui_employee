$(function () {
	$("#position_departmentObj_departmentNo").combobox({
	    url:'Department/listAll',
	    valueField: "departmentNo",
	    textField: "departmentName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#position_departmentObj_departmentNo").combobox("getData"); 
            if (data.length > 0) {
                $("#position_departmentObj_departmentNo").combobox("select", data[0].departmentNo);
            }
        }
	});
	$("#position_positionName").validatebox({
		required : true, 
		missingMessage : '请输入职位名称',
	});

	$("#position_baseSalary").validatebox({
		required : true,
		validType : "number",
		missingMessage : '请输入基本工资',
		invalidMessage : '基本工资输入不对',
	});

	$("#position_sellPercent").validatebox({
		required : true, 
		missingMessage : '请输入销售提成',
	});

	//单击添加按钮
	$("#positionAddButton").click(function () {
		//验证表单 
		if(!$("#positionAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
		} else {
			$("#positionAddForm").form({
			    url:"Position/add",
			    onSubmit: function(){
					if($("#positionAddForm").form("validate"))  { 
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
                        $("#positionAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                    }
			    }
			});
			//提交表单
			$("#positionAddForm").submit();
		}
	});

	//单击清空按钮
	$("#positionClearButton").click(function () { 
		$("#positionAddForm").form("clear"); 
	});
});
