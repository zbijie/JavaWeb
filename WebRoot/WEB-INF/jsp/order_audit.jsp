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
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/json.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/json-bean.js"></script>
<script>
	function exe_develop(){
		//Ajax进行交互-收集表单数据
		var jsonObj=$("#myForm").serializeJson();
		var jsonStr=JSON.stringify(jsonObj);
		$.ajax({
				type:"POST",
				contentType: "application/json; charset=utf-8",
				url:"<%=basePath %>audit/save_audit_ajax.action",
				async:false,
				data: jsonStr,
				dataType:"json",
				success: function(data){
					if(data.message=="success"){
						show('cover1','pop_msxf');
					}
					else{
						alert("保存失败");
					}
				}
			});
		
	}
	function tj_audit(){
		window.location.href="${pageContext.request.contextPath}/sys/order_list.action";
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
	<div class="gr_right p10">
		<div class="home_tit left red1 fontB"> <div class="btn_gr2 mt8" style="float:right"><a class="hand" href="grgzt.html">返回个人工作台</a></div><span class="ml20">委托开发</span> </div>   
		<p class="w100 left line30 orange3 font12">温馨提示：标识*为必填项，填写完信息后请提交</p>
	<form name="myForm" id="myForm">
	<input type="hidden" id="order_id" name="order_id" value="${order.id }"/>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="grgz_tab left">
		<tr>
			<th scope="row"><span class="orange3">*</span> 是否审核通过：</th>
			<td > <input name="audit_status" type="radio" value="1" checked="checked" /> 审核通过   <input name="audit_status" type="radio" value="0" /> 审核不通过</td>
			</tr>
		<tr>
			<th scope="row">审核意见：</th>
			<td ><textarea name="audit_opinion" id="audit_opinion" cols="" rows="" style="height:80px; line-height:20px;" class="input90"></textarea></td>
			</tr>
	</table>
	</form>
	<div style=" width:300px;  margin:7px auto 0; float:none;">
	<div class="btn_gr2 mt8" ><a class="hand" onclick="show('cover1','pop_sure');">委托开发</a></div> 
	<div class="btn_gr2 mt8" ><a class="hand" onclick="show('cover1','pop_tuih');">退回上一环节</a></div> 
	</div>
	<div class="w100 hi2 left"></div>
	<div class="box1_tit w100 left varcx_tab left mt25 ">
				<ul id="tabnav">
					<li  onclick="nTabs(this,'0','on','');">需求基本信息</li>
					<li  onclick="nTabs(this,'1','on','');">需求分析</li>
					<li class="on" onclick="nTabs(this,'2','on','');">需求确认</li>
				</ul>
			</div>
	<div id="tabnav_Content0" class="dis_none w100 left">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="grgz_tab" style="border-top:0px;">
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
			<th scope="row">相关附件：<br /><input name="" type="button" value="下载全部"  class="btn_gr1 ml10"/></th>
			<td colspan="3">
			<c:forEach items="${orderAttachList }" var="attach">
			<p>${attach.attach_name }   <a href="${pageContext.request.contextPath}/sys/downloadTest.action?url=${attach.url}&attach_name=${attach.attach_name}&server_name=${attach.server_name}">下载</a></p>
			</c:forEach>
			

			</td>
			</tr>
	</table>
	</div>
	<div id="tabnav_Content1" class="dis_none w100 left">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="grgz_tab" style="border-top:0px;">
		<tr>
			<th scope="row">需求分析文档：</th>
			<td>
			
			<c:forEach items="${analyse_attach_list}" var="attach">
			<p>${attach.attach_name }   <a href="${pageContext.request.contextPath}/sys/downloadTest.action?url=${attach.url}&attach_name=${attach.attach_name}&server_name=${attach.server_name}">下载</a></p>
			</c:forEach>		
			</td>
			</tr>
		<tr>
			<th scope="row">需求分析意见/说明：</th>
			<td>${analyse.analyse_opinion }</td>
			</tr>
		</table>
	</div>
	<div id="tabnav_Content2" class="w100 left">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="grgz_tab" style="border-top:0px;">
		<tr>
			<th scope="row">需求确认表：</th>
				<td colspan="3">
				<c:forEach items="${confirm_attach_list}" var="attach">
					<c:if test="${attach.attach_tag eq 'order_confirm'}">
					<p>${attach.attach_name }
					<a href="${pageContext.request.contextPath}/sys/downloadTest.action?url=${attach.url}&attach_name=${attach.attach_name}&server_name=${attach.server_name}">下载</a></p>
					</c:if>
				</c:forEach>
				</td>
		</tr>
		<tr>
			<th scope="row">工作量预估表：</th>
				<td colspan="3">
				<c:forEach items="${confirm_attach_list}" var="attach">
					<c:if test="${attach.attach_tag eq 'work_estimate'}">
					<p>${attach.attach_name }
					<a href="${pageContext.request.contextPath}/sys/downloadTest.action?url=${attach.url}&attach_name=${attach.attach_name}&server_name=${attach.server_name}">下载</a></p>
					</c:if>
				</c:forEach>
				</td>
		</tr>
		<tr>
			<th scope="row">预计完成时间：</th>
			<td>${confirm.estimate_date }</td>
			<th scope="row">预估工作量：</th>
			<td>${confirm.estimate_work }</td>
			</tr>
		<tr>
			<th scope="row">初评工作量：</th>
			<td>${confirm.evaluation_work }</td>
			<th scope="row">&nbsp;</th>
			<td>&nbsp;</td>
			</tr>
		</table>
	</div>
</div>
<!--main 结束-->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/public.js"></script>
<!--提示弹出层 开始-->
	<div id="cover1"></div>		
	<!--保存需求 弹出框 开始-->
	<div class="pop_410" id="pop_sure">
		<div class="pop_410_t pop_box_t"><span class=" mr15 pop_close" onclick="hide('cover1','pop_sure');"></span>  <strong class="fl ml15">提示</strong> </div>
		<div class="pop_410_m text_c">
			<div style="padding-top:30px; padding-bottom:30px;">确定审核通过并委托开发吗？</div>
			<div class="mt20 mb10" style="margin-left:120px;">
				<span class="btn_gr2 mr20" onclick="hide('cover1','pop_sure');"><a class="hand"  onclick="exe_develop()">委托开发</a></span>
				<span class="btn_gr2" onclick="hide('cover1','pop_sure');"><a href="#">取消审核</a></span>
			</div>
		</div>
	</div>
	<!--保存需求 弹出框 结束-->
	
	<!--下发成功 弹出框 开始-->
	<div class="pop_410" id="pop_msxf">
		<div class="pop_410_t pop_box_t"><span class=" mr15 pop_close" onclick="hide('cover1','pop_msxf');"></span>  <strong class="fl ml15">提示</strong> </div>
		<div class="pop_410_m text_c">
			<div style="padding-top:30px; padding-bottom:30px;">委托开发成功！已将相关信息下发给厂商。</div>
			<div class="mt20 mb10" style="margin-left:170px;">
				<span class="btn_gr2 mr20" onclick="hide('cover1','pop_msxf');"><a href="javascript:tj_audit()">确认</a></span>
			</div>
		</div>
	</div>
	<!--下发成功 弹出框 结束-->
	
	<!--退回 弹出框 开始-->
	<div class="pop_410" id="pop_tuih">
		<div class="pop_410_t pop_box_t"><span class=" mr15 pop_close" onclick="hide('cover1','pop_tuih');"></span>  <strong class="fl ml15">提示</strong> </div>
		<div class="pop_410_m text_c">
			<div style="padding-top:30px; padding-bottom:30px;">确定审核不通过并退回重新评估吗？</div>
			<div class="mt20 mb10" style="margin-left:100px;">
				<span class="btn_gr2 mr20" onclick="hide('cover1','pop_tuih');"><a class="hand"  onclick="show('cover1','pop_tuihc');">退回上一环节</a></span>
				<span class="btn_gr2" onclick="hide('cover1','pop_tuih');"><a href="#">取消审核</a></span>
			</div>
		</div>
	</div>
	<!--退回 弹出框 结束-->
	
	<!--退回成功 弹出框 开始-->
	<div class="pop_410" id="pop_tuihc">
		<div class="pop_410_t pop_box_t"><span class=" mr15 pop_close" onclick="hide('cover1','pop_tuihc');"></span>  <strong class="fl ml15">提示</strong> </div>
		<div class="pop_410_m text_c">
			<div style="padding-top:30px; padding-bottom:30px;">退回成功！</div>
			<div class="mt20 mb10" style="margin-left:170px;">
				<span class="btn_gr2 mr20" onclick="hide('cover1','pop_tuihc');"><a href="javascript:tj_audit()">确认</a></span>
			</div>
		</div>
	</div>
	<!--退回成功 弹出框 结束-->
	
<!--提示弹出层 结束-->
</body>
</html>

