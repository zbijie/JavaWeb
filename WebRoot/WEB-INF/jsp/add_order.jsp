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
<script type="text/javascript" src="<%=basePath%>js/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/ajaxfileupload.js"></script>
<script type="text/javascript" src="<%=basePath%>js/public.js"></script>
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
//获取主键
	function getKeyAjax(){
		var key="";
		var jsonStr="{}";
		$.ajax({
				type:"POST",
				contentType: "application/json; charset=utf-8",
				url:"<%=basePath %>sys/get_key_ajax.action",
				async:false,
				data: jsonStr,
				dataType:"json",
				success: function(data){
					key=data.data.key;
				}
			});
			return key;
	
	}
//保存需求
	function saveOrder(){
		//Ajax进行交互-收集表单数据
		var jsonObj=$("#myForm").serializeJson();
		var jsonStr=JSON.stringify(jsonObj);
		$.ajax({
				type:"POST",
				contentType: "application/json; charset=utf-8",
				url:"<%=basePath %>sys/add_order_ajax.action",
				async:false,
				data: jsonStr,
				dataType:"json",
				success: function(data){
					if(data.message=="success"){
						show('cover1','pop_sure');
						//将order_id保存到页面
						var order_id=data.data.id;
						$("#order_id").attr("value",order_id);
					}
					else{
						alert("保存失败");
					}
				}
			});
	
	}
//马上下发
	function sendCompany(){
		var order_id=$("#order_id").attr("value");
		var status="1";
		jsonStr="{\"order_id\":\""+order_id+"\",\"status\":\""+status+"\"}";
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
					
					}
					else{
						alert("保存失败");
					}
				}
			});
	}
//跳转编辑页面
	function to_edit_order(){
		var order_id=$("#order_id").attr("value");
		window.location.href="${pageContext.request.contextPath}/sys/to_edit_order.action?id="+order_id;
	}
//上传附件
	function upload(filePath,file_name){
		//判断文件域是否选择
		var f_name=$("#file_name").attr("value");
		if(f_name=='' || f_name==undefined){
			alert("文件还未选择");
			return false;
		}
		var order_id=$("#order_id").attr("value");//表单中的order_id
		var url="<%=basePath%>sys/fileUpload.action?order_id="+order_id;
		jQuery.ajaxFileUpload({
			url : url,
			secureuri:false,
	        fileElementId:'file_name',                        //文件选择框的id属性
	        dataType: 'json',             
			error: function (e){
			 	console.log(e); 		
				return;
			},
			success:function(data,status) {
				if('success'==data.flag){
					alert("上传成功");
					var ids=$("#order_attach_ids").attr("value");
					var id=data.r;
					var attach_name=data.r2;
					var url=data.r3;
					var attach_id=data.r4;
					ids+=","+id;
					$("#order_attach_ids").attr("value",ids);
					//将文件追加显示在页面
					$("#div_file_list").append("<div><a href='${pageContext.request.contextPath}/sys/downloadTest.action?url="+url+"&server_name="+attach_name+"'>"+attach_name+"</a><input name=\"\" type=\"button\" value=\"删除\" rel=\""+attach_id+"\"   class=\"btn_gr3 ml10\"/><br/></div>");
				}else{
					if('fail'==data){
						alert("上传失败");
					}
					else{
						alert('上传文件出错!');
					}
				}
			}
		});
	}
	
	$(function(){
		//加载页面时要获取order_id
		var order_id=getKeyAjax();
		$("#order_id").attr("value",order_id);
		//注册删除
   		$('#div_file_list').delegate("input","click",function(){
   			//调用delFile.action
   			divObj=$(this).parent();
   			var id=$(this).attr("rel");
			var jsonstr="{\"id\":\""+id+"\"}";
			$.ajax({
					type:"POST",
					contentType: "application/json; charset=utf-8",
					url:"${pageContext.request.contextPath}/sys/delFile.action",
					async:false,
					data: jsonstr,
					dataType:"json",
					success: function(data){
						if(data.message=="success"){
							alert("删除成功");
							divObj.remove();
						}
						else{
							alert("删除失败");
						}
					}
				});
	   		})
	}); 
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
		<div class="home_tit left red1 fontB"> <div class="btn_gr2 mt8" style="float:right"><a class="hand" href="grgzt.html">返回个人工作台</a></div><span class="ml20">新建需求</span> </div>   
		<p class="w100 line30 orange3 font12 left">温馨提示：标识*为必填项，填写完信息后请提交。上传的文件类型只能为doc,docx,xls,xlsx,ppt,pptx,txt,jpg,bmp,gif,png,rar,zip格式，单个文件大小为5M以内
