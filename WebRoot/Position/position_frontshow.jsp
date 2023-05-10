<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.shuangyulin.po.Position" %>
<%@ page import="com.shuangyulin.po.Department" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的departmentObj信息
    List<Department> departmentList = (List<Department>)request.getAttribute("departmentList");
    Position position = (Position)request.getAttribute("position");

%>
<!DOCTYPE html>
<html>
<head><TITLE>查看职位</TITLE>
<STYLE type=text/css>
body{margin:0px; font-size:14px; background-image:url(<%=basePath%>images/bg.jpg); background-position:bottom; background-repeat:repeat;}
.STYLE1 {color: #ECE9D8}
.label {font-style.:italic; }
.errorLabel {font-style.:italic;  color:red; }
.errorMessage {font-weight:bold; color:red; }
</STYLE>
 <script src="<%=basePath %>calendar.js"></script>
</head>
<body>
<s:fielderror cssStyle="color:red" />
<TABLE align="center" height="100%" cellSpacing=0 cellPadding="10px" width="80%" border=0>
  <TBODY>
  <TR>
    <TD align="left" vAlign=top ><s:form action="" method="post" onsubmit="return checkForm();" enctype="multipart/form-data" name="form1">
<table width='100%' cellspacing='1' cellpadding='3'  class="tablewidth">
  <tr>
    <td width=30%>职位id:</td>
    <td width=70%><%=position.getPositionId() %></td>
  </tr>

  <tr>
    <td width=30%>所属部门:</td>
    <td width=70%>
      <%
        for(Department department:departmentList) {
          String selected = "";
          if(department.getDepartmentNo().equals(position.getDepartmentObj().getDepartmentNo())) {
      %>
      		<%=department.getDepartmentName() %>
      <%
      		break;
          }
        }
      %>
    </td>
  </tr>
  <tr>
    <td width=30%>职位名称:</td>
    <td width=70%><%=position.getPositionName() %></td>
  </tr>

  <tr>
    <td width=30%>基本工资:</td>
    <td width=70%><%=position.getBaseSalary() %></td>
  </tr>

  <tr>
    <td width=30%>销售提成:</td>
    <td width=70%><%=position.getSellPercent() %></td>
  </tr>

  <tr>
      <td colspan="4" align="center">
        <input type="button" value="返回" onclick="history.back();"/>
      </td>
    </tr>

</table>
</s:form>
   </TD></TR>
  </TBODY>
</TABLE>
</body>
</html>
