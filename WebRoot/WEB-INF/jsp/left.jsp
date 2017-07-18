<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.0.min.js"></script>
</head>

<body>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/Tstyle.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/public.css"/>
<div class="gr_left">
		<div class="box1_tit text_c" style="padding:0;">个人工作台</div>
		<ul>
			<li class="on">
			<a  onclick="javascript:parent.location.href='${pageContext.request.contextPath}/sys/order_list.action';" class="hand">我的待办<span class="orange3">（24）</span></a></li>
			<li><a onclick="javascript:parent.location.href='${pageContext.request.contextPath}/sys/order_list.action';" class="hand" >我的需求<span class="orange3">（139）</span></a></li>
			<li><a onclick="javascript:parent.location.href='${pageContext.request.contextPath}/sys/order_list.action';" class="hand" >我的已办<span class="orange3">（58）</span></a></li>
			<li><a onclick="javascript:parent.location.href='${pageContext.request.contextPath}/sys/to_add_order.action';"  class="hand">新建需求</a></li>
		</ul>
	</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/public.js"></script>
</body>
</html>

