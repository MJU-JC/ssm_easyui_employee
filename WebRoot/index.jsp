<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%> <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<title>双鱼林SSM_EasyUI公司员工管理系统-首页</title>
<link href="<%=basePath %>css/index.css" rel="stylesheet" type="text/css" />
 </head>
<body>
<div id="container">
	<div id="banner"><img src="<%=basePath %>images/logo.gif" /></div>
	<div id="globallink">
		<ul>
			<li><a href="<%=basePath %>index.jsp">首页</a></li>
			<li><a href="<%=basePath %>Department/frontlist" target="OfficeMain">部门</a></li> 
			<li><a href="<%=basePath %>Position/frontlist" target="OfficeMain">职位</a></li> 
			<li><a href="<%=basePath %>Employee/frontlist" target="OfficeMain">员工</a></li> 
		</ul>
		<br />
	</div> 

	<div id="loginBar">
	  <%
	  	String user_name = (String)session.getAttribute("user_name");
	    if(user_name==null){
	  %>
	  <form action="<%=basePath %>frontLogin" style="height:25px;margin:0px 0px 2px 0px;" method="post">
		用户名：<input type=text name="userName" size="12"/>&nbsp;&nbsp;
		密码：<input type=password name="password" size="12"/>&nbsp;&nbsp;
		<input type=submit value="登录" />
	  </form>
	  <%} else { %>
	    <ul>
	    	<li><a href="<%=basePath %>UserInfo/<%=user_name %>/update" target="OfficeMain">【修改个人信息】</a></li>
	    	<li><a href="<%=basePath %>logout">【退出登陆】</a></li>
	    </ul>
	 <% } %>
	</div> 

	<div id="main">
	 <iframe id="frame1" src="<%=basePath %>desk.jsp" name="OfficeMain" width="100%" height="100%" scrolling="yes" marginwidth=0 marginheight=0 frameborder=0 vspace=0 hspace=0 >
	 </iframe>
	</div>
	<div id="footer">
		<p>&nbsp;&nbsp;更多设计到：<a href="http://www.shuangyulin.com" target="_blank">双鱼林设计网</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="<%=basePath%>login.jsp"><font color=red>后台登陆</font></a></p>
	</div>
</div>
</body>
</html>
