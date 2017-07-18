<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<style>
*{ margin:0px; border:0px solid red; padding:0px;}
#box{ width:750px; height:1334px; background:url(<%=basePath%>images/mobile/images/images3/1.png) no-repeat center top; margin-left:auto; margin-right:auto; }
#top{ width:375px; height:200px; text-align:center; margin:0px auto; padding-top:169px;}
#img1{ float:left; margin-top:55px;}
#img2{ float:left;width:199px; height:198px;}
#top2{ width:720px; height:127px; margin:164px auto; clear:both; background:url(<%=basePath%>images/mobile/images/images3/images/6_03.png) no-repeat center top;}
#txt1{ width:215px; height:87px; font-size:20px; text-align:center; padding-top:35px; float:left; padding-left:20px;}
#txt1 a{ text-decoration:none; color:#FFF;}
#txt1 a:hover{ color:#6CF; text-decoration:underline; }
#main{ width:625px; height:484px; margin:0px auto;}
#main1{ width:310px; height:212px; float:left;  text-align:center;  }
#main1 a{ display:block; width:310px; height:185px;color:#FFF; text-decoration:none;padding-top:30px;}
#main1 a:hover{ background-color:#39F; }
</style>
</head>

<body>
<div id="box">
<div id="top">
<div id="img1">
 <a href="#"> <img  src="<%=basePath%>images/mobile/images/images3/2.png" width="88" height="88" />
 </a></div>
 <div id="img2">
 <a href="#"> <img  src="<%=basePath%>images/mobile/images/images3/4_03.png" width="199" height="206" />
 </a></div>
 <div id="img1">
 <a href="#"> <img  src="<%=basePath%>images/mobile/images/images3/3.png" width="88" height="88" />
 </a></div> 
 </div>
<div id="top2">
<div id="txt1"><a href="${pageContext.request.contextPath}/sys/order_list.action?app_type=mobile">个人工作台<br />Personal work
</a> </div>
<div id="txt1"><a href="file.html">已归档需求<br />Already archived</a> </div>
<div id="txt1"><a href="statistics1.html">统计分析<br />Statistical Analysis</a> </div>

</div>
<div id="main">
<div id="main1"><a href="${pageContext.request.contextPath}/sys/order_list.action?app_type=mobile"><img src="<%=basePath%>images/mobile/images/images3/images/7_03.png" width="130" height="130" /><br />我的代办<br />Agency</a></div>
<div id="main1"><a href="business2.html"><img src="<%=basePath%>images/mobile/images/images3/images/7_06.png" width="126" height="126" /><br />我的已办<br />Agency</a></div>
<div id="main1"><a href="business3.html"><img src="<%=basePath%>images/mobile/images/images3/images/7_11.png" width="126" height="126" /><br />我的需求<br />Agency</a></div>
<div id="main1"><a href="business4.html"><img src="<%=basePath%>images/mobile/images/images3/images/7_13.png" width="127" height="127" /><br />预警信息<br />Agency</a></div>
</div>
</div>
</body>
</html>