</p>
<form id="myForm" name="myForm" action="<%=basePath %>sys/add_order.action" method="post">
	<input type="hidden" id="order_id" name="order_id"/>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="grgz_tab left">
		<tr>
			<th scope="row"><span class="orange3">*</span> 需求名称：</th>
			<td colspan="3"><input name="order_name" id="order_name" type="text" class="input70" /> 100个字符内</td>
			</tr>
		<tr>
			<th scope="row"><span class="orange3">*</span> 系统编号：</th>
			<td colspan="3"><input name="sys_no" id="sys_no" type="text" class="input50" value="CMFJ20140606XQ0033" /> 编码格式：CMFJ+年月日（如20140528）+XQ+流水号（数字0001-9999）</td>
			</tr>
		<tr>
			<th scope="row"><span class="orange3">*</span> 需求大小：</th>
			<td colspan="3">
				<p><input name="order_scope" type="radio" value="1" checked="checked" /> 大 （90人天以上）</p>
				<p><input name="order_scope" type="radio" value="2" /> 中（30-90人天以内，包括90人天）</p>
				<p><input name="order_scope" type="radio" value="3" /> 小（30人天以下，包括30人天）</p>
			</td>
			</tr>
		<tr>
			<th scope="row"><span class="orange3">*</span> OA工单号：</th>
			<td><input name="oa_no" id="oa_no" type="text" class="input90" /></td>
			<th scope="row"><span class="orange3">*</span> 归属系统：</th>
			<td>
			<select class="input90" id="app_sys_id" name="app_sys_id" >
				<option value="">--请选择--</option>
				<option value="1">OA系统</option>
				<option value="2">ERP系统</option>
				<option value="3">监控系统</option>
			</select>
			</td>
		</tr>
		<tr>
			<th scope="row"><span class="orange3">*</span> 需求部门/单位：</th>
			<td><input name="order_dept" id="order_dept" type="text" class="input90"  /></td>
			<th scope="row"><span class="orange3">*</span> 需求提出人：</th>
			<td><input name="order_apply_man" id="order_apply_man" type="text" class="input90" /></td>
		</tr>
		<tr>
			<th scope="row"><span class="orange3">*</span> 开发负责人：</th>
			<td><input name="develop_man" id="develop_man" type="text" class="input90" /></td>
			<th scope="row"><span class="orange3">*</span> 执行厂商：</th>
			<td>
			<select class="input90"  name="execute_company" id="execute_company">
			<option value="0">----请选择----</option>
			<c:forEach items="${company_list }" var="t">
				<option value="${t.id }">${t.company_name }</option>
			</c:forEach>
			</select>
			
			</td>
		</tr>
		<tr>
			<th scope="row"><span class="orange3">*</span> 需求描述：</th>
			<td colspan="3">
			<textarea name="order_detail" id="order_detail" cols="" rows="" style="height:80px; line-height:20px;" class="input90"></textarea>
			</td>
			</tr>
		<tr>
			<th scope="row">相关附件：</th>
			<td colspan="3">
			<p>
			<input name="" type="button" value="上传"  class="btn_gr1 mt10" onclick="upload('','');"/>
			</p>
			<p>
			<input name="file_name" type="file" id="file_name" class="input70"/> 
			</p>
			<div id="div_file_list">
		
			</div>
			</td>
			</tr>
	</table>
	<!-- <input type="submit" value="提交" /> -->
	<input type="hidden" id="order_attach_ids" name="order_attach_ids" value="" />
	</form>
	<div class="clear"></div>
	<div class="btn_gr2 mt8" style=" width:100px;  margin:7px auto 0; float:none"><a class="hand" onclick="saveOrder()">保存需求</a></div>
	</div>

</div>
<!--main 结束-->
<script type="text/javascript" src="js/public.js"></script>
<!--提示弹出层 开始-->
	<div id="cover1"></div>		
	<!--保存需求 弹出框 开始-->
	<div class="pop_410" id="pop_sure">
		<div class="pop_410_t pop_box_t"><span class=" mr15 pop_close" onclick="hide('cover1','pop_sure');"></span>  <strong class="fl ml15">提示</strong> </div>
		<div class="pop_410_m text_c">
			<div style="padding-top:30px; padding-bottom:30px;">保存成功！要马上下发给厂商吗？</div>
			<div class="mt20 mb10" style="margin-left:120px;">
				<span class="btn_gr2 mr20" onclick="hide('cover1','pop_sure');"><a class="hand"  onclick="sendCompany();">马上下发</a></span>
				<span class="btn_gr2" onclick="hide('cover1','pop_sure');"><a href="javascript:to_edit_order()">暂不下发</a></span>
			</div>
		</div>
	</div>
	<!--保存需求 弹出框 结束-->
	
	<!--下发成功 弹出框 开始-->
	<div class="pop_410" id="pop_msxf">
		<div class="pop_410_t pop_box_t"><span class=" mr15 pop_close" onclick="hide('cover1','pop_msxf');"></span>  <strong class="fl ml15">提示</strong> </div>
		<div class="pop_410_m text_c">
			<div style="padding-top:30px; padding-bottom:30px;">下发成功！</div>
			<div class="mt20 mb10" style="margin-left:170px;">
				<span class="btn_gr2 mr20" onclick="hide('cover1','pop_msxf');"><a href="${pageContext.request.contextPath}/sys/order_list.action">确认</a></span>
			</div>
		</div>
	</div>
	<!--下发成功 弹出框 结束-->
	
<!--提示弹出层 结束-->
</body>
</html>
