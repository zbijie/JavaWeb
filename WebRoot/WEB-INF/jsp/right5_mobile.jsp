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
body{  }
#right{ width:570px; height:1268px; }
#top{ width:292px; height:52px; color:#FFF; font-size:2em; margin-top:36px; margin-left:40px;}
#top img{ margin-bottom:15px;}
button {
  margin: 30px 20px;
  padding: 15px 20px;
  border-radius: 10px;
  border: 2px solid;
  width:120px;
 
  font: 16px 'Microsoft yahei', sans-serif;
  text-transform: uppercase;
  background: none;
  outline: none;
  cursor: pointer;
  -webkit-transition: all .5s;
  transition: all .5s;
}

.btn-2 {
  color: #fff;
  border-color: #fff;
  background: -webkit-linear-gradient(left, #e4f68f, #e4f68f) no-repeat;
  background: linear-gradient(to right, #62c1f8, #62c1f8) no-repeat;
  background-size: 100% 0%;
  position:relative;
  left:20px;
  top:30px;
}
.btn-2:hover {
  background-size: 100% 100%;
  color: #27323A;
}
#tab{ margin-left:40px; color:#FFF; font-family:"汉仪中楷简"; font-size:24px; }
#tab span{ color:#d4cccc;}

</style>
<script type="text/javascript">
//下放厂商
	function sendCompany(){
	var order_id=${order.id};
	alert(ordder_id);
	var status="1";//下放厂商-1
	var jsonStr="{\"order_id\":\""+order_id+"\",\"status\":\""+status+"\"}";
	$.ajax({
			type:"POST",
			contentType: "application/json; charset=utf-8",
			url:"<%=basePath %>sys/update_order_ajax.action",
			async:false,
			data: jsonStr,
			dataType:"json",
			success: function(data){
				if(data.message=="success"){
					alert("下发厂商成功");
				}
				else{
					alert("保存失败");
				}
			}
		});
}
	
</script>

</head>

<body>
<div id="right"><a href="${pageContext.request.contextPath}/sys/to_edit_mobile.action?order_id=${order.id}" target="_blank">
<button  class="btn-2">编辑需求</button></a>
<button id="btn1" name="btn1" style="margin-left:30px;" class="btn-2" onclick="sendCompany()">下发厂商</button>
<a href="${pageContext.request.contextPath}/sys/delete_order.action?order_id=${order.id}&app_type=mobile" target="_blank">
<button id="btn2" name="btn2" style="margin-left:30px;" class="btn-2">取消需求</button></a>
<div id="top">
  <img src="<%=basePath%>images/mobile/images/images7/images/3_03.png" width="50" height="51" align="center" />工单详情</div>

<table id="tab" width="500" height="466" border="0">
  <tr>
    <td width="250" height="98"><span>需求编号</span><br /><br />
     ${order.sys_no }</td>
    <td width="250" height="98"><span>需求名称</span><br /><br />
     ${order.order_name }</td>
  </tr>
  <tr>
    <td width="250" height="98"><span>OA工单号</span><br /><br />
     ${order.oa_no }</td>
    <td width="250" height="98"><span>执行厂商</span><br /><br />
   ${order.execute_company_name }</td>
  </tr>
   <tr>
    <td width="250" height="98"><span>提出人</span><br /><br />
 ${order.order_apply_man }</td>
    <td width="250" height="98"><span>提出单位</span><br /><br />
     ${order.order_dept }</td>
  </tr>
   <tr>
    <td width="250" height="98"><span>项目经理</span><br /><br />
   ${order.develop_man }</td>
    <td width="250" height="98"><span> 需求描述</span><br /><br />
    ${order.order_detail }
   </td>
  </tr>
  </table>


</div>
</body>
</html>
