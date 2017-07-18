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
<script language="javascript" type="text/javascript" src="${pageContext.request.contextPath}/js/My97DatePicker/WdatePicker.js"></script>


<script type="text/javascript">
(function($){  
	    $.fn.serializeJson=function(){  
	        var serializeObj={};  
	        var array=this.serializeArray();  
	        var str=this.serialize();  
	        $(array).each(function(){  
	            if(serializeObj[this.name]){  
	                if($.isArray(serializeObj[this.name])){  
	                    serializeObj[this.name].push(this.value);  
	                }else{  
	                    serializeObj[this.name]=[serializeObj
	
	[this.name],this.value];  
	                }  
	            }else{  
	                serializeObj[this.name]=this.value;   
	            }  
	        });  
	        return serializeObj;  
	    };  
	})(jQuery);
	
	/**查询工单列表**/
function search(){
		//收集表单数据
		var jsonObj=$("#myForm").serializeJson();
		var jsonStr=JSON.stringify(jsonObj); 
		$.ajax({
				type:"POST",
				contentType: "application/json; charset=utf-8",
				url:"<%=basePath %>sys/order_list_ajax.action",
				async:false,
				data: jsonStr,
				dataType:"json",
				success: function(data){
					if(data.message=="success"){
						 var info="";
						 var list=data.data;
						 //数据填充到前端页面
						 for(var i=0;i<list.length;i++){
						 		var row=list[i];
						 		var estimate_date= row.estimate_date;
						 		if(estimate_date==undefined || estimate_date=="undefined"){
						 			estimate_date="";
						 		}
								info+="<tr>";
								info+="<td><input name=\"grgzpt\" type=\"radio\"   class=\"dskg\" value=\""+row.id+"\" /></td>";
								info+="<td>"+row.sys_no+"</td>";
								info+="<td>"+row.order_name+"</td>";
								info+="<td>"+estimate_date+"</td>";
								info+="<td>"+row.execute_company_name+"</td>";
								info+="<td>"+row.order_apply_man+"</td>";
								info+="<td>"+row.order_dept+"</td>";
								info+="<td>"+row.develop_man+"</td>";
								info+="<td class=\"xmzt\">"+row.status_name+"</td>";
							    info+="</tr>";
						 }
						 $("#order_list_tb").html(info);
						 
					}
					else{
						alert("登陆失败");
					}
				}
			});
		
		
	}
//下放厂商
function sendCompany(){
		var order_id=$("input[type='radio']:checked").attr("value");
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
						show('cover1','pop_msxf');

						 search();
					}
					else{
						alert("保存失败");
					}
				}
			});
	}
//取消需求
function delete_order(){
	var order_id=$("input[type='radio']:checked").attr("value");
	window.location.href="${pageContext.request.contextPath}/sys/delete_order.action?order_id="+order_id;
}
//填写需求分析
function addOrderAnalyse(){
	//收集选中的order_id
	var order_id=$("input[type='radio']:checked").attr("value");
	window.location.href="${pageContext.request.contextPath}/analyse/to_add_order_analyse.action?order_id="+order_id;
}
//提交需求分析
function submit_analyse(){
	//判断是否已经填写需求分析文档
	var is_check=check_analyse();//1-已经存在， 0-不存在
	if(is_check=="1"){
		//直接提交需求分析 ,将状态置2-需求确认
		//收集选中的order_id
	var order_id=$("input[type='radio']:checked").attr("value");
	var status="2";
	var jsonStr="{\"order_id\":\""+order_id+"\",\"status\":\""+status+"\"}";
	//修改状态
	$.ajax({
			type:"POST",
			contentType: "application/json; charset=utf-8",
			url:"<%=basePath %>sys/update_order_ajax.action",
			async:false,
			data: jsonStr,
			dataType:"json",
			success: function(data){
				if(data.message=="success"){
					 show('cover1','pop_xqqr');
					 search();
					 
				}
				else{
					alert("修改失败");
				}
			}
		});
		
	}
	else{
		alert("请先填写需求分析");
	}

}

