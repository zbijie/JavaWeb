/* 弹出层*/
var useDispAll=0;
function show(cover,id,useDisp){	
	var Sys = {};
	var ua = navigator.userAgent.toLowerCase();
	var s;      
	(s = ua.match(/msie ([\d.]+)/)) ? Sys.ie = s[1] : 
	(s = ua.match(/chrome\/([\d.]+)/)) ? Sys.chrome = s[1] :
	(s = ua.match(/version\/([\d.]+).*safari/)) ? Sys.safari = s[1] : 0;		
	//如果是ie6，隐藏页面select
	if(Sys.ie=="6.0"){
		var n=document.getElementsByTagName("select").length;
		var m=document.getElementById(id).getElementsByTagName("select").length;
		for(var i=0;i<n;i++){
			document.getElementsByTagName("select")[i].style.display='none';}
		for(var j=0;j<m;j++){		
			document.getElementById(id).getElementsByTagName("select")[j].style.display='';}
	}	
	var objCover=document.getElementById(cover);
	var objId=document.getElementById(id);
	var scrollW=document.documentElement.scrollWidth;
	var scrollH=document.documentElement.scrollHeight;
	objId.style.display="";
	if (Sys.safari || Sys.chrome){
		var scrollH=document.body.scrollHeight;
		if(document.documentElement.clientHeight<objId.clientHeight){
			var T=document.body.scrollTop;
		}else{
			var T=(document.documentElement.clientHeight-objId.clientHeight)/2+document.body.scrollTop;
		}
	}else{
		if(document.documentElement.clientHeight<objId.clientHeight){
			var T=document.documentElement.scrollTop;
		}else{
			var T=(document.documentElement.clientHeight-objId.clientHeight)/2+document.documentElement.scrollTop;
		}
	}
	var L=(document.documentElement.clientWidth-objId.clientWidth)/2+document.documentElement.scrollLeft;	
	
	objCover.style.width=scrollW+"px";
	objCover.style.height=scrollH+"px";
	objCover.style.visibility="visible";
	objId.style.top=T+"px";
	objId.style.left=L+"px";
	objId.style.visibility="visible";
	useDispAll=useDisp;
	//if(useDisp==1){
		
	//}
		
	window.onresize=function (){	
		var objCover=document.getElementById(cover);
		var objId=document.getElementById(id);
		var scrollW=document.documentElement.scrollWidth;
		if(document.documentElement.clientHeight >= document.documentElement.scrollHeight){
			var scrollH=document.documentElement.clientHeight;	
		}else{
			var scrollH=document.documentElement.scrollHeight;}
		if (Sys.safari || Sys.chrome) {
			if(document.documentElement.clientHeight<objId.clientHeight){
				var T=document.body.scrollTop;
			}else{
				var T=(document.documentElement.clientHeight-objId.clientHeight)/2+document.body.scrollTop;
			}
		}else{
			if(document.documentElement.clientHeight<objId.clientHeight){
				var T=document.documentElement.scrollTop;
			}else{
				var T=(document.documentElement.clientHeight-objId.clientHeight)/2+document.documentElement.scrollTop;
			}
		}
		var L=(document.documentElement.clientWidth-objId.clientWidth)/2+document.documentElement.scrollLeft;		
		objCover.style.width=scrollW+"px";
		objCover.style.height=scrollH+"px";
		objId.style.top=T+"px";
		objId.style.left=L+"px";
	}
}
function hide(cover,id){
	//将页面全部select换件设为可用状态
	var Sys = {};
	var ua = navigator.userAgent.toLowerCase();
	var s;    
	(s = ua.match(/msie ([\d.]+)/)) ? Sys.ie = s[1] : 
	(s = ua.match(/version\/([\d.]+).*safari/)) ? Sys.safari = s[1] : 0;	
	if(Sys.ie=="6.0"){
		var n=document.getElementsByTagName("select").length;
		for(var i=0;i<n;i++){
			document.getElementsByTagName("select")[i].style.display= '';
		}
	}
	var objCover=document.getElementById(cover);
	var objId=document.getElementById(id);
	objCover.style.visibility="hidden";
	objId.style.visibility="hidden";
	//if(useDispAll==1){
		objId.style.display="none";
	//}
}
/*弹出层内容切换*/

