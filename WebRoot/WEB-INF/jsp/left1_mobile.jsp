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
#left{ width:170px; height:1334px; }
hr{ width:110px; margin:0px auto; opacity:0.7;}
ul{ width:170px; height:1334px; list-style:none; color:#FFF; text-align:center;}
ul li{ width:170px; height:60px;  padding-top:40px; border-bottom:1px solid #999;background-color:#282828;}
a{  text-decoration:none; color:#FFF;}
ul li:hover{ background-color:transparent; background:url(<%=basePath%>images/mobile/images/images7/images/2.png) no-repeat left top;}
#l2{ height:100%; background-color:#282828;}
#l1{ height:70px; padding-top:30px;}
span{ color:#09F;}

</style>
<script type="text/javascript">
//下载全部
	function downloadAll(){
		var order_id=$("#order_id").attr("value");
		window.location.href="${pageContext.request.contextPath}/sys/downloadAll.action?order_id="+order_id;
	}
</script>
</head>

<body>
<div id="left">

<ul>
<a href="${pageContext.request.contextPath}/sys/right1_mobile.action?order_id=${order.id}" target="if2"><li>需求基本信息</li></a>
<a  href="right2.html" target="if2"><li id="l1">需求分析<br />需求确认</li></a>
<a href="right3.html" target="if2"><li id="l1">需求验收<br />
上线切割 </li></a>
<a href="right4.html" target="if2"><li>后评估</li></a>
<a href="${pageContext.request.contextPath}/sys/right5_mobile.action?order_id=${order.id}" target="if2"><li>工单详情</li></a>
<div id="l2"></div>

</ul>
</div>
</body>
</html>
