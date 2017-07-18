<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title></title>


<style>
*{ margin:0px; border:0px solid red; padding:0px;}
#box{ width:750px; height:1334px; background:url(<%=basePath%>images/mobile/images/images/bg.png) top left; margin-left:auto; margin-right:auto; }
#top{ width:406px; height:257px;  margin:0px auto; padding-top:259px; text-align:center; background:url(<%=basePath%>images/mobile/images/images/touxian_03_03.png) no-repeat center 259px;}
#top2{ width:139px; height:46px; background:url(<%=basePath%>images/mobile/images/images/row_03.png)no-repeat center top; margin:136px auto; }
#input1{ width:185px; height:15px; border-bottom:1px solid #FFF; padding-bottom:5px; color:#FFF; font-size:14px;margin-top:5px; margin-left:190px;}
#input1 input{ background-color:transparent; border:0px; padding-left:2px; color:#FFF; }
#txt{  font-size:14px; width:250px; height:15px; float:right; margin-top:-45px;}
#txt2{ color:#FFF; font-size:14px; width:250px; height:15px; float:right; margin-top:-18px;}
#txt a,#txt2 a{ color:#FFF; text-decoration:none;}
#txt a:hover,#txt2 a:hover{ color:#3cbefa;}
#main{ height:278px;}

#bottom{ width:750px; height:222px; maring:px auto; background:url(images/images/5_02.png) no-repeat center top;}
button {
  margin: 30px 20px;
  padding: 15px 20px;
  border-radius: 10px;
  border: 2px solid;
  width:150px;
  font: 16px 'Microsoft yahei', sans-serif;
  text-transform: uppercase;
  background: none;
  outline: none;
  cursor: pointer;
  -webkit-transition: all .5s;
  transition: all .5s;
}

.btn-2 {
  color: #fff;
  border-color: #62c1f8;
  background: -webkit-linear-gradient(left, #e4f68f, #e4f68f) no-repeat;
  background: linear-gradient(to right, #62c1f8, #62c1f8) no-repeat;
  background-size: 100% 0%;
  position:relative;
  left:290px;
  top:30px;
}
.btn-2:hover {
  background-size: 100% 100%;
  color: #27323A;
}
#a1{ display:block; width:88px; height:88px; float:left; margin-left:150px; margin-top:100px; background:url(<%=basePath%>images/mobile/images/images/images/1.png) no-repeat center top; }
#a2{ display:block; width:88px; height:88px; float:left;margin-top:100px;margin-left:100px;background:url(<%=basePath%>images/mobile/images/images/images/2.png) no-repeat center top;}
#a3{ display:block; width:88px; height:88px; float:left;margin-top:100px;margin-left:100px;background:url(<%=basePath%>images/mobile/images/images/images/3.png) no-repeat center top;}
#a1:hover{ background:url(<%=basePath%>images/mobile/images/images/images/4.png) no-repeat left top;}
#a2:hover{ background:url(<%=basePath%>images/mobile/images/images/images/5.png) no-repeat left top;}
#a3:hover{ background:url(<%=basePath%>images/mobile/images/images/images/6.png) no-repeat left top;}
</style>


<script src="<%=basePath%>js/jquery.min.1.8.1.js" type="text/javascript"></script>
<script src="<%=basePath%>js/json.js" type="text/javascript"></script>
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
						 window.location.href="<%=basePath %>sys/main.action?app_type=mobile";
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
<div id="box">
<div id="top">
</div>
<div id="top2"></div>
<div id="main">

<form id="myForm" action="index.html" method="get">
<div id="input1">
帐号:<input id="login_name" name="login_name" type="text" value="" maxlength="8" /><br /></div>
<div id="input1">
密码:<input id="login_password" name="login_password" type="password" value="" maxlength="8" /></div>
<div id="txt"><a href="#">忘记密码</a></div>
<div id="txt2"><a href="#">立即注册</a></div>

	<button class="btn-2" type="button" onclick="login()">登 录</button>
</form>

</div>

<div id="bottom"><a id="a1" href="#">
	</a>
    <a id="a2" href="#">
	</a>
    <a id="a3" href="#">
	 </a>
</div>
</div>
</body>
</html>

