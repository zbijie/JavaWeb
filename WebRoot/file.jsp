<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'file.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script type="text/javascript" src="<%=basePath%>js/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/ajaxfileupload.js"></script>
<script type="text/javascript">
//上传附件
	function upload(){
		jQuery.ajaxFileUpload({
			url : '<%=basePath%>sys/fileUpload.action',
			secureuri:false,
	        fileElementId:'file_name',                        //文件选择框的id属性
	        dataType: 'text',             
			error: function (e){
			 	console.log(e); 		
				alert('上传的文件出错!');
				return;
			},
			success:function(data,status) {
				if('success'==data){
					alert("上传成功");
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
</script>
  </head>
  
  <body>
    <p>附件上传：单个文件大小在5M内，文件格式支持（doc,xls,ppt,docx,xlsx,pptx,txt,jpg,bmp,gif,png,chm,pdf,mp3,rar,zip）</p>
						<div class="file_box uploadList">
							<div class="upload"><input name="file_name" type="file" id="file_name"/> 
							<input name="" type="button" value=" 上传 " onclick="upload();"/>
							<c:forEach items="${fileList }" var="file">
							<p class="blue" id="${file.file_id }">
							<a href="${pageContext.request.contextPath}/${file.file_path }" class="blue delet"> ${file.file_name }</a> 
							<a href="#" class="blue delet" onclick="deleteFile('${file.file_id }');">删除</a>
							</p>
							</c:forEach>
							</div>
						</div>
  </body>
</html>
