package com.shuangyulin.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.shuangyulin.po.Position;


public interface PositionMapper {
	/*添加职位信息*/
	public void addPosition(Position position) throws Exception;

	/*按照查询条件分页查询职位记录*/
	public ArrayList<Position> queryPosition(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有职位记录*/
	public ArrayList<Position> queryPositionList(@Param("where") String where) throws Exception;

	/*按照查询条件的职位记录数*/
	public int queryPositionCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条职位记录*/
	public Position getPosition(int positionId) throws Exception;

	/*更新职位记录*/
	public void updatePosition(Position position) throws Exception;

	/*删除职位记录*/
	public void deletePosition(int positionId) throws Exception;

}
