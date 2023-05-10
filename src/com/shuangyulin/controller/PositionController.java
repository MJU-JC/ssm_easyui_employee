﻿package com.shuangyulin.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.shuangyulin.utils.ExportExcelUtil;
import com.shuangyulin.utils.UserException;
import com.shuangyulin.service.PositionService;
import com.shuangyulin.po.Position;
import com.shuangyulin.service.DepartmentService;
import com.shuangyulin.po.Department;


//Position管理控制层
@Controller
@RequestMapping("/Position")
public class PositionController extends BaseController {

    /*业务层对象*/
    @Resource PositionService positionService;

    @Resource DepartmentService departmentService;
	@InitBinder("departmentObj")
	public void initBinderdepartmentObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("departmentObj.");
	}
	@InitBinder("position")
	public void initBinderPosition(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("position.");
	}
	/*跳转到添加Position视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Position());
		/*查询所有的Department信息*/
		List<Department> departmentList = departmentService.queryAllDepartment();
		request.setAttribute("departmentList", departmentList);
		return "Position_add";
	}

	/*客户端ajax方式提交添加职位信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Position position, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        positionService.addPosition(position);
        message = "职位添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询职位信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("departmentObj") Department departmentObj,String positionName,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (positionName == null) positionName = "";
		if(rows != 0)positionService.setRows(rows);
		List<Position> positionList = positionService.queryPosition(departmentObj, positionName, page);
	    /*计算总的页数和总的记录数*/
	    positionService.queryTotalPageAndRecordNumber(departmentObj, positionName);
	    /*获取到总的页码数目*/
	    int totalPage = positionService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = positionService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Position position:positionList) {
			JSONObject jsonPosition = position.getJsonObject();
			jsonArray.put(jsonPosition);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询职位信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Position> positionList = positionService.queryAllPosition();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Position position:positionList) {
			JSONObject jsonPosition = new JSONObject();
			jsonPosition.accumulate("positionId", position.getPositionId());
			jsonPosition.accumulate("positionName", position.getPositionName());
			jsonArray.put(jsonPosition);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询职位信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("departmentObj") Department departmentObj,String positionName,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (positionName == null) positionName = "";
		List<Position> positionList = positionService.queryPosition(departmentObj, positionName, currentPage);
	    /*计算总的页数和总的记录数*/
	    positionService.queryTotalPageAndRecordNumber(departmentObj, positionName);
	    /*获取到总的页码数目*/
	    int totalPage = positionService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = positionService.getRecordNumber();
	    request.setAttribute("positionList",  positionList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("departmentObj", departmentObj);
	    request.setAttribute("positionName", positionName);
	    List<Department> departmentList = departmentService.queryAllDepartment();
	    request.setAttribute("departmentList", departmentList);
		return "Position/position_frontquery_result"; 
	}

     /*前台查询Position信息*/
	@RequestMapping(value="/{positionId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer positionId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键positionId获取Position对象*/
        Position position = positionService.getPosition(positionId);

        List<Department> departmentList = departmentService.queryAllDepartment();
        request.setAttribute("departmentList", departmentList);
        request.setAttribute("position",  position);
        return "Position/position_frontshow";
	}

	/*ajax方式显示职位修改jsp视图页*/
	@RequestMapping(value="/{positionId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer positionId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键positionId获取Position对象*/
        Position position = positionService.getPosition(positionId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonPosition = position.getJsonObject();
		out.println(jsonPosition.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新职位信息*/
	@RequestMapping(value = "/{positionId}/update", method = RequestMethod.POST)
	public void update(@Validated Position position, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			positionService.updatePosition(position);
			message = "职位更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "职位更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除职位信息*/
	@RequestMapping(value="/{positionId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer positionId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  positionService.deletePosition(positionId);
	            request.setAttribute("message", "职位删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "职位删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条职位记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String positionIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = positionService.deletePositions(positionIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出职位信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("departmentObj") Department departmentObj,String positionName, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(positionName == null) positionName = "";
        List<Position> positionList = positionService.queryPosition(departmentObj,positionName);
        ExportExcelUtil ex = new ExportExcelUtil();
        String title = "Position信息记录"; 
        String[] headers = { "职位id","所属部门","职位名称","基本工资","销售提成"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<positionList.size();i++) {
        	Position position = positionList.get(i); 
        	dataset.add(new String[]{position.getPositionId() + "",position.getDepartmentObj().getDepartmentName(),position.getPositionName(),position.getBaseSalary() + "",position.getSellPercent()});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"Position.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}
