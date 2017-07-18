<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
body{ }
#right{ width:570px; height:1268px; }
#top{ width:292px; height:52px; color:#FFF; font-size:2em; margin-top:36px; margin-left:40px;}
#tab{ margin-left:40px; color:#FFF; font-family:"汉仪中楷简"; font-size:24px;}
#tab span{ color:#d4cccc;}
#top img{ margin-bottom:15px;}
input{ width:150px; height:30px; background-color:#FFF; color:#666; margin-top:10px;}
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
<div id="right">
<div id="top">
  <img src="<%=basePath%>images/mobile/images/images7/images/3_03.png" width="50" height="51" align="center" />需求基本信息 </div>
<table id="tab" width="510" height="294px" border="0" >
  <tr>
    <td height="147" colspan="3"><span>需求名称</span><br /><br />${order.order_name} </td>
    </tr>
  <tr>
    <td height="147" colspan="2"><span>系统编号</span><br /><br />${order.sys_no}</td>
    <td width="255" height="147"><span>需求大小</span><br /><br />
    	<c:if test="${order.order_scope=='1' }"> 大  </c:if>
		<c:if test="${order.order_scope=='2' }"> 中  </c:if>
		<c:if test="${order.order_scope=='3' }"> 小  </c:if></td>
    </tr>
    </table>
  <table id="tab" width="510" height="592px" border="0">
  <tr>
    <td width="170" height="147"><span>OA工单号</span><br /><br />${order.oa_no }</td>
    <td width="170" height="147"><span>归属系统</span><br /><br />
    	<c:if test="${order.app_sys_id =='1'}">OA系统</c:if>
		<c:if test="${order.app_sys_id =='2'}">ERP系统</c:if>
		<c:if test="${order.app_sys_id =='3'}"> 监控系统</c:if></td>
    <td width="170" height="147"><span>需求部门/单位</span><br /><br />${order.order_dept }</td>
  </tr>
  <tr>
   <td width="170" height="147"><span>需求提出人</span><br /><br />${order.order_apply_man } </td>
    <td width="170" height="147"><span>开发负责人</span><br /><br />${order.develop_man }</td>
    <td width="170" height="147"><span>执行厂商</span><br /><br />${order.execute_company_name }</td>
  </tr>
  <tr>
    <td height="147" colspan="3"><span>需求描述</span><br /><br />${order.order_detail }  </td>
    </tr>
  <tr>
    <td height="147" colspan="3" style="border:0px;"><span>相关附件：</span><br /><br />
    <input name="" type="button" value="下载全部"  class="btn_gr1 ml10" onclick="downloadAll()"/>
			<c:forEach items="${orderAttachList }" var="attach">
			<p>${attach.attach_name }   
			<a href="${pageContext.request.contextPath}/sys/downloadTest.action?url=${attach.url}&attach_name=${attach.attach_name}&server_name=${attach.server_name}">下载</a></p>
			</c:forEach>

</td>
    </tr>
</table>

</div>
</body>
</html>