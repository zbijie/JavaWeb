package com.fzy.interceptor;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import com.fzy.common.util.Constants;
import com.fzy.common.util.RightsHelper;
import com.fzy.demo.resource.model.Resource;
import com.fzy.demo.resource.service.IResourceService;
import com.fzy.demo.user.model.UserModel;
import com.google.gson.Gson;

public class RightsHandlerInterceptor extends HandlerInterceptorAdapter{
	Logger logger=Logger.getLogger(RightsHandlerInterceptor.class);
	@Autowired
	IResourceService resourceService;
	@Override
	public boolean preHandle(HttpServletRequest request,HttpServletResponse response, Object handler) throws Exception {
		boolean flag=false;
		String path = request.getServletPath();
		Integer res_id = null;//资源ID
		logger.info(path);
		if(path.matches(Constants.NO_INTERCEPTOR_PATH)){
			return true;
		}
		else{
			//判断用户是否有权限访问 path
			
			//获取所有资源列表
			List<Resource> res_list=resourceService.getAllResource();
			//判断路径
			for (Resource resource : res_list) {
				String url=resource.getUrl();
				if(url!=null&&path!=null&&path.contains(url)){
					res_id=resource.getId();
					break;
				}
			}
			HttpSession session = request.getSession();
			if(res_id!=null){
				//获取session
				UserModel user=(UserModel)session.getAttribute("login_user");
				//获取用户的权限列表
				String rightsJson=(String)session.getAttribute("rightsJson");
				Gson gson=new Gson();
				List<String> rights=new ArrayList<String>();
				rights=gson.fromJson(rightsJson, List.class);
				for (String r : rights) {
					if(RightsHelper.testRights(r, res_id)){
						logger.info("有此权限");
						return true;
					}
				}
				if(!flag){
					logger.info("用户："+user.getLogin_name()+"试图访问"+path+"被阻止！");
					//返回一个视图界面
					ModelAndView mv = new ModelAndView();
					mv.setViewName("no_rights");
					throw new  ModelAndViewDefiningException(mv);
					
				}
			}
			else{
				logger.info("无此资源");
			}
		}
		 return super.preHandle(request, response, handler);
	}
}
