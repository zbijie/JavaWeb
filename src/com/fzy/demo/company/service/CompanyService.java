package com.fzy.demo.company.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fzy.demo.company.mapper.ICompanyMapper;
@Service
public class CompanyService implements ICompanyService{
	@Autowired
	ICompanyMapper companyMapper;
	
	@Override
	public List<Map<String, Object>> findCompanyList(Map<String, Object> parm) {
		// TODO Auto-generated method stub
		return companyMapper.findCompanyList(parm);
	}

}
