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
#top2{ width:750px; height:60px; background-color:#282828; margin:0px auto; color:#FFF; font-size:24px; text-align:center; line-height:60px;}
#top2 img{ float:left; }
#top2 span{ padding-right:70px;}
#box2{ width:750px; height:1294px; margin-top:108px; background:url(<%=basePath%>images/mobile/images/images/1_02.png) no-repeat left top; margin:0px auto;}
#input2{ width:604px; height:50px;  border-radius:10px; font-size:30px; color:#000; padding-left:10px;}
#input3{ width:280px; height:50px;  border-radius:10px; font-size:30px; color:#000; padding-left:10px;}
#tab2{ margin:0px auto; color:#FFF;}
#tab2 span{ color:#bfc3c4; font-size:20px;}
#input4{ border-radius:5px; color:#bfc3c4; width:454px; height:34px; background-color:#FFF; padding-top:10px;}
.input_604w{width:604px; height:50px;  border-radius:10px; font-size:30px; color:#000; padding-left:10px;}
#input5{ background-color:a4a9ae; width:140px; height:44px; margin-left:10px;border-radius:5px; font-size:18px;}
.input_280w{width:280px; height:50px;  border-radius:10px; font-size:30px; color:#000; padding-left:10px;}
.input_4{border-radius:5px; color:#bfc3c4; width:454px; height:34px; background-color:#FFF; padding-top:10px;}
.input_5{ background-color:a4a9ae; width:140px; height:44px; margin-left:10px;border-radius:5px; font-size:18px;}
.input_6{ width:100px; height:30px; color:#000; margin-top:45px; font-family:"宋体" }
#td1{ padding-top:10px;}
#input6{ width:100px; height:30px; color:#000; margin-top:45px; font-family:"宋体" }
</style>
<script type="text/javascript" src="<%=basePath%>js/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/ajaxfileupload.js"></script>
<script type="text/javascript" src="<%=basePath%>js/public.js"></script>
<script>
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

//编辑需求
function saveOrder(){
	//Ajax进行交互-收集表单数据
	var jsonObj=$("#myForm").serializeJson();
	var jsonStr=JSON.stringify(jsonObj);
	$.ajax({
			type:"POST",
			contentType: "application/json; charset=utf-8",
			url:"<%=basePath %>sys/update_order_ajax.action",
			async:false,
			data: jsonStr,
			dataType:"json",
			success: function(data){
				if(data.message=="success"){
					
					alert("编辑成功");
					var order_id=data.data.id;
					$("#order_id").attr("value",order_id);
				
				}
				else{
					alert("编辑失败");
				}
			}
		});

}//上传附件
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
<div id="top2"><a href="${pageContext.request.contextPath}/sys/demand2.action?order_id=${order.id }"><img src="<%=basePath%>images/mobile/images/images/gd2_03.png" width="88" height="60" /></a><span>编辑需求</span></div>

     <div id="box2"><form id="myForm" name="myForm" method="get">
      <input type="hidden" id="order_id" name="order_id" value="${order.id }"/>
      <input type="hidden" id="app_type" name="app_type" value="mobile"/>
      <table id="tab2" width="642" height="1200" border="0">
  <tr>
    <td height="120" colspan="2">需求名称<br /><br /><input value="${order.order_name }" name="order_name" id="order_name" class="input_604w" type="text"  maxlength="20"  /></td>
    </tr>
  <tr>
    <td height="120" colspan="2">系统编号<br /><br /><input name="sys_no" id="sys_no" class="input_604w" type="text" maxlength="20"  value="${order.sys_no }" /></td>
    </tr>
  <tr>
    <td height="120" colspan="2">需求大小<br /><br />
    <input name="order_scope" type="radio" value="1" <c:if test='${order.order_scope==1 }'>checked="checked"</c:if>/><span>大 （90人天以上）</span><br />
    <input name="order_scope" type="radio" value="2" <c:if test='${order.order_scope==2 }'>checked="checked"</c:if>/><span>中（30-90人天以内，包括90人天）</span><br />
    <input name="order_scope" type="radio" value="3" <c:if test='${order.order_scope==3 }'>checked="checked"</c:if>/><span>小 （30人天以下，包括30人天）</span></td>
    </tr>
  <tr>
    <td height="120" colspan="2">OA工单号<br /><br /><input name="oa_no" id="oa_no" class="input_604w" type="text" maxlength="20" value="${order.oa_no }" /></td>
    </tr>
  <tr>
    <td width="321" height="120">归属系统<br /><br />
    <select class="input_280w" id="app_sys_id" name="app_sys_id" >
				<option value="">--请选择--</option>
				<option value="1" <c:if test='${order.app_sys_id==1 }'>  selected='selected'  </c:if>>OA系统</option>
				<option value="2" <c:if test='${order.app_sys_id==2 }'>  selected='selected'  </c:if>>ERP系统</option>
				<option value="3" <c:if test='${order.app_sys_id==3 }'>  selected='selected'  </c:if>>监控系统</option>
			</select></td>
    <td width="321" height="120">需求提出人<br /><br /><input value="${order.order_apply_man }" name="order_apply_man" id="order_apply_man" class="input_280w" type="text" maxlength="20"  /></td>
  </tr>
  <tr>
    <td height="120" colspan="2">需求部门/单位<br /><br /><input value="${order.order_dept }" name="order_dept" id="order_dept" class="input_604w" type="text" maxlength="20"  /></td>
    </tr>
  <tr>
    <td width="321" height="120">执行厂商<br /><br />
    <select  name="execute_company" id="execute_company" class="input_280w">
			<option value="0">----请选择----</option>
			<c:forEach items="${company_list }" var="t">
				<option value="${t.id }" <c:if test='${t.id==order.execute_company }'>  selected='selected' </c:if> >${t.company_name }</option>
			</c:forEach>
			</select></td>
    <td width="321" height="120">开发负责人<br /><br /><input value="${order.develop_man }" name="develop_man" id="develop_man" type="text" class="input_280w" maxlength="20"  /></td>
  </tr>
  	<tr>
    <td height="120" colspan="2">需求描述<br /><br /><input value="${order.order_detail }" name="order_detail" id="order_detail" class="input_604w" type="text" maxlength="20"  /></td>
    </tr>
   	<tr>
    <td height="120" colspan="2">相关附件<br /><br />
	<input name="" type="button" value="上传"  class="input_5" onclick="upload('','');"/>
	<input name="file_name" type="file" id="file_name" class="input_4"/> 
	<div id="div_file_list">
	</div>
	<c:forEach items="${attachList }" var="f">
			<a href="${pageContext.request.contextPath}/sys/downloadTest.action?url=${f.url}&server_name=${f.server_name}">${f.attach_name }</a><input name="" type="button" value="删除"  class="btn_gr3 ml10"/><br/>
			</c:forEach>
	</td>
	</tr>
  <tr>
    <td height="120" colspan="2" align="center" valign="middle"><input id="btn1" name="btn1" type="image" src="<%=basePath%>images/mobile/images/images/2_03.png" onclick="saveOrder()"/></td>
    </tr>
</table>


</form></div>
</body>
</html>
