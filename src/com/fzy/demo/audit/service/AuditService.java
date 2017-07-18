package com.fzy.demo.audit.service;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fzy.demo.audit.mapper.IAuditMapper;
@Service
public class AuditService implements IAuditService {
	@Autowired
	IAuditMapper auditMapper;
	@Override
	public void saveAudit(Map<String, Object> parm) {
		auditMapper.saveAudit(parm);

	}
	@Override
	public List<Map<String, Object>> findAuditListByOrderId(Map<String, Object> parm) {
		return auditMapper.findAuditListByOrderId(parm);
	}

}