//预警信息js
jQuery(function(){
			if (!$('#slidePic')[0]) 
			return;
			var i = 0, p = $('#slidePic ul'), pList = $('#slidePic ul li'), len = pList.length;
			var elePrev = $('#prev'), eleNext = $('#next');
			//var firstClick = false;
			var w = 60, num = 4;
			p.css('width',w*len);
			if (len <= num) 
			eleNext.addClass('gray');
			function prev(){
			if (elePrev.hasClass('gray')) {
			//alert('已经是第一张了');
			return;
			}
			p.animate({
			marginTop:-(--i) * w
			},500);
			if (i < len - num) {
			eleNext.removeClass('gray');
			}
			if (i == 0) {
			elePrev.addClass('gray');
			}
			}
			function next(){
			if (eleNext.hasClass('gray')) {
			//alert('已经是最后一张了');
			return;
			}
			//p.css('margin-left',-(++i) * w);
			p.animate({
			marginTop:-(++i) * w
			},500);
			if (i != 0) {
			elePrev.removeClass('gray');
			}
			if (i == len - num) {
			eleNext.addClass('gray');
			}
			}
			elePrev.bind('click',prev);
			eleNext.bind('click',next);
			pList.each(function(n,v){
			$(this).click(function(){
			if(n-i == 2){
			next();
			}
			if(n-i == 0){
			prev()
			}
			$('#slidePic ul li.cur').removeClass('cur');
			$(this).addClass('cur');
			show(n);
			}).mouseover(function(){
			$(this).addClass('hover');
			}).mouseout(function(){
			$(this).removeClass('hover');
			})
			});
			
			});
			
//选项卡用js
function nTabs(thisObj,Num,active,normal){
	if(thisObj.className == active)return;
	var tabObj = thisObj.parentNode.id;
	var tabList = document.getElementById(tabObj).getElementsByTagName("li");
	for(i=0; i <tabList.length; i++)
	{
		if (i == Num)
		{
		   thisObj.className = active;
		   document.getElementById(tabObj+"_Content"+i).style.display = "block";
		}else{
		   tabList[i].className = normal;
		   document.getElementById(tabObj+"_Content"+i).style.display = "none";
		   
		}
	}
}


//统计表
var n=0;
var showNum = document.getElementById("num");
function Mea(value){
	n=value;
	setBg(value);
	plays(value);
	}
function setBg(value){
	for(var i=0;i<4;i++){
	   if(value==i){
	     document.getElementById("a"+value).className='act';      
			}	else{	
			 document.getElementById("a"+i).className='nor';
			}  
	} 
}
function plays(value){ 
		 for(i=0;i<4;i++){
			  if(i==value){			  
			  	document.getElementById("pc_"+value).style.display="block";
			  	//alert(document.getElementById("pc_"+value).style.display)
			  }else{
			    document.getElementById("pc_"+i).style.display="none";			    
			  }			
		}	
}


function clearAuto(){clearInterval(autoStart)}
function setAuto(){autoStart=setInterval("auto(n)", 3000)}
function auto(){
	n++;
	if(n>3)n=0;
	Mea(n);
} 
function sub(){
	n--;
	if(n<0)n=3;
	Mea(n);
} 
setAuto(); 

//个人工作台左边背景替换
$(".gr_left").on("click","li",function(){
			if(!$(this).hasClass("on")){
				$(".gr_left li").removeClass("on");
				$(this).addClass("on");
			}
		});
	
$(".ssjk").on("click",function(){
	$(".tjfx").hide();
	$("#ssjk").show();
	});		
	
	


$("#gr_tab").on("click",".dskg",function(){

 	 var k=$('.xmzt',$(this).parents("td").parents("tr")).text();
	 switch(k){
		case '新建需求':
			$(".btn_none").hide();
			$(".xxq_btn").show();
			break;
		case '需求分析':
			$(".btn_none").hide();
			$(".xqfx_btn").show();
			break;
		case '需求确认':
			$(".btn_none").hide();
			$(".xqqr_btn").show();
			break;
		case '需求待审核':
			$(".btn_none").hide();
			$(".xqdsh_btn").show();
			break;
		case '执行开发':
			$(".btn_none").hide();
			$(".zxkf_btn").show();
			break;
		case '需求验收':
			$(".btn_none").hide();
			$(".xqys_btn").show();
			break;
		case '上线申请':
			$(".btn_none").hide();
			$(".sxsq_btn").show();
			break;
		case '上线审批':
			$(".btn_none").hide();
			$(".sxsp_btn").show();
			break;
		case '上线割接':
			$(".btn_none").hide();
			$(".sxgj_btn").show();
			break;
		case '后评估':
			$(".btn_none").hide();
			$(".hpg_btn").show();
			break;
		case '终止待审核':
			$(".btn_none").hide();
			$(".zzdsh_btn").show();
			break;
	}
});

$(".rgzj_btn").on("click",function(){
	$(".rgzj").show();
	$(".sjzj").hide();
	});	
$(".sjzj_btn").on("click",function(){
	$(".rgzj").hide();
	$(".sjzj").show();
	});	