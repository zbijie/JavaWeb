package com.fzy.demo.company.mapper;

import java.util.List;
import java.util.Map;

public interface ICompanyMapper {
	/**
	 * 查询厂商列表
	 * @return
	 */
	public List<Map<String,Object>> findCompanyList(Map<String,Object> parm);
}
