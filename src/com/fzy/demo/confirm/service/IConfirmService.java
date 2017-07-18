package com.fzy.demo.confirm.service;

import java.util.Map;

public interface IConfirmService {
	/**
	 * 根据ID查询需求确认
	 * @param parm
	 * @return
	 */
	public Map<String,Object> findOrderConfirmByOrderId(Map<String,Object> parm);
	/**
	 * 保存需求确认
	 */
	public void saveConfirm(Map<String,Object> parm);

}
