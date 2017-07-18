<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>管理信息中心IT管理平台</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/Tstyle.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/public.css"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.4.4.min.js"></script>
</head>

<body>
<jsp:include page="top_tip.jsp"/>
<!--main 开始-->
<div class="main1">
	<div class="gr_left">
		<iframe src="${pageContext.request.contextPath}/sys/left.action" scrolling="no" allowtransparency="true" width="151" height="600" frameborder="0"></iframe>
	</div>
	<div class="gr_right p10">
		<div class="home_tit left red1 fontB"> <div class="btn_gr2 mt8" style="float:right"><a class="hand" href="grgzt.html">返回个人工作台</a></div><span class="ml20">查看审核意见</span> </div>   
		<c:forEach items="${audit_list}"  var="au">
		<p class="w100 line30 left  font18 fontB">审批时间：${au.audit_time_str}</p>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="grgz_tab left">
		<tr>
			<th scope="row">是否审核通过：</th>
			<td>
			<c:if test="${au.audit_status=='1' }">
				通过
			</c:if>
			<c:if test="${au.audit_status=='0' }">
				不通过
			</c:if>
			</td>
			</tr>
		<tr>
			<th scope="row">审核意见：</th>
			<td>${au.audit_opinion}</td>
			</tr>
	</table>
	</c:forEach>

</div>
<!--main 结束-->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/public.js"></script>

</body>
</html>

