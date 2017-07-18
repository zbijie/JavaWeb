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
*{ margin:0px; border:0px solid red; padding:0px; font-family:"汉仪中楷简";}
#top2{ width:750px; height:60px; background-color:#282828; color:#FFF; font-size:24px; text-align:center; line-height:60px;}
#top2 img{ float:left; }
#top2 span{ padding-right:70px;}
#box{ width:750px; height:1470px; background:url(<%=basePath%>images/mobile/images/images6/bg.png) no-repeat center top; margin-left:auto; margin-right:auto; }
#top{ width:616px; height:600px; margin:0px auto; padding-top:20px; color:#FFF;}
#top{ width:616px; height:600px; margin:0px auto; padding-top:20px; color:#FFF;}

#tab{ width:616px; height:600px; margin-top:-20px;}
#input1{ width:604px; height:50px; opacity:0.5; border-radius:10px; font-size:30px; color:#000; padding-left:10px;}
.input_180w{ width:200px; height:30px; opacity:0.5; border-radius:10px; font-size:30px; color:#000; padding-left:10px;}
.input_604t{ width:604px; height:50px; opacity:0.5; border-radius:10px; font-size:30px; color:#000; padding-left:10px;}
#input_1{ width:280px; height:50px; opacity:0.5; border-radius:10px; font-size:30px; color:#000; padding-left:10px;}
.input_280t{ width:280px; height:50px; opacity:0.5; border-radius:10px; font-size:30px; color:#000; padding-left:10px;}
#select{ width:270px; height:44px;opacity:0.5; border:1px solid #FFF; }
#main{ width:760px;  margin-left:-5px;  height:1084px; }
#main ul{ width:760px; height:1084px; list-style:none; margin-top:40px; border-top:2px solid #dbdadc; background-color:#272530;}
#main ul li{ width:760px; height:98px;}
#main ul li:hover{ border:1px solid #09F;}
.ys{ background-color:#1d1c24;}
#main ul li a{ color:#9d9c9e; text-decoration:none; }
#txt2:hover{ color:#FC9;}
#main ul li span{ color:#FFF; padding-left:2px;}
#txt2{ width:650px; height:20px; margin-left:60px; padding-top:30px; line-height:20px; }
#txt2 img{ float:right; margin-top:-20px;}
#box2{ width:750px; height:1294px; margin-top:108px; background:url(<%=basePath%>images/mobile/images/images/1_02.png) no-repeat left top; margin-left:-5px;}
#input2{ width:604px; height:50px;  border-radius:10px; font-size:30px; color:#000; padding-left:10px;}
.input_604w{width:604px; height:50px;  border-radius:10px; font-size:30px; color:#000; padding-left:10px;}
#input3{ width:280px; height:50px;  border-radius:10px; font-size:30px; color:#000; padding-left:10px;}
.input_280w{width:280px; height:50px;  border-radius:10px; font-size:30px; color:#000; padding-left:10px;}
#tab2{ margin:0px auto; color:#FFF;}
#tab2 span{ color:#bfc3c4; font-size:20px;}
#input4{ border-radius:5px; color:#bfc3c4; width:454px; height:34px; background-color:#FFF; padding-top:10px;}
.input_4{border-radius:5px; color:#bfc3c4; width:454px; height:34px; background-color:#FFF; padding-top:10px;}
#input5{ background-color:a4a9ae; width:140px; height:44px; margin-left:10px;border-radius:5px; font-size:18px;}
.input_5{ background-color:a4a9ae; width:140px; height:44px; margin-left:10px;border-radius:5px; font-size:18px;}
#td1{ padding-top:10px;}
#input6{ width:100px; height:30px; color:#000; margin-top:45px; font-family:"宋体" }
.input_6{ width:100px; height:30px; color:#000; margin-top:45px; font-family:"宋体" }
</style>
<script type="text/javascript" src="<%=basePath%>js/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/ajaxfileupload.js"></script>
<script type="text/javascript" src="<%=basePath%>js/public.js"></script>
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
		var jsonObj=$("#myForm1").serializeJson();
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
						alert("新建成功！");
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
						 info+="<div id=\"main\">";
						 info+="<ul>";
						 var list=data.data;
						 //数据填充到前端页面
						 for(var i=0;i<list.length;i++){
						 		var row=list[i];
						 		var estimate_date= row.estimate_date;
						 		if(estimate_date==undefined || estimate_date=="undefined"){
						 			estimate_date="";
						 		}

								info+="<li>";
								info+="<a href=\"${pageContext.request.contextPath}/sys/demand2.action?order_id="+row.id+"\">";
								info+="<div id=\"txt2\">";
								info+="<span>需求编号:"+row.sys_no+"</span>&nbsp;&nbsp;&nbsp;";
								info+="需求名称:"+row.order_name+"&nbsp;&nbsp;&nbsp;";
								info+="提出人:"+row.order_apply_man+"<br />";
								info+="需求状态:"+row.status_name+"";
								info+="<img src=\"<%=basePath%>images/mobile/images/images5/images/1_03.png\" width=\"46\" height=\"41\" />";
								info+="</div>";
								info+="</a>";
								info+="</li>";
						 }
						 info+="</ul>";
						 info+="</div>";
						 $("#order_list_tb").html(info);
						 $("#order_list_tb1").html(info);
						 $("#order_list_tb2").html(info);
						 
					}
					else{
						alert("登陆失败");
					}
				}
			});
		
		
	}
//页面初始化 加载	
$(function(){ 
	//初始化调用显示列表页面 
    search();  
}); 

</script>



<script src="<%=basePath%>js/mobile/SpryAssets2/SpryTabbedPanels.js" type="text/javascript"></script>
<link href="<%=basePath%>css/mobile/SpryAssets2/SpryTabbedPanels.css" rel="stylesheet" type="text/css" />
</head>

<body>
<div id="box">
<div id="top2"><a href="${pageContext.request.contextPath}/sys/main.action?app_type=mobile"><img src="<%=basePath%>images/mobile/images/images/gd2_03.png" width="88" height="60" /></a><span>个人工作台</span></div>
  <div id="TabbedPanels1" class="TabbedPanels">
    <ul class="TabbedPanelsTabGroup">
      <li class="TabbedPanelsTab" tabindex="0">我的代办</li>
      <li class="TabbedPanelsTab" tabindex="0">我的需求</li>
      <li class="TabbedPanelsTab" tabindex="0">我的已办</li>
      <li class="TabbedPanelsTab" tabindex="0">新建需求</li>
    </ul>
    <div class="TabbedPanelsContentGroup">
      <div class="TabbedPanelsContent">      <div id="top">

<form name="myForm" id="myForm">
<table id="tab" width="616" height="600" border="0">
  <tr>
    <td height="120" colspan="2">需求编号<br /><br /><input name="sys_no" id="sys_no" type="text"  maxlength="20"  class="input_604t" /></td>
    </tr>
  <tr>
    <td height="120" colspan="2">需求名称<br /><br /><input name="order_name" id="order_name" type="text" maxlength="20"  class="input_604t" /></td>
    </tr>
  <tr>
    <td height="120">提出人<br /><br /><input name="order_apply_man" id="order_apply_man"  type="text" class="input_280t" maxlength="20" /> </td>
    <td height="120">项目经理<br /><br /><input name="develop_man" id="develop_man" type="text" maxlength="20" class="input_280t"/> </td>
  </tr>
  <tr>
    <td height="120" colspan="2">执行厂商<br /><br /> 
    <select name="execute_company" id="execute_company" type="text" class="input_604t" >
			 	<option value="">---选择全部---</option>
			 	<c:forEach items="${company_list}" var="c">
			 		<option value="${c.id}">${c.company_name}</option>
			 	</c:forEach>
			 </select></td>
    </tr>
  <tr>
   <td height="120" valign="top" id="td1">实际上线时间<br /><br /><input id="estimate_date_begin" name="estimate_date_begin" class="input_180w" type="text" onClick="WdatePicker()"><br/>
   至  <br/><input id="estimate_date_end" name="estimate_date_end" class="input_180w" type="text" onClick="WdatePicker()">
 <td height="120" valign="top"><br/><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 <input name="" class="input_6"  type="button" value="查询" onclick="search()" />
</td>
  </tr>
</table>
</form>
</div>

<!--我的代办-->
<div id="order_list_tb" >

</div>
 
            </div>
      <div class="TabbedPanelsContent">      <div id="top">

<form name="myForm" id="myForm">
<table id="tab" width="616" height="600" border="0">
  <tr>
    <td height="120" colspan="2">需求编号<br /><br /><input name="sys_no" id="sys_no" type="text"  maxlength="20"  class="input_604t" /></td>
    </tr>
  <tr>
    <td height="120" colspan="2">需求名称<br /><br /><input name="order_name" id="order_name" type="text" maxlength="20"  class="input_604t" /></td>
    </tr>
  <tr>
    <td height="120">提出人<br /><br /><input name="order_apply_man" id="order_apply_man"  type="text" class="input_280t" maxlength="20" /> </td>
    <td height="120">项目经理<br /><br /><input name="develop_man" id="develop_man" type="text" maxlength="20" class="input_280t"/> </td>
  </tr>
  <tr>
    <td height="120" colspan="2">执行厂商<br /><br /> 
    <select name="execute_company" id="execute_company" type="text" class="input_604t" >
			 	<option value="">---选择全部---</option>
			 	<c:forEach items="${company_list}" var="c">
			 		<option value="${c.id}">${c.company_name}</option>
			 	</c:forEach>
			 </select></td>
    </tr>
  <tr>
   <td height="120" valign="top" id="td1">实际上线时间<br /><br /><input id="estimate_date_begin" name="estimate_date_begin" class="input_180w" type="text" onClick="WdatePicker()"><br/>
   至  <br/><input id="estimate_date_end" name="estimate_date_end" class="input_180w" type="text" onClick="WdatePicker()">
 <td height="120" valign="top"><br/><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 <input name="" class="input_6"  type="button" value="查询" onclick="search()" />
</td>
  </tr>
</table>
</form>
</div>
<!--我的需求-->
<div id="order_list_tb1" name="order_list_tb">

</div>

</div>
       <div class="TabbedPanelsContent">      <div id="top">
<form name="myForm" id="myForm" >
<table id="tab" width="616" height="600" border="0">
  <tr>
    <td height="120" colspan="2">需求编号<br /><br /><input name="sys_no" id="sys_no" type="text"  maxlength="20"  class="input_604t" /></td>
    </tr>
  <tr>
    <td height="120" colspan="2">需求名称<br /><br /><input name="order_name" id="order_name" type="text" maxlength="20"  class="input_604t" /></td>
    </tr>
  <tr>
    <td height="120">提出人<br /><br /><input name="order_apply_man" id="order_apply_man"  type="text" class="input_280t" maxlength="20" /> </td>
    <td height="120">项目经理<br /><br /><input name="develop_man" id="develop_man" type="text" maxlength="20" class="input_280t"/> </td>
  </tr>
  <tr>
    <td height="120" colspan="2">执行厂商<br /><br /> 
    <select name="execute_company" id="execute_company" type="text" class="input_604t" >
			 	<option value="">---选择全部---</option>
			 	<c:forEach items="${company_list}" var="c">
			 		<option value="${c.id}">${c.company_name}</option>
			 	</c:forEach>
			 </select></td>
    </tr>
  <tr>
   <td height="120" valign="top" id="td1">实际上线时间<br /><br /><input id="estimate_date_begin" name="estimate_date_begin" class="input_180w" type="text" onClick="WdatePicker()"><br/>
   至  <br/><input id="estimate_date_end" name="estimate_date_end" class="input_180w" type="text" onClick="WdatePicker()">
 <td height="120" valign="top"><br/><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 <input name="" class="input_6"  type="button" value="查询" onclick="search()" />
</td>
  </tr>
</table>
</form>
</div>
<!--我的已办-->
<div id="order_list_tb2" name="order_list_tb2">

</div>

</div>
      <div class="TabbedPanelsContent">
      
      <div id="box2">
      <form id="myForm1" name="myForm1"  method="get">
    	<input type="hidden" id="order_id" name="order_id"/>
      <input type="hidden" id="app_type" name="app_type" value="mobile"/>
      <table id="tab2" width="642" height="1200" border="0">
  <tr>
    <td height="120" colspan="2">需求名称<br /><br /><input name="order_name" id="order_name" class="input_604w" type="text"  maxlength="20"  /></td>
    </tr>
  <tr>
    <td height="120" colspan="2">系统编号<br /><br /><input name="sys_no" id="sys_no" class="input_604w" type="text" maxlength="20"  /></td>
    </tr>
  <tr>
    <td height="120" colspan="2">需求大小<br /><br />
    <input name="order_scope" type="radio" value="1" /><span>大 （90人天以上）</span><br />
    <input name="order_scope" type="radio" value="2" /><span>中（30-90人天以内，包括90人天）</span><br />
    <input name="order_scope" type="radio" value="3" /><span>小 （30人天以下，包括30人天）</span></td>
    </tr>
  <tr>
    <td height="120" colspan="2">OA工单号<br /><br /><input name="oa_no" id="oa_no" class="input_604w" type="text" maxlength="20"  /></td>
    </tr>
  <tr>
    <td width="321" height="120">归属系统<br /><br />
    <select class="input_280w" id="app_sys_id" name="app_sys_id" >
				<option value="">--请选择--</option>
				<option value="1">OA系统</option>
				<option value="2">ERP系统</option>
				<option value="3">监控系统</option>
			</select></td>
    <td width="321" height="120">需求提出人<br /><br /><input name="order_apply_man" id="order_apply_man" class="input_280w" type="text" maxlength="20"  /></td>
  </tr>
  <tr>
    <td height="120" colspan="2">需求部门/单位<br /><br /><input name="order_dept" id="order_dept" class="input_604w" type="text" maxlength="20"  /></td>
    </tr>
  <tr>
    <td width="321" height="120">执行厂商<br /><br />
    <select  name="execute_company" id="execute_company" class="input_280w">
			<option value="0">----请选择----</option>
			<c:forEach items="${company_list }" var="t">
				<option value="${t.id }">${t.company_name }</option>
			</c:forEach>
			</select></td>
    <td width="321" height="120">开发负责人<br /><br /><input name="develop_man" id="develop_man" type="text" class="input_280w" maxlength="20"  /></td>
  </tr>
  	<tr>
    <td height="120" colspan="2">需求描述<br /><br /><input name="order_detail" id="order_detail" class="input_604w" type="text" maxlength="20"  /></td>
    </tr>
   	<tr>
    <td height="120" colspan="2">相关附件<br /><br />
	<input name="" type="button" value="上传"  class="input_5" onclick="upload('','');"/>
	<input name="file_name" type="file" id="file_name" class="input_4"/> 
	<div id="div_file_list">
	</div>
	</td>
	</tr>
  <tr>
    <td height="120" colspan="2" align="center" valign="middle"><input id="btn1" name="btn1" type="image" src="<%=basePath%>images/mobile/images/images/2_03.png" onclick="saveOrder()"/></td>
    </tr>
</table>

      </form>
      
      </div>
      
      </div>
    </div>
  </div>
</div>
<script type="text/javascript">
var TabbedPanels1 = new Spry.Widget.TabbedPanels("TabbedPanels1");
</script>
</body>
</html>
