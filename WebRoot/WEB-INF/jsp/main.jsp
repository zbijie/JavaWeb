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
<link rel="stylesheet" type="text/css" href="<%=basePath %>css/Tstyle.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath %>css/public.css"/>
<script type="text/javascript" src="<%=basePath %>js/xixi.js"></script>
<script type="text/javascript" src="<%=basePath %>js/public.js"></script>
</head>

<body>${is_demand_draft_man}
欢迎<font color='red'>${login_user.login_name }</font>登陆
<c:forEach items="${roleList }"  var="r">
	${r.role_name}
</c:forEach>
<!--main 开始-->
<div class="main">
	<div class="m_left left">
		<div class="box1">
			<div class="box1_tit"><span class="ml20">快捷方式</span></div>
			<div class="box1_cont kjfs line30">
				<ul>
					<li><a href="${pageContext.request.contextPath}/sys/order_list.action"><img src="<%=basePath %>images/icon_1.gif" /><br />我的待办</a></li>
					<li><a href="${pageContext.request.contextPath}/sys/order_list.action"><img src="<%=basePath %>images/icon_2.gif" /><br />我的已办</a></li>
					<li><a href="${pageContext.request.contextPath}/sys/order_list.action"><img src="<%=basePath %>images/icon_3.gif" /><br />我的需求</a></li>
					<li>
					<c:if test="${is_demand_draft_man=='1' }">
					<a href="${pageContext.request.contextPath}/sys/to_add_order.action"><img src="<%=basePath %>images/icon_4.gif" /><br />新建需求</a>
					</c:if>
					</li>
				</ul>
				<div class="clear"></div>
			</div>
		</div>
		<div class="clear"></div>
		<div class="box1 mt10">
			<div class="box1_tit"><span class="ml20">预警信息</span></div>
			<div class="box1_cont">
				<div class=slide-pic id=slidePic>
					<a class=gray id=prev hideFocus href="javascript:;">前移</a> 
					<div class=pic-container>
						<ul>
						  <li class=cur>
						  <p><img src="<%=basePath %>images/icon_5.gif" /> 劳动合同续签转签流程变更</p>
						  <span class="orange">【需求确认/工作量初评】提交时间已近</span>
						  </li>
						  <li class="">
						  <p><img src="<%=basePath %>images/icon_6.gif" /> 劳动合同续签转签流程变更</p>
						  <span class="red">【需求确认/工作量初评】提交时间已超过</span>
						  </li>
						  <li class="">
						  <p><img src="<%=basePath %>images/icon_5.gif" /> 劳动合同续签转签流程变更</p>
						  <span class="orange">【需求确认/工作量初评】提交时间已近</span>
						  </li>
						  <li class="">
						  <p><img src="<%=basePath %>images/icon_5.gif" /> 劳动合同续签转签流程变更</p>
						  <span class="orange">【需求确认/工作量初评】提交时间已近</span>
						  </li>
						  <li class="">
						  <p><img src="<%=basePath %>images/icon_5.gif" /> 劳动合同续签转签流程变更</p>
						  <span class="orange">【需求确认/工作量初评】提交时间已近</span>
						  </li>
						  <li class="">
						  <p><img src="<%=basePath %>images/icon_6.gif" /> 劳动合同续签转签流程变更</p>
						  <span class="red">【需求确认/工作量初评】提交时间已超过</span>
						  </li>
						  <li class="">
						  <p><img src="<%=basePath %>images/icon_5.gif" /> 劳动合同续签转签流程变更</p>
						  <span class="orange">【需求确认/工作量初评】提交时间已近</span>
						  </li>
						  <li class="">
						  <p><img src="<%=basePath %>images/icon_5.gif" /> 劳动合同续签转签流程变更</p>
						  <span class="orange">【需求确认/工作量初评】提交时间已近</span>
						  </li>
						</ul>
					</div>
					 <a id=next hideFocus href="javascript:;">后移</a>
			</div>
				<div class="clear"></div>
			</div>
		</div>
	</div>
	<div class="m_right">
		<div class="box1">
			<div class="box1_tit varcx_tab">
				<ul id="tabnav">
					<li class="on" onclick="nTabs(this,'0','on','');">我的待办<span class="orange2">（15）</span></li>
					<li onclick="nTabs(this,'1','on','');">我的需求<span class="orange2">（223）</span></li>
					<li onclick="nTabs(this,'2','on','');">我的已办<span class="orange2">（24）</span></li>
				</ul>
			</div>
			<div class="box1_cont h290 xmgl" style="border-top:0px;">
				<div id="tabnav_Content0" class="p10">
					<div style="height:260px; overflow-y:auto; overflow-x:hidden">
					<ul>
						<c:forEach var="item" items="${doneList}" varStatus="status"> 
						<li>
						<a href="#">${item.order_name }  </a> 
						<span class="time">[2014/02/18]</span>
						<span class="name">${item.real_name }</span> 
						<span class="bm">${item.name }</span>    
						</li>
						</c:forEach>
					</ul>
					</div>
				</div>
				<div id="tabnav_Content1" class="dis_none p10">
					<ul>
						<li>
						<a href="#">中移党建工作模块需求   </a> 
						<span class="time">[2014/02/18]</span>
						<span class="name">贺延敏</span> 
						<span class="bm">人力资源部</span>    
						</li>
						<li>
						<a href="#">劳动合同续签转签流程变更  </a> 
						<span class="time">[2014/02/18]</span>
						<span class="name">贺延敏</span> 
						<span class="bm">人力资源部</span>    
						</li>
						<li>
						<a href="#">劳动合同续签转签流程变更  </a> 
						<span class="time">[2014/02/18]</span>
						<span class="name">贺延敏</span> 
						<span class="bm">人力资源部</span>    
						</li>
						<li>
						<a href="#">合同范本正文编辑优化  </a> 
						<span class="time">[2014/02/18]</span>
						<span class="name">贺延敏</span> 
						<span class="bm">人力资源部</span>    
						</li>
						<li>
						<a href="#">工单报表与操作维护审批  </a> 
						<span class="time">[2014/02/18]</span>
						<span class="name">贺延敏</span> 
						<span class="bm">人力资源部</span>    
						</li>
						<li>
						<a href="#">工单增加应用系统及任务类别   </a> 
						<span class="time">[2014/02/18]</span>
						<span class="name">贺延敏</span> 
						<span class="bm">人力资源部</span>    
						</li>
						<li>
						<a href="#">合同范本正文编辑优化  </a> 
						<span class="time">[2014/02/18]</span>
						<span class="name">贺延敏</span> 
						<span class="bm">人力资源部</span>    
						</li>
					</ul>
					<span class="right red line30"><a href="grgzt_xq.html">更多&gt;&gt;</a> </span>
				</div>
				<div id="tabnav_Content2" class="dis_none p10">
					<ul>
						<li>
						<a href="#">劳动合同续签转签流程变更  </a> 
						<span class="time">[2014/02/18]</span>
						<span class="name">贺延敏</span> 
						<span class="bm">人力资源部</span>    
						</li>
						<li>
						<a href="#">工单增加应用系统及任务类别   </a> 
						<span class="time">[2014/02/18]</span>
						<span class="name">贺延敏</span> 
						<span class="bm">人力资源部</span>    
						</li>
						<li>
						<a href="#">合同范本正文编辑优化  </a> 
						<span class="time">[2014/02/18]</span>
						<span class="name">贺延敏</span> 
						<span class="bm">人力资源部</span>    
						</li>
						<li>
						<a href="#">工单报表与操作维护审批  </a> 
						<span class="time">[2014/02/18]</span>
						<span class="name">贺延敏</span> 
						<span class="bm">人力资源部</span>    
						</li>
						<li>
						<a href="#">中移党建工作模块需求   </a> 
						<span class="time">[2014/02/18]</span>
						<span class="name">贺延敏</span> 
						<span class="bm">人力资源部</span>    
						</li>
						<li>
						<a href="#">劳动合同续签转签流程变更  </a> 
						<span class="time">[2014/02/18]</span>
						<span class="name">贺延敏</span> 
						<span class="bm">人力资源部</span>    
						</li>
						<li>
						<a href="#">工单报表与操作维护审批  </a> 
						<span class="time">[2014/02/18]</span>
						<span class="name">贺延敏</span> 
						<span class="bm">人力资源部</span>    
						</li>
					</ul>
					<span class="right red line30"><a href="grgzt_yb.html">更多&gt;&gt;</a> </span>
				</div>
			</div>
		</div>

	<div class="Hr_1 box1 box1_cont h300 mt10" id="div" style="CURSOR: hand">
      <div class="Hr_11 h300">
	  	<div>
	    <a class="act" id="a0" onmouseover="Mea(0);" onmouseout="clearAuto()" href="tjfx.html"  target="_self">
		<img src="<%=basePath %>images/tjb_zz.gif" /><br />需求状态分布</a> 
		<a class="nor" id="a1" onmouseover="Mea(1);" onmouseout="clearAuto()" href="xqyjfb.html"  target="_self">
		<img src="<%=basePath %>images/tjb_zz.gif" /><br />需求预警分布</a> 
		<a class="nor" id="a2" onmouseover="Mea(2);" onmouseout="clearAuto()" href="yyxtfb.html"  target="_self">
		<img src="<%=basePath %>images/tjb_bz.gif" /><br />应用系统分布</a>
		<a class="nor" id="a3" onmouseover="Mea(3);"  onmouseout="clearAuto()" href="zxcsfb.html" target="_self">
		<img src="<%=basePath %>images/tjb_bz.gif" /><br />执行厂商分布</a>
		</div>
	  </div>
	<div class="text_c">
    <img id="pc_0" style="DISPLAY: block" height="280" src="<%=basePath %>images/tjb_img1.png" />
	<img id="pc_1" style="DISPLAY: none" height="280" src="<%=basePath %>images/tjb_img2.png" />
	<img id="pc_2" style="DISPLAY: none" height="280" src="<%=basePath %>images/tjb_img3.png"  />
	<img id="pc_3" style="DISPLAY: none" height="280" src="<%=basePath %>images/tjb_img4.png" />
	</div>
	</div>
	</div> 
</div>
<!--main 结束-->

</body>
</html>

