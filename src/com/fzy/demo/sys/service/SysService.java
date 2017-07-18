package com.fzy.demo.sys.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fzy.demo.sys.mapper.ISysMapper;
@Service
public class SysService implements ISysService {
	@Autowired
	ISysMapper sysMapper;
	@Override
	public List<Map<String, Object>> findAllOrder(Map<String, Object> parm) {
		return sysMapper.findAllOrder(parm);
	}
	/**
	 * 添加工单
	 */
	public void addOrder(Map<String,Object> parm){
		 sysMapper.addOrder(parm);
	}
	/**
	 * 根据ID查询工单
	 * @param parm
	 * @return
	 */
	public Map<String,Object> findOrderById(Map<String,Object> parm){
		return sysMapper.findOrderById(parm);
	}
	/**
	 * 修改工单
	 */
	public void updateOrder(Map<String,Object> parm){
		 sysMapper.updateOrder(parm);
	}
	/**
	 * 删除工单
	 */
	public void deleteOrder(Map<String,Object> parm) {
		 sysMapper.deleteOrder(parm);
		
	}

}
