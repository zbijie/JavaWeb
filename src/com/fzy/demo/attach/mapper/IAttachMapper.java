package com.fzy.demo.attach.mapper;

import java.util.List;
import java.util.Map;

public interface IAttachMapper {
	/**
	 * 添加附件
	 */
	public void addAttach(Map<String,Object> parm);
	
	/**
	 * 添加工单-附件
	 */
	public int addOrderAttach(Map<String,Object> parm);
	
	/**
	 * 查询工单附件列表
	 * @return
	 */
	public List<Map<String,Object>> findOrderAttachList(Map<String,Object> parm);
	
	/**
	 * 修改工单附件
	 */
	public void updateOrderAttach(Map<String,Object> parm);
	/**
	 * 修改附件
	 */
	public void updateAttach(Map<String, Object> parm) ;
}