//判断是否已经填写需求分析文档
function check_analyse(){
	var flag="0";
	//收集选中的order_id
	var order_id=$("input[type='radio']:checked").attr("value");
	var jsonStr="{\"order_id\":\""+order_id+"\",\"status\":\"1\"}";
	//async:true  表示异步，  false 同步
	
	//修改状态
	$.ajax({
			type:"POST",
			contentType: "application/json; charset=utf-8",
			url:"<%=basePath %>analyse/check_analyse.action",
			async:false,
			data: jsonStr,
			dataType:"json",
			success: function(data){
				 flag=data.data;
			}
		});
		return flag;
}
//提交审核
function submit_confirm(){
	//判断是否已经填写需求分析文档
	var is_check=check_confirm();//1-已经存在， 0-不存在
	if(is_check=="1"){
		//直接提交需求分析 ,将状态置2-需求确认
		//收集选中的order_id
	var order_id=$("input[type='radio']:checked").attr("value");
	var status="3";
	var jsonStr="{\"order_id\":\""+order_id+"\",\"status\":\""+status+"\"}";
	//修改状态
	$.ajax({
			type:"POST",
			contentType: "application/json; charset=utf-8",
			url:"<%=basePath %>sys/update_order_ajax.action",
			async:false,
			data: jsonStr,
			dataType:"json",
			success: function(data){
				if(data.message=="success"){
					 show('cover1','pop_xqqr');
					 search();
					 
				}
				else{
					alert("修改失败");
				}
			}
		});
		
	}
	else{
		alert("请先填写需求确认");
	}

}

//判断是否已经填写需求分析文档
function check_confirm(){
	var flag="0";
	//收集选中的order_id
	var order_id=$("input[type='radio']:checked").attr("value");
	var jsonStr="{\"order_id\":\""+order_id+"\",\"status\":\"2\"}";
	//async:true  表示异步，  false 同步
	
	//修改状态
	$.ajax({
			type:"POST",
			contentType: "application/json; charset=utf-8",
			url:"<%=basePath %>confirm/check_confirm.action",
			async:false,
			data: jsonStr,
			dataType:"json",
			success: function(data){
				 flag=data.data;
			}
		});
		return flag;
}

//
function to_add_confirm(){
	//收集选中的order_id
	var order_id=$("input[type='radio']:checked").attr("value");
	window.location.href="${pageContext.request.contextPath}/confirm/to_add_order_confirm.action?order_id="+order_id;
}

//页面初始化 加载	
$(function(){ 
	//初始化调用显示列表页面 
    search();  
}); 

function to_audit(){
	//收集选中的order_id
	var order_id=$("input[type='radio']:checked").attr("value");
	window.location.href="${pageContext.request.contextPath}/audit/to_audit.action?order_id="+order_id;
}

