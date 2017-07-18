package com.fzy.demo.audit.service;


import java.util.List;
import java.util.Map;

public interface IAuditService {
	public void saveAudit(Map<String,Object> parm);
	public List<Map<String, Object>> findAuditListByOrderId(Map<String,Object> parm);
}
