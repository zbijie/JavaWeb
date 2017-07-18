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
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.0.min.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/Tstyle.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/public.css"/>
<script type="text/javascript">
//下载全部
	function downloadAll(){
		var order_id=$("#order_id").attr("value");
		window.location.href="${pageContext.request.contextPath}/sys/downloadAll.action?order_id="+order_id;
	}
</script>
</head>

<body>
<jsp:include page="top_tip.jsp"/>
<!--main 开始-->
<input type="hidden" name="order_id" id="order_id" value="${order.id}"/>
<div class="main1">
	<div class="gr_left">
		<iframe src="${pageContext.request.contextPath}/sys/left.action" scrolling="no" allowtransparency="true" width="151" height="600" frameborder="0"></iframe>
	</div>
	<div class="gr_right p10">
		<div class="home_tit w100 left red1 fontB"> <div class="btn_gr2 mt8" style="float:right"><a class="hand" href="grgzt.html">返回个人工作台</a></div><span class="ml20">查看详情</span> </div>  
	<div class="box1_tit varcx_tab  mt25  w100 left">
				<ul id="tabnav">
					<c:if test="${order.status >= 0 }">
						<li class="on"  onclick="nTabs(this,'0','on','');">需求基本信息</li>
					</c:if>
					<c:if test="${order.status >=1 }">
					<li  onclick="nTabs(this,'1','on','');">需求分析</li>
					</c:if>
					<c:if test="${order.status >=2 }">
					<li  onclick="nTabs(this,'2','on','');">需求确认</li>
					</c:if>
					<c:if test="${order.status >5 }">
					<li  onclick="nTabs(this,'3','on','');">需求验收</li>
					</c:if>
					<c:if test="${order.status >= 8 }">
					<li  onclick="nTabs(this,'4','on','');">上线割接</li>
					</c:if>
					<c:if test="${order.status >= 9 }">
					<li  onclick="nTabs(this,'5','on','');">后评估</li>
					</c:if>
				</ul>
			</div>
	
	<c:if test="${order.status >= 0 }">
	<div id="tabnav_Content0" class=" w100 left">
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
			<td><c:if test="${order.app_sys_id =='1'}">OA系统</c:if>
		<c:if test="${order.app_sys_id =='2'}">ERP系统</c:if>
		<c:if test="${order.app_sys_id =='3'}"> 监控系统</c:if></td>
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
			<td><blockquote>${order.execute_company_name }</blockquote></td>
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
	</c:if>
	<c:if test="${order.status >= 1 }">
	<div id="tabnav_Content1" class="dis_none w100 left">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="grgz_tab" style="border-top:0px;">
		<tr>
			<th scope="row">需求分析文档：</th>
			<td>
			
			<c:forEach items="${analyse_attach_list}" var="attach">
			<p>${attach.attach_name }  
			 <a href="${pageContext.request.contextPath}/sys/downloadTest.action?url=${attach.url}&attach_name=${attach.attach_name}&server_name=${attach.server_name}">下载</a>
			 </p>
			</c:forEach>
			
			
			</td>
			</tr>
		<tr>
			<th scope="row">需求分析意见/说明：</th>
			<td>${analyse.analyse_opinion }</td>
			</tr>
		</table>
	</div>
	</c:if>
	<c:if test="${order.status >= 2 }">
	<div id="tabnav_Content2" class="dis_none w100 left">
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
	</c:if>
	<c:if test="${order.status >= 5 }">
	<div id="tabnav_Content3" class="dis_none w100 left">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="grgz_tab" style="border-top:0px;">
		<tr>
			<th scope="row">测试地址：</th>
			<td>http://124.192.56.215:437/service/xzzx/</td>
			</tr>
		<tr>
			<th scope="row">需求验收文档：</th>
			<td>XXXX需求工作量预估表.xlsx  <a href="#">下载</a></td>
			</tr>
		<tr>
			<th scope="row">开发说明：</th>
			<td>lilixiang/123456</td>
			</tr>
		<tr>
			<th scope="row">相关附件：<br /><input name="" type="button" value="下载全部"  class="btn_gr1 ml10"/></th>
			<td>
			<p>附件01.doc   <a href="#">下载</a></p>
			<p>附件02.doc   <a href="#">下载</a></p>
			<p>附件03.doc   <a href="#">下载</a></p>

			</td>
			</tr>
		</table>
	</div>
	</c:if>
	<c:if test="${order.status >= 8 }">
	<div id="tabnav_Content4" class="dis_none w100 left">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="grgz_tab" style="border-top:0px;">
		<tr>
			<th scope="row">系统加固表：</th>
			<td>**需求系统加固表.doc  <a href="#">下载</a></td>
			</tr>
		<tr>
			<th scope="row">系统维护手册：</th>
			<td>**需求系统加固表.doc  <a href="#">下载</a></td>
			</tr>
		<tr>
			<th scope="row">上线公告：</th>
			<td>是</td>
			</tr>
		<tr>
			<th scope="row">客户解释文档：</th>
			<td>**需求系统加固表.doc  <a href="#">下载</a></td>
			</tr>
		<tr>
			<th scope="row">系统管理办法：</th>
			<td>**需求系统加固表.doc  <a href="#">下载</a></td>
			</tr>
		<tr>
			<th scope="row">系统上线方案：</th>
			<td>**需求系统加固表.doc  <a href="#">下载</a></td>
			</tr>
		<tr>
			<th scope="row">上线审批表：</th>
			<td>**需求系统加固表.doc  <a href="#">下载</a></td>
			</tr>
		</table>
	</div>
	</c:if>
	<c:if test="${order.status >= 9 }">
	<div id="tabnav_Content5" class=" dis_none w100 left">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="grgz_tab" style="border-top:0px;">
		<tr>
			<th scope="row">后评估工作量：</th>
			<td>25人/天</td>
			</tr>
		<tr>
			<th scope="row">上线报告：</th>
			<td>XX需求上线报告.doc  <a href="#">下载</a></td>
			</tr>
		<tr>
			<th scope="row">备注：</th>
			<td>无</td>
			</tr>
		<tr>
			<th scope="row">相关附件：<br /><input name="" type="button" value="下载全部"  class="btn_gr1 ml10"/></th>
			<td>
			<p>附件01.doc   <a href="#">下载</a></p>
			<p>附件02.doc   <a href="#">下载</a></p>
			<p>附件03.doc   <a href="#">下载</a></p>

			</td>
			</tr>
		<tr>
			<th scope="row">系统加固表：</th>
			<td>**需求系统加固表.doc  <a href="#">下载</a></td>
			</tr>
		<tr>
			<th scope="row">系统维护手册：</th>
			<td>**需求系统加固表.doc  <a href="#">下载</a></td>
			</tr>
		<tr>
			<th scope="row">上线公告：</th>
			<td>是</td>
			</tr>
		<tr>
			<th scope="row">客户解释文档：</th>
			<td>**需求系统加固表.doc  <a href="#">下载</a></td>
			</tr>
		<tr>
			<th scope="row">系统管理办法：</th>
			<td>**需求系统加固表.doc  <a href="#">下载</a></td>
			</tr>
		<tr>
			<th scope="row">系统上线方案：</th>
			<td>**需求系统加固表.doc  <a href="#">下载</a></td>
			</tr>
		<tr>
			<th scope="row">上线审批表：</th>
			<td>**需求系统加固表.doc  <a href="#">下载</a></td>
			</tr>
		</table>
	
	</div>
	</c:if>

</div>
<!--main 结束-->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/public.js"></script>
<!--提示弹出层 开始-->
	<div id="cover1"></div>		
	<!--保存需求 弹出框 开始-->
	<div class="pop_410" id="pop_sure">
		<div class="pop_410_t pop_box_t"><span class=" mr15 pop_close" onclick="hide('cover1','pop_sure');"></span>  <strong class="fl ml15">提示</strong> </div>
		<div class="pop_410_m text_c">
			<div style="padding-top:30px; padding-bottom:30px;">保存成功，该需求已自动归档。</div>
			<div class="mt20 mb10" style="margin-left:180px;">
				<span class="btn_gr2 mr20" onclick="hide('cover1','pop_sure');"><a class="hand" >确定</a></span>
			</div>
		</div>
	</div>
	<!--保存需求 弹出框 结束-->
	
<!--提示弹出层 结束-->
</body>
</html>