function view_audit(){
	//收集选中的order_id
	var order_id=$("input[type='radio']:checked").attr("value");
	window.location.href="${pageContext.request.contextPath}/audit/view_audit.action?order_id="+order_id;
}
//查看详情
function view_order(){
	//收集选中的order_id
	var order_id=$("input[type='radio']:checked").attr("value");
	window.location.href="${pageContext.request.contextPath}/sys/view_order.action?order_id="+order_id;
}
function to_edit_order(){
	var order_id=$("input[type='radio']:checked").attr("value");
	window.location.href="${pageContext.request.contextPath}/sys/to_edit_order.action?id="+order_id;
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
		
		<div class="gr_search pb10 mb10 w100 left">
		<form name="myForm" id="myForm">
			<p>需求编号： <input name="sys_no" id="sys_no" type="text" class="input1" />
				需求名称： <input name="order_name" id="order_name" type="text" class="input1" />                                   
			提出人： <input name="order_apply_man" id="order_apply_man"  type="text" class="input1" />                        
			提出单位：
			 <input name="order_dept" id="order_dept" type="text" class="input2" /></p>   
			<p>项目经理： <input name="develop_man" id="develop_man" type="text" class="input1" />                       
			执行厂商：
			 <select name="execute_company" id="execute_company" type="text" class="input2" >
			 	<option value="">---选择全部---</option>
			 	<c:forEach items="${company_list}" var="c">
			 		<option value="${c.id}">${c.company_name}</option>
			 	</c:forEach>
			 </select>
			计划上线时间：<input id="estimate_date_begin" name="estimate_date_begin" class="Wdate input3" type="text" onClick="WdatePicker()">  至  <input id="estimate_date_end" name="estimate_date_end" class="Wdate input3" type="text" onClick="WdatePicker()"> 
			 <input name="" type="button" value="查询" onclick="search()"  class="btn_gr1 ml10"/></p> 
		</form>
		</div>
		<div class="ge_btn mb10  w100 left" style=" margin-bottom:0px;">
			<div class="btn_gr2"><a href="javascript:view_order();">查看详情</a></div>
			<div class="xxq_btn btn_none dis_none">
				<div class="btn_gr2"><a href="javascript:to_edit_order()">编辑需求</a></div>
				<div class="btn_gr2"><a class="hand"  onclick="show('cover1','pop_xfcs');">下发厂商</a></div>
				<div class="btn_gr2"><a class="hand"  onclick="show('cover1','pop_qxxq');">取消需求</a></div>
			</div>
			<div class="xqfx_btn btn_none dis_none">
				<div class="btn_gr2"><a href="javascript:addOrderAnalyse()">填写需求分析</a></div>
				<div class="btn_gr2"><a class="hand"  onclick="submit_analyse();">提交需求分析</a></div>
				<div class="btn_gr2"><a class="hand"  onclick="show('cover1','pop_sqzzxq');" >申请终止需求</a></div>
				<div class="btn_gr2"><a href="zzxqspjg.html">查看终止审批结果</a></div>
			</div>
			<div class="xqqr_btn btn_none dis_none">
				<div class="btn_gr2"><a href="javascript:to_add_confirm()">填写需求确认</a></div>
				<div class="btn_gr2"><a class="hand"  onclick="show('cover1','pop_sh');">提交审核</a></div>
				<div class="btn_gr2"><a href="javascript:view_audit()">查看审核意见</a></div>
				<div class="btn_gr2"><a class="hand"  onclick="show('cover1','pop_sqzzxq');" >申请终止需求</a></div>
				<div class="btn_gr2"><a href="zzxqspjg.html">查看终止审批结果</a></div>
			</div>
			<div class="xqdsh_btn btn_none dis_none">
				<div class="btn_gr2"><a href="javascript:to_audit()">审核</a></div>
				<div class="btn_gr2"><a class="hand"  onclick="show('cover1','pop_sqzzxq');" >终止需求</a></div>
			</div>
			<div class="zxkf_btn btn_none dis_none">
				<div class="btn_gr2"><a href="wckf.html">完成开发</a></div>
				<div class="btn_gr2"><a class="hand"  onclick="show('cover1','pop_ys');">提交验收</a></div>
				<div class="btn_gr2"><a href="ckysjg.html">查看验收结果</a></div>
				<div class="btn_gr2"><a class="hand"  onclick="show('cover1','pop_sqzzxq');" >申请终止需求</a></div>
				<div class="btn_gr2"><a href="zzxqspjg.html">查看终止审批结果</a></div>
			</div>
			<div class="xqys_btn btn_none dis_none">
				<div class="btn_gr2"><a href="xqys.html">需求验收</a></div>
			</div>
			<div class="sxsq_btn btn_none dis_none">
				<div class="btn_gr2"><a href="sxsq.html">填写上线申请</a></div>
				<div class="btn_gr2"><a class="hand"  onclick="show('cover1','pop_sxsq');">提交上线申请</a></div>
				<div class="btn_gr2"><a href="zzxqspjg.html">查看审批结果</a></div>
			</div>
			<div class="sxsp_btn btn_none dis_none">
				<div class="btn_gr2"><a href="sxsp.html">上线审批</a></div>
			</div>
			<div class="sxgj_btn btn_none dis_none">
				<div class="btn_gr2"><a href="sxgj.html">上线割接</a></div>
			</div>
			<div class="hpg_btn btn_none dis_none">
				<div class="btn_gr2"><a href="hpg.html">后评估</a></div>
			</div>
			<div class="zzdsh_btn btn_none dis_none">
				<div class="btn_gr2"><a href="xqzzsp.html">终止待审核</a></div>
			</div>
		</div>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="text_c gr_tab mt10 left" id="gr_tab" >
			<tr>          
				<th scope="col">&nbsp;</th>                                                                               
				<th scope="col">需求编号</th>
				<th scope="col">需求名称</th>
				<th scope="col">计划上线时间</th>
				<th scope="col">执行厂商</th>
				<th scope="col">提出人</th>
				<th scope="col">提出单位</th>
				<th scope="col">项目经理</th>
				<th scope="col">需求状态</th>	
			</tr>
			<tbody id="order_list_tb" name="order_list_tb">
			
		
			</tbody>
		</table>

		<div class="page line30">
			<span class="right">首 页  上一页  下一页  末 页  每页显示 <select name="" class="input4">    </select>  条记录，跳转到第  <input name="" type="text" class="input4" />   页</span>
			<span class="left">找到 <span class="red"> 10 </span> 条记录，显示 1 到 10</span>
		</div>
	</div>

</div>
<!--main 结束-->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/public.js"></script>
<!--提示弹出层 开始-->
	<div id="cover1"></div>		
	<!--保存需求 弹出框 开始-->
	<div class="pop_410" id="pop_xfcs">
		<div class="pop_410_t pop_box_t"><span class=" mr15 pop_close" onclick="hide('cover1','pop_xfcs');"></span>  <strong class="fl ml15">提示</strong> </div>
		<div class="pop_410_m text_c">
			<div style="padding-top:30px; padding-bottom:30px;">确定要下发给厂商吗？</div>
			<div class="mt20 mb10" style="margin-left:120px;">
				<span class="btn_gr2 mr20" onclick="hide('cover1','pop_xfcs');"><a class="hand"  onclick="sendCompany()">下发厂商</a></span>
				<span class="btn_gr2" onclick="hide('cover1','pop_xfcs');"><a href="#">取 消</a></span>
			</div>
		</div>
	</div>
	<!--保存需求 弹出框 结束-->
	
	<!--取消需求 弹出框 开始-->
	<div class="pop_410" id="pop_qxxq">
		<div class="pop_410_t pop_box_t"><span class=" mr15 pop_close" onclick="hide('cover1','pop_qxxq');"></span>  <strong class="fl ml15">提示</strong> </div>
		<div class="pop_410_m text_c">
			<div style="padding-top:30px; padding-bottom:30px;">确定要取消该需求吗？</div>
			<div class="mt20 mb10" style="margin-left:120px;">
				<span class="btn_gr2 mr20" onclick="hide('cover1','pop_qxxq');"><a href="javascript:delete_order();" >确定取消</a></span>
				<span class="btn_gr2" onclick="hide('cover1','pop_qxxq');"><a href="#">暂不取消</a></span>
			</div>
		</div>
	</div>
	<!--取消需求 弹出框 结束-->
	
	<!--提交上线申请 弹出框 开始-->
	<div class="pop_410" id="pop_sxsq">
		<div class="pop_410_t pop_box_t"><span class=" mr15 pop_close" onclick="hide('cover1','pop_sxsq');"></span>  <strong class="fl ml15">提示</strong> </div>
		<div class="pop_410_m text_c">
			<div style="padding-top:30px; padding-bottom:30px;">确定要提交上线申请吗？</div>
			<div class="mt20 mb10" style="margin-left:120px;">
				<span class="btn_gr2 mr20" onclick="hide('cover1','pop_sxsq'); show('cover1','pop_qrcg');"><a class="hand" >提交申请</a></span>
				<span class="btn_gr2" onclick="hide('cover1','pop_sxsq');"><a href="#">取消</a></span>
			</div>
		</div>
	</div>
	<!--提交上线申请 弹出框 结束-->
	
	<!--下发成功 弹出框 开始-->
	<div class="pop_410" id="pop_msxf">
		<div class="pop_410_t pop_box_t"><span class=" mr15 pop_close" onclick="hide('cover1','pop_msxf');"></span>  <strong class="fl ml15">提示</strong> </div>
		<div class="pop_410_m text_c">
			<div style="padding-top:30px; padding-bottom:30px;">下发成功！</div>
			<div class="mt20 mb10" style="margin-left:170px;">
				<span class="btn_gr2 mr20" onclick="hide('cover1','pop_msxf');"><a href="#">确认</a></span>
			</div>
		</div>
	</div>
	<!--下发成功 弹出框 结束-->
	
	<!--确认成功 弹出框 开始-->
	<div class="pop_410" id="pop_qrcg">
		<div class="pop_410_t pop_box_t"><span class=" mr15 pop_close" onclick="hide('cover1','pop_qrcg');"></span>  <strong class="fl ml15">提示</strong> </div>
		<div class="pop_410_m text_c">
			<div style="padding-top:30px; padding-bottom:30px;">提交成功！</div>
			<div class="mt20 mb10" style="margin-left:170px;">
				<span class="btn_gr2 mr20" onclick="hide('cover1','pop_qrcg');"><a href="#">确认</a></span>
			</div>
		</div>
	</div>
	<!--确认成功 弹出框 结束-->
	
	<!--需求确认 弹出框 开始-->
	<div class="pop_410" id="pop_xqqr">
		<div class="pop_410_t pop_box_t"><span class=" mr15 pop_close" onclick="hide('cover1','pop_xqqr');"></span>  <strong class="fl ml15">提示</strong> </div>
		<div class="pop_410_m text_c">
			<div style="padding-top:30px; padding-bottom:30px;">确定提交需求确认吗？</div>
			<div class="mt20 mb10" style="margin-left:120px;">
				<span class="btn_gr2 mr20" onclick="hide('cover1','pop_xqqr'); show('cover1','pop_qrcg')"><a class="hand" >提交确认</a></span>
				<span class="btn_gr2" onclick="hide('cover1','pop_xqqr');"><a href="#">取 消</a></span>
			</div>
		</div>
	</div>
	<!--需求确认 弹出框 结束-->
	
	<!--提交审核 弹出框 开始-->
	<div class="pop_410" id="pop_sh">
		<div class="pop_410_t pop_box_t"><span class=" mr15 pop_close" onclick="hide('cover1','pop_sh');"></span>  <strong class="fl ml15">提示</strong> </div>
		<div class="pop_410_m text_c">
			<div style="padding-top:30px; padding-bottom:30px;">确定要提交审核吗？</div>
			<div class="mt20 mb10" style="margin-left:120px;">
				<!--<span class="btn_gr2 mr20" onclick="hide('cover1','pop_sh'); show('cover1','pop_qrcg')"><a class="hand" onclick="submit_analyse()">提交确认</a></span>-->
				<span class="btn_gr2 mr20" onclick="hide('cover1','pop_sh');"><a href="javascript:submit_confirm();" >提交确认</a></span>
				<span class="btn_gr2" onclick="hide('cover1','pop_sh');"><a href="#">取 消</a></span>
			</div>
		</div>
	</div>
	<!--提交审核 弹出框 结束-->
	
	<!--提交验收 弹出框 开始-->
	<div class="pop_410" id="pop_ys">
		<div class="pop_410_t pop_box_t"><span class=" mr15 pop_close" onclick="hide('cover1','pop_ys');"></span>  <strong class="fl ml15">提示</strong> </div>
		<div class="pop_410_m text_c">
			<div style="padding-top:30px; padding-bottom:30px;">确定要提交需求经理验收吗？</div>
			<div class="mt20 mb10" style="margin-left:120px;">
				<span class="btn_gr2 mr20" onclick="hide('cover1','pop_ys'); show('cover1','pop_qrcg')"><a class="hand" >提交验收</a></span>
				<span class="btn_gr2" onclick="hide('cover1','pop_ys');"><a href="#">取 消</a></span>
			</div>
		</div>
	</div>
	<!--提交验收 弹出框 结束-->
	
	<!--申请终止需求 弹出框 开始-->
	<div class="pop_410" id="pop_sqzzxq">
		<div class="pop_410_t pop_box_t"><span class=" mr15 pop_close" onclick="hide('cover1','pop_sqzzxq');"></span>  <strong class="fl ml15">提示</strong> </div>
		<div class="pop_410_m text_c">
			<div>
				<p class="left ml20">请填写终止需求理由：</p>
				<textarea name="" cols="" rows="" class="input90" style="height:80px;"></textarea>
			</div>
			<div class="mt20 mb10" style="margin-left:120px;">
				<span class="btn_gr2 mr20" onclick="hide('cover1','pop_sqzzxq');"><a class="hand" >提交审核</a></span>
				<span class="btn_gr2" onclick="hide('cover1','pop_sqzzxq');"><a href="#">暂不终止</a></span>
			</div>
		</div>
	</div>
	<!--申请终止需求 弹出框 结束-->
	
<!--提示弹出层 结束-->
</body>
</html>
