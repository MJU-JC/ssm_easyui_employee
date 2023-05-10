package com.shuangyulin.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.shuangyulin.po.Department;
import com.shuangyulin.po.Position;

import com.shuangyulin.mapper.PositionMapper;
@Service
public class PositionService {

	@Resource PositionMapper positionMapper;
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

    /*添加职位记录*/
    public void addPosition(Position position) throws Exception {
    	positionMapper.addPosition(position);
    }

    /*按照查询条件分页查询职位记录*/
    public ArrayList<Position> queryPosition(Department departmentObj,String positionName,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != departmentObj &&  departmentObj.getDepartmentNo() != null  && !departmentObj.getDepartmentNo().equals(""))  where += " and t_position.departmentObj='" + departmentObj.getDepartmentNo() + "'";
    	if(!positionName.equals("")) where = where + " and t_position.positionName like '%" + positionName + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return positionMapper.queryPosition(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Position> queryPosition(Department departmentObj,String positionName) throws Exception  { 
     	String where = "where 1=1";
    	if(null != departmentObj &&  departmentObj.getDepartmentNo() != null && !departmentObj.getDepartmentNo().equals(""))  where += " and t_position.departmentObj='" + departmentObj.getDepartmentNo() + "'";
    	if(!positionName.equals("")) where = where + " and t_position.positionName like '%" + positionName + "%'";
    	return positionMapper.queryPositionList(where);
    }

    /*查询所有职位记录*/
    public ArrayList<Position> queryAllPosition()  throws Exception {
        return positionMapper.queryPositionList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(Department departmentObj,String positionName) throws Exception {
     	String where = "where 1=1";
    	if(null != departmentObj &&  departmentObj.getDepartmentNo() != null && !departmentObj.getDepartmentNo().equals(""))  where += " and t_position.departmentObj='" + departmentObj.getDepartmentNo() + "'";
    	if(!positionName.equals("")) where = where + " and t_position.positionName like '%" + positionName + "%'";
        recordNumber = positionMapper.queryPositionCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取职位记录*/
    public Position getPosition(int positionId) throws Exception  {
        Position position = positionMapper.getPosition(positionId);
        return position;
    }

    /*更新职位记录*/
    public void updatePosition(Position position) throws Exception {
        positionMapper.updatePosition(position);
    }

    /*删除一条职位记录*/
    public void deletePosition (int positionId) throws Exception {
        positionMapper.deletePosition(positionId);
    }

    /*删除多条职位信息*/
    public int deletePositions (String positionIds) throws Exception {
    	String _positionIds[] = positionIds.split(",");
    	for(String _positionId: _positionIds) {
    		positionMapper.deletePosition(Integer.parseInt(_positionId));
    	}
    	return _positionIds.length;
    }
}
