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
<script type="text/javascript" src="${pageContext.request.contextPath}/js/ajaxfileupload.js"></script>
<script type="text/javascript">
	//下载全部
	function downloadAll(){
		var order_id=$("#order_id").attr("value");
		window.location.href="${pageContext.request.contextPath}/sys/downloadAll.action?order_id="+order_id;
	}
	//上传附件
	function saveAnalyse(){
		//判断文件域是否选择
		var f_name=$("#file_name").attr("value");
		if(f_name=='' || f_name==undefined){
			alert("文件还未选择");
			return false;
		}
		var order_id=$("#order_id").val();
		var analyse_opinion= $("#analyse_opinion").val();
		//URL传参 是GET方式  不是POST方式    过滤器只针对POST。 GET传中文需要特殊处理
		var url="<%=basePath%>analyse/saveAnalyse.action?order_id="+order_id+"&analyse_opinion="+analyse_opinion;
		jQuery.ajaxFileUpload({
			url : url,
			secureuri:false,
	        fileElementId:'file_name',                        //文件选择框的id属性
	        dataType: 'json',             
			success:function(data,status) {
				if('success'==data.flag){
					alert("保存成功");
					window.location.href="${pageContext.request.contextPath}/sys/order_list.action";
				}else{
					if('fail'==data){
						alert("保存失败");
					}
					
				}
			}
		});
	}
</script>
</head>

<body>
<jsp:include page="top_tip.jsp"/>
<!--main 开始-->
<div class="main1">
	<div class="gr_left">
		<iframe src="${pageContext.request.contextPath}/sys/left.action" scrolling="no" allowtransparency="true" width="151" height="600" frameborder="0"></iframe>
	</div>
	<div class="gr_right  p10">
		<div class="home_tit left red1 fontB"> <div class="btn_gr2 mt8" style="float:right"><a class="hand" href="grgzt.html">返回个人工作台</a></div><span class="ml20">需求分析</span> </div>   
		<p class="w100 left line30 orange3 font12">温馨提示：标识*为必填项，填写完信息后请提交。上传的文件类型只能为doc,docx,xls,xlsx,ppt,pptx,txt,jpg,bmp,gif,png,rar,zip格式，单个文件大小为5M以内
</p>
	<form name="myForm" id="myForm" action="">
	<input type="hidden" id="order_id" name="order_id" value="${order.id }"/>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="grgz_tab left">
		<tr>
			<th scope="row"> <span class="orange3">*</span> 需求分析文档：</th>
			<td ><input id="file_name" type="file" name="file_name" class="input70"/></td>
			</tr>
		<tr>
			<th scope="row">需求分析意见/说明</th>
			<td ><textarea name="analyse_opinion" id="analyse_opinion" cols="" rows="" style="height:80px; line-height:20px;" class="input90"></textarea></td>
			</tr>
	</table>
	</form>
	<div class="w100 left">
	<div class="btn_gr2 mt8" style=" width:100px;  margin:7px auto 0; float:none"><a class="hand" onclick="saveAnalyse()">提交需求分析</a></div>
	</div>
	<div class="box1_tit w100 left varcx_tab mt25">
				<ul id="tabnav">
					<li class="on" onclick="nTabs(this,'0','on','');">需求基本信息</li>
				</ul>
			</div>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="grgz_tab left" style="border-top:0px;">
		<tr>
			<th scope="row">需求名称：</th>
			<td colspan="3">${order.order_name }</td>
			</tr>
		<tr>
			<th scope="row">系统编号：</th>
			<td colspan="3">${order.sys_no }</td>
			</tr>
		<tr>
			<th scope="row">需求大小：</th>
			<td colspan="3">
				<p> 
				<c:if test="${order.order_scope=='1' }">
				   大 （90人天以上）
				</c:if>
				 <c:if test="${order.order_scope=='2' }">
				   中（30-90人天以内，包括90人天）
				</c:if>
				<c:if test="${order.order_scope=='3' }">
				   小（30人天以下，包括30人天）
				</c:if>
				
				</p>
			</td>
			</tr>
		<tr>
			<th scope="row"> OA工单号：</th>
			<td>${order.oa_no } </td>
			<th scope="row"> 归属系统：</th>
			<td>${order.app_sys_id }</td>
		</tr>
		<tr>
			<th scope="row"> 需求部门/单位：</th>
			<td>${order.order_dept }</td>
			<th scope="row"> 需求提出人：</th>
			<td>${order.order_apply_man }</td>
		</tr>
		<tr>
			<th scope="row"> 开发负责人：</th>
			<td>${order.develop_man }</td>
			<th scope="row"> 执行厂商：</th>
			<td>${order.execute_company_name }</td>
		</tr>
		<tr>
			<th scope="row"> 需求描述：</th>
			<td colspan="3">
			${order.order_detail } 
			</td>
			</tr>
		<tr>
			<th scope="row">相关附件：<br /><input name="" type="button" value="下载全部"  class="btn_gr1 ml10" onclick="downloadAll()"/></th>
			<td colspan="3">
			<c:forEach items="${orderAttachList }" var="attach">
			<p>${attach.attach_name }   <a href="${pageContext.request.contextPath}/sys/downloadTest.action?url=${attach.url}&attach_name=${attach.attach_name}&server_name=${attach.server_name}">下载</a></p>
			</c:forEach>
			

			</td>
			</tr>
	</table>

</div>
<!--main 结束-->

<!--提示弹出层 开始-->
	<div id="cover1"></div>		
	<!--保存需求 弹出框 开始-->
	<div class="pop_410" id="pop_sure">
		<div class="pop_410_t pop_box_t"><span class=" mr15 pop_close" onclick="hide('cover1','pop_sure');"></span>  <strong class="fl ml15">提示</strong> </div>
		<div class="pop_410_m text_c">
			<div style="padding-top:30px; padding-bottom:30px;">保存成功！是否马上提交需求确认？</div>
			<div class="mt20 mb10" style="margin-left:120px;">
				<span class="btn_gr2 mr20" onclick="hide('cover1','pop_sure');"><a class="hand"  onclick="show('cover1','pop_msxf');">提交需求确认</a></span>
				<span class="btn_gr2" onclick="hide('cover1','pop_sure');"><a href="#">暂不提交</a></span>
			</div>
		</div>
	</div>
	<!--保存需求 弹出框 结束-->
	
	<!--下发成功 弹出框 开始-->
	<div class="pop_410" id="pop_msxf">
		<div class="pop_410_t pop_box_t"><span class=" mr15 pop_close" onclick="hide('cover1','pop_msxf');"></span>  <strong class="fl ml15">提示</strong> </div>
		<div class="pop_410_m text_c">
			<div style="padding-top:30px; padding-bottom:30px;">提交成功！</div>
			<div class="mt20 mb10" style="margin-left:170px;">
				<span class="btn_gr2 mr20" onclick="hide('cover1','pop_msxf');"><a href="grgzt.html">确认</a></span>
			</div>
		</div>
	</div>
	<!--下发成功 弹出框 结束-->
	
<!--提示弹出层 结束-->
</body>
</html>

