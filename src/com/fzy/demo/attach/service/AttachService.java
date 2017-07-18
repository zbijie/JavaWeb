package com.fzy.demo.attach.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fzy.demo.attach.mapper.IAttachMapper;
@Service
public class AttachService implements IAttachService {
	@Autowired
	IAttachMapper attachMapper;
	@Override
	public void addAttach(Map<String, Object> parm) {
		attachMapper.addAttach(parm);
	}

	@Override
	public int addOrderAttach(Map<String, Object> parm) {
		int r= attachMapper.addOrderAttach(parm);
		System.out.println("aa------------>"+r);
		System.out.println("bb------------>"+parm.get("id"));
		return r;
	}

	@Override
	public List<Map<String, Object>> findOrderAttachList(
			Map<String, Object> parm) {
		return attachMapper.findOrderAttachList(parm);
	}

	@Override
	public void updateOrderAttach(Map<String, Object> parm) {
		 attachMapper.updateOrderAttach(parm);
		
	}
	public void updateAttach(Map<String, Object> parm) {
		 attachMapper.updateAttach(parm);
		
	}

}
