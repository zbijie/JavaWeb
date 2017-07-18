package com.fzy.demo.analyse.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fzy.demo.analyse.mapper.IAnalyseMapper;
@Service
public class AnalyseService implements IAnalyseService {
	@Autowired
	IAnalyseMapper analyseMapper;
	@Override
	public Map<String, Object> findOrderAnalyseByOrderId(Map<String, Object> parm) {
		// TODO Auto-generated method stub
		return analyseMapper.findOrderAnalyseByOrderId(parm);
	}
	/**
	 * 保存需求分析
	 */
	public void saveAnalyse(Map<String,Object> parm){
		analyseMapper.saveAnalyse(parm);
		
	}

}
