package com.fzy.demo.confirm.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fzy.demo.analyse.mapper.IAnalyseMapper;
import com.fzy.demo.confirm.mapper.IConfirmMapper;
@Service
public class ConfirmService implements IConfirmService {
	@Autowired
	IConfirmMapper confirmMapper ;
	
	@Override
	public Map<String, Object> findOrderConfirmByOrderId(
			Map<String, Object> parm) {
		// TODO Auto-generated method stub
		return confirmMapper.findOrderConfirmByOrderId(parm);
	}
	@Override
	public void saveConfirm(Map<String, Object> parm) {
		confirmMapper.saveConfirm(parm);
		
	}

}
