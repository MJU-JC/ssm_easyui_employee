package com.shuangyulin.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Position {
    /*职位id*/
    private Integer positionId;
    public Integer getPositionId(){
        return positionId;
    }
    public void setPositionId(Integer positionId){
        this.positionId = positionId;
    }

    /*所属部门*/
    private Department departmentObj;
    public Department getDepartmentObj() {
        return departmentObj;
    }
    public void setDepartmentObj(Department departmentObj) {
        this.departmentObj = departmentObj;
    }

    /*职位名称*/
    @NotEmpty(message="职位名称不能为空")
    private String positionName;
    public String getPositionName() {
        return positionName;
    }
    public void setPositionName(String positionName) {
        this.positionName = positionName;
    }

    /*基本工资*/
    @NotNull(message="必须输入基本工资")
    private Float baseSalary;
    public Float getBaseSalary() {
        return baseSalary;
    }
    public void setBaseSalary(Float baseSalary) {
        this.baseSalary = baseSalary;
    }

    /*销售提成*/
    @NotEmpty(message="销售提成不能为空")
    private String sellPercent;
    public String getSellPercent() {
        return sellPercent;
    }
    public void setSellPercent(String sellPercent) {
        this.sellPercent = sellPercent;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonPosition=new JSONObject(); 
		jsonPosition.accumulate("positionId", this.getPositionId());
		jsonPosition.accumulate("departmentObj", this.getDepartmentObj().getDepartmentName());
		jsonPosition.accumulate("departmentObjPri", this.getDepartmentObj().getDepartmentNo());
		jsonPosition.accumulate("positionName", this.getPositionName());
		jsonPosition.accumulate("baseSalary", this.getBaseSalary());
		jsonPosition.accumulate("sellPercent", this.getSellPercent());
		return jsonPosition;
    }}