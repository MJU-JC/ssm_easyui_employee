<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.shuangyulin.po.Employee" %>
<%@ page import="com.shuangyulin.po.Position" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的positionObj信息
    List<Position> positionList = (List<Position>)request.getAttribute("positionList");
    Employee employee = (Employee)request.getAttribute("employee");

%>
<!DOCTYPE html>
<html>
<head><TITLE>查看员工</TITLE>
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
    <td width=30%>员工编号:</td>
    <td width=70%><%=employee.getEmployeeNo() %></td>
  </tr>

  <tr>
    <td width=30%>职位:</td>
    <td width=70%>
      <%
        for(Position position:positionList) {
          String selected = "";
          if(position.getPositionId() == employee.getPositionObj().getPositionId()) {
      %>
      		<%=position.getPositionName() %>
      <%
      		break;
          }
        }
      %>
    </td>
  </tr>
  <tr>
    <td width=30%>姓名:</td>
    <td width=70%><%=employee.getName() %></td>
  </tr>

  <tr>
    <td width=30%>性别:</td>
    <td width=70%><%=employee.getSex() %></td>
  </tr>

  <tr>
    <td width=30%>员工照片:</td>
    <td width=70%><img src="<%=basePath %><%=employee.getEmployeePhoto() %>" width="200px" border="0px"/></td>
  </tr>
  <tr>
    <td width=30%>出生日期:</td>
    <td width=70%><%=employee.getBirthday() %></td>
  </tr>

  <tr>
    <td width=30%>学历:</td>
    <td width=70%><%=employee.getSchoolRecord() %></td>
  </tr>

  <tr>
    <td width=30%>员工介绍:</td>
    <td width=70%><%=employee.getEmployeeDesc() %></td>
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
