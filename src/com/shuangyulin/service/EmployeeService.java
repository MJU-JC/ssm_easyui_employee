﻿package com.shuangyulin.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.shuangyulin.po.Position;
import com.shuangyulin.po.Employee;

import com.shuangyulin.mapper.EmployeeMapper;
@Service
public class EmployeeService {

	@Resource EmployeeMapper employeeMapper;
    /*每页显示记录数目*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*保存查询后总的页数*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*保存查询到的总记录数*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*添加员工记录*/
    public void addEmployee(Employee employee) throws Exception {
    	employeeMapper.addEmployee(employee);
    }

    /*按照查询条件分页查询员工记录*/
    public ArrayList<Employee> queryEmployee(String employeeNo,Position positionObj,String name,String birthday,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!employeeNo.equals("")) where = where + " and t_employee.employeeNo like '%" + employeeNo + "%'";
    	if(null != positionObj && positionObj.getPositionId()!= null && positionObj.getPositionId()!= 0)  where += " and t_employee.positionObj=" + positionObj.getPositionId();
    	if(!name.equals("")) where = where + " and t_employee.name like '%" + name + "%'";
    	if(!birthday.equals("")) where = where + " and t_employee.birthday like '%" + birthday + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return employeeMapper.queryEmployee(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Employee> queryEmployee(String employeeNo,Position positionObj,String name,String birthday) throws Exception  { 
     	String where = "where 1=1";
    	if(!employeeNo.equals("")) where = where + " and t_employee.employeeNo like '%" + employeeNo + "%'";
    	if(null != positionObj && positionObj.getPositionId()!= null && positionObj.getPositionId()!= 0)  where += " and t_employee.positionObj=" + positionObj.getPositionId();
    	if(!name.equals("")) where = where + " and t_employee.name like '%" + name + "%'";
    	if(!birthday.equals("")) where = where + " and t_employee.birthday like '%" + birthday + "%'";
    	return employeeMapper.queryEmployeeList(where);
    }

    /*查询所有员工记录*/
    public ArrayList<Employee> queryAllEmployee()  throws Exception {
        return employeeMapper.queryEmployeeList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String employeeNo,Position positionObj,String name,String birthday) throws Exception {
     	String where = "where 1=1";
    	if(!employeeNo.equals("")) where = where + " and t_employee.employeeNo like '%" + employeeNo + "%'";
    	if(null != positionObj && positionObj.getPositionId()!= null && positionObj.getPositionId()!= 0)  where += " and t_employee.positionObj=" + positionObj.getPositionId();
    	if(!name.equals("")) where = where + " and t_employee.name like '%" + name + "%'";
    	if(!birthday.equals("")) where = where + " and t_employee.birthday like '%" + birthday + "%'";
        recordNumber = employeeMapper.queryEmployeeCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取员工记录*/
    public Employee getEmployee(String employeeNo) throws Exception  {
        Employee employee = employeeMapper.getEmployee(employeeNo);
        return employee;
    }

    /*更新员工记录*/
    public void updateEmployee(Employee employee) throws Exception {
        employeeMapper.updateEmployee(employee);
    }

    /*删除一条员工记录*/
    public void deleteEmployee (String employeeNo) throws Exception {
        employeeMapper.deleteEmployee(employeeNo);
    }

    /*删除多条员工信息*/
    public int deleteEmployees (String employeeNos) throws Exception {
    	String _employeeNos[] = employeeNos.split(",");
    	for(String _employeeNo: _employeeNos) {
    		employeeMapper.deleteEmployee(_employeeNo);
    	}
    	return _employeeNos.length;
    }
}
