package com.fzy.demo.user.service;

import java.util.List;
import java.util.Map;

import com.fzy.demo.user.model.UserModel;


public interface IUserService {
	public List<UserModel> findAllUser() throws Exception;

	public Map checkLogin(UserModel userModel);
	/**
	 * 查询用户角色列表
	 * parm:查询条件
	 */
	public List<Map<String,Object>> getUserRoleListByLoginName(Map<String,Object> parm);
	
	/**
	 * 新定义： 查询用户所拥有的权限列表
	 */
	public List<Map<String,Object>> getRightsListByUserID(String id);

}
