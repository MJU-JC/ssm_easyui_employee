# ssm_easyui_employee
# JSP基于SSM和EasyUI公司员工管理系统

程序开发软件：MyEclipse8.5以上或Eclipse 数据库：mysql 

后台采用技术： SSM框架(SpringMVC + Spring + Mybatis)

前台采用技术： div + css + easyui框架

此系统源码全部免费发布了 需要的同学可以拿去学习学习

技术要点：
1 此系统采用了目前最流行的ssm框架,其中的spingMVC框架相对于struts2框架更灵活，更安全。

2 本项目springMVC框架采用了注解映射器，使用了RESTful风格的url对系统发起http请求,开发更灵活。

3 同时使用了了hibernate提供的校验框架，对客户端数据进行校验！

4 Mybati数据库DAO层采用的是Mapper代理开发方法，输入映射采用的是POJO包装类型实现,输出映射采用了resultMap类型，实现了数据库多对一映射。

5 spring容器内部使用拦截器，以Spring AOP的方式实现事务控制管理。


系统实体对象： 

部门: 部门编号,部门名称

职位: 职位id,所属部门,职位名称,基本工资,销售提成

员工: 员工编号,职位,姓名,性别,员工照片,出生日期,学历,员工介绍
