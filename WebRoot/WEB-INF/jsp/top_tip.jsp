<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<div class="home_tit">
	<ul>
		<li class="on"><a href="${pageContext.request.contextPath}/sys/order_list.action">个人工作台</a></li>
		<li><a href="ywjxm.html">已归档需求</a></li>
		<li><a href="tjfx.html">统计分析</a></li>
	</ul>
	<div class="btn_gr2 mt8" style="float:right"><a class="hand" href="${pageContext.request.contextPath}/user/logout.action">退出</a><a class="hand" href="${pageContext.request.contextPath}/sys/main.action">返回首页</a></div>
</div>
