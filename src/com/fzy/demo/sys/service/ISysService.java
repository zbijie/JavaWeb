package com.fzy.demo.sys.service;

import java.util.List;
import java.util.Map;

public interface ISysService {
	public List<Map<String,Object>> findAllOrder(Map<String,Object> parm);
	/**
	 * 添加工单
	 */
	public void addOrder(Map<String,Object> parm);
	
	/**
	 * 根据ID查询工单
	 * @param parm
	 * @return
	 */
	public Map<String,Object> findOrderById(Map<String,Object> parm);
	/**
	 * 修改工单
	 */
	public void updateOrder(Map<String,Object> parm);
	/**
	 * 删除一条需求
	 */
	public void deleteOrder(Map<String,Object> parm);
}
