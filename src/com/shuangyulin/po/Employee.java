package com.shuangyulin.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Employee {
    /*员工编号*/
    @NotEmpty(message="员工编号不能为空")
    private String employeeNo;
    public String getEmployeeNo(){
        return employeeNo;
    }
    public void setEmployeeNo(String employeeNo){
        this.employeeNo = employeeNo;
    }

    /*职位*/
    private Position positionObj;
    public Position getPositionObj() {
        return positionObj;
    }
    public void setPositionObj(Position positionObj) {
        this.positionObj = positionObj;
    }

    /*姓名*/
    @NotEmpty(message="姓名不能为空")
    private String name;
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    /*性别*/
    @NotEmpty(message="性别不能为空")
    private String sex;
    public String getSex() {
        return sex;
    }
    public void setSex(String sex) {
        this.sex = sex;
    }

    /*员工照片*/
    private String employeePhoto;
    public String getEmployeePhoto() {
        return employeePhoto;
    }
    public void setEmployeePhoto(String employeePhoto) {
        this.employeePhoto = employeePhoto;
    }

    /*出生日期*/
    @NotEmpty(message="出生日期不能为空")
    private String birthday;
    public String getBirthday() {
        return birthday;
    }
    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    /*学历*/
    @NotEmpty(message="学历不能为空")
    private String schoolRecord;
    public String getSchoolRecord() {
        return schoolRecord;
    }
    public void setSchoolRecord(String schoolRecord) {
        this.schoolRecord = schoolRecord;
    }

    /*员工介绍*/
    private String employeeDesc;
    public String getEmployeeDesc() {
        return employeeDesc;
    }
    public void setEmployeeDesc(String employeeDesc) {
        this.employeeDesc = employeeDesc;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonEmployee=new JSONObject(); 
		jsonEmployee.accumulate("employeeNo", this.getEmployeeNo());
		jsonEmployee.accumulate("positionObj", this.getPositionObj().getPositionName());
		jsonEmployee.accumulate("positionObjPri", this.getPositionObj().getPositionId());
		jsonEmployee.accumulate("name", this.getName());
		jsonEmployee.accumulate("sex", this.getSex());
		jsonEmployee.accumulate("employeePhoto", this.getEmployeePhoto());
		jsonEmployee.accumulate("birthday", this.getBirthday().length()>19?this.getBirthday().substring(0,19):this.getBirthday());
		jsonEmployee.accumulate("schoolRecord", this.getSchoolRecord());
		jsonEmployee.accumulate("employeeDesc", this.getEmployeeDesc());
		return jsonEmployee;
    }}