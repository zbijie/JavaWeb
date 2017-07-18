package com.fzy.demo.user.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fzy.common.util.Constants;
import com.fzy.common.util.ExtJSReturn;
import com.fzy.demo.user.model.UserModel;
import com.fzy.demo.user.service.IUserService;

@Controller
@RequestMapping(value = "/user/*")
public class UserController {
	@Autowired
	private IUserService userService;
	/**
	 * 获取所有用户
	 * 返回JSON串 到页面
	 */
	@RequestMapping(value = "findAllUser.action" )
	public @ResponseBody
	Map<String, Object> findAllUser(HttpServletRequest request){
		try {
			List<UserModel> list=userService.findAllUser();
			return ExtJSReturn.mapOK(list, "获取信息成功");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return ExtJSReturn.mapError("获取信息失败");
		}
	}
	/**
	 * 用户登录
	 * @param userModel
	 * @param httpSession
	 * @return
	 */
	@RequestMapping(value = "checkLogin.action",produces = "application/json",method = {RequestMethod.POST } )
	public @ResponseBody
	Map<String, Object> checkLogin(@RequestBody UserModel userModel,HttpSession httpSession){
		try {
			Map user=userService.checkLogin(userModel);
			if(user==null){
				return ExtJSReturn.mapOK(user, "fails");
			}
			else{
				//登陆成功，用户信息保存至session
				httpSession.setAttribute("login_user", userModel);
				List<Map<String,Object>> rights_list=userService.getRightsListByUserID(String.valueOf(user.get("id")));
				StringBuffer rightsJson=new StringBuffer("[");
				for (Map<String, Object> map : rights_list) {
					rightsJson.append("\""+map.get("rights")+"\",");
				}
				rightsJson.deleteCharAt(rightsJson.lastIndexOf(","));
				rightsJson.append("]");
				httpSession.setAttribute("rightsJson", rightsJson.toString());//权限列表
				Map<String,Object> parm=new HashMap<String, Object>();
				parm.put("login_name", userModel.getLogin_name());
				List<Map<String,Object>> roleList =userService.getUserRoleListByLoginName(parm);
				//登陆成功，角色列表信息保存至session
				httpSession.setAttribute("roleList", roleList);
				//是否拥有角色
				for (Map<String, Object> map : roleList) {
					String role_id=map.get("role_id").toString();
					if(role_id.equals(Constants.DEMAND_DRAFT_MAN)){
						httpSession.setAttribute("is_demand_draft_man", "1");
					}
					if(role_id.equals(Constants.DEVELOP_MAN)){
						httpSession.setAttribute("is_develop_man", "1");
					}
					if(role_id.equals(Constants.CAMPANY_MANAGER)){
						httpSession.setAttribute("is_campany_manager", "1");
					}
					if(role_id.equals(Constants.DEMAND_ADMIN_MAN)){
						httpSession.setAttribute("is_demand_admin_man", "1");
					}
				}
				
				return ExtJSReturn.mapOK(user, "success");
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return ExtJSReturn.mapError("获取信息失败");
		}
	}
	
	/**
	 * 用户登出
	 * @param userModel
	 * @param httpSession
	 * @return
	 */
	@RequestMapping(value = "logout.action" )
	public String logout(HttpSession httpSession){
		httpSession.removeAttribute("login_user");
		httpSession.removeAttribute("rightsJson");
		httpSession.removeAttribute("is_demand_draft_man");
		httpSession.removeAttribute("is_develop_man");
		httpSession.removeAttribute("is_campany_manager");
		httpSession.removeAttribute("is_demand_admin_man");
		return "login";
	}

}
