package com.fzy.demo.role.mapper;

import java.util.*;

public interface IRoleMapper {
	/**
	 * 根据角色ID获取 角色下的用户列表
	 * @param id
	 * @return
	 */
	public List<Map<String,Object>> getUserListByRoleId(String id);
	/**
	 * 根据角色列表
	 * @param id
	 * @return
	 */
	public List<Map<String,Object>> getRoleList();
}
