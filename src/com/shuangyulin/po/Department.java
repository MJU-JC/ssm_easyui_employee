package com.shuangyulin.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Department {
    /*部门编号*/
    @NotEmpty(message="部门编号不能为空")
    private String departmentNo;
    public String getDepartmentNo(){
        return departmentNo;
    }
    public void setDepartmentNo(String departmentNo){
        this.departmentNo = departmentNo;
    }

    /*部门名称*/
    @NotEmpty(message="部门名称不能为空")
    private String departmentName;
    public String getDepartmentName() {
        return departmentName;
    }
    public void setDepartmentName(String departmentName) {
        this.departmentName = departmentName;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonDepartment=new JSONObject(); 
		jsonDepartment.accumulate("departmentNo", this.getDepartmentNo());
		jsonDepartment.accumulate("departmentName", this.getDepartmentName());
		return jsonDepartment;
    }}