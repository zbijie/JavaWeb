package com.fzy.demo.user.mapper;

import java.util.List;
import java.util.Map;

import com.fzy.common.util.BaseMapper;
import com.fzy.demo.user.model.UserModel;

public interface IUserMapper extends BaseMapper<UserModel>{
	/**
	 * 查询所有用户
	 * parm:查询条件
	 */
	public List<UserModel> findAllUser(Map<String,Object> map);

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
