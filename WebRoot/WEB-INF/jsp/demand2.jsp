<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<style>
*{ margin:0px; border:0px solid red; padding:0px;}

#box{ width:750px; height:1334px; background:url(<%=basePath%>images/mobile/images/images7/1.png) no-repeat center top; margin-left:auto; margin-right:auto; overflow:hidden; }
#top{ width:750px; height:60px; background-color:#282828; -moz-box-shadow: 3px 3px 4px #000;
    -webkit-box-shadow: 3px 3px 10px #000;
    box-shadow: 3px 3px 4px #000; z-index:1; color:#FFF; font-size:24px; text-align:center; line-height:60px;}
#top img{ float:left; }
#if1,#if2{ margin-top:1px;}
</style>
</head>

<body>
<div id="box">
<div id="top"><a href="${pageContext.request.contextPath}/sys/order_list.action?app_type=mobile"><img src="<%=basePath%>images/mobile/images/images/gd2_03.png" width="88" height="60" /></a>查看详情</div>
<iframe frameborder="0" id="if1" name="if1" src="${pageContext.request.contextPath}/sys/left1_mobile.action?order_id=${order_id}" width="170px" height="1268px" scrolling="no"></iframe>
<iframe frameborder="0" id="if2" name="if2" src="${pageContext.request.contextPath}/sys/right1_mobile.action?order_id=${order_id}" width="570px" height="1268px" scrolling="no"></iframe>

</div>

</body>
</html>