package com.fzy.demo.company.service;

import java.util.List;
import java.util.Map;

public interface ICompanyService {
	/**
	 * 查询厂商列表
	 * @return
	 */
	public List<Map<String,Object>> findCompanyList(Map<String,Object> parm);
}
