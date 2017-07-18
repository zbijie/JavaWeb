<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>  
<html lang="en">  
<head>  
    <meta charset="UTF-8">  
    <title>Login</title>  
    <script src="<%=basePath%>js/jquery.min.1.8.1.js" type="text/javascript"></script>
<script src="<%=basePath%>js/json.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="css/login.css"/> 
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
	
	function login(){
		//收集表单数据
		var jsonObj=$("#myForm").serializeJson();
		var jsonStr=JSON.stringify(jsonObj); 
		
		$.ajax({
				type:"POST",
				contentType: "application/json; charset=utf-8",
				url:"<%=basePath %>user/checkLogin.action",
				async:false,
				data: jsonStr,
				dataType:"json",
				success: function(data){
					if(data.message=="success"){
						//跳转系统主页。客户端跳转 可以采用 window.location.href
						//一般来说MVC的模式 很少直接访问页面。更多的是访问 控制器代码Controller
						//所以我们要建立工单的Controller
						 window.location.href="<%=basePath %>sys/main.action";
					}
					else{
						alert("登陆失败");
					}
				}
			});
		
		
	}
</script> 
</head>  
<body>  
    <div id="login">  
        <h1>Login</h1>  
        <form method="post" id="myForm">  
            <input type="text" required="required" placeholder="用户名" id="login_name" name="login_name"></input>  
            <input type="password" required="required" placeholder="密码" id="login_password" name="login_password"></input>  
            <button class="but" type="button" onclick="login()">登录</button>  
        </form>  
    </div>  
</body>  
</html>