package com.fzy.demo.analyse.mapper;

import java.util.Map;

public interface IAnalyseMapper {
	/**
	 * 根据ID查询需求分析
	 * @param parm
	 * @return
	 */
	public Map<String,Object> findOrderAnalyseByOrderId(Map<String,Object> parm);
	
	
	/**
	 * 保存需求分析
	 */
	public void saveAnalyse(Map<String,Object> parm);
}
