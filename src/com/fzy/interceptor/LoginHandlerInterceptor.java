package com.fzy.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.fzy.common.util.Constants;
import com.fzy.demo.user.model.UserModel;


public class LoginHandlerInterceptor  extends HandlerInterceptorAdapter{
	Logger logger=Logger.getLogger(LoginHandlerInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request,HttpServletResponse response, Object handler) throws Exception {
		String path = request.getServletPath();
		if(path.matches(Constants.NO_LOGIN_INTERCEPTOR_PATH)){
			return true;
		}
		else{
			HttpSession session = request.getSession();
			UserModel user=(UserModel)session.getAttribute("login_user");
			if(user!=null){
				return true;
			}
			else{
				response.sendRedirect(request.getContextPath()+"/login.jsp");
				return false;
			}
			
		}
		
	}
}
