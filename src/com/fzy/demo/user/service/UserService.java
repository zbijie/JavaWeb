package com.fzy.demo.user.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fzy.demo.user.mapper.IUserMapper;
import com.fzy.demo.user.model.UserModel;

@Service
public class UserService implements IUserService{
	@Autowired
	private IUserMapper userMapper;
	
	@Override
	public List<UserModel> findAllUser() throws Exception {
		return userMapper.findAllUser(null);
	}

	@Override
	public Map checkLogin(UserModel userModel) {
		return userMapper.checkLogin(userModel);
	}
	/**
	 * 查询用户角色列表
	 * parm:查询条件
	 */
	public List<Map<String,Object>> getUserRoleListByLoginName(Map<String,Object> parm){
		return userMapper.getUserRoleListByLoginName(parm);
	}

	@Override
	public List<Map<String, Object>> getRightsListByUserID(String id) {
		// TODO Auto-generated method stub
		return userMapper.getRightsListByUserID(id);
	}

}
