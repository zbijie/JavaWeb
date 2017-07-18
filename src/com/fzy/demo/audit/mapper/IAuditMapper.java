package com.fzy.demo.audit.mapper;

import java.util.List;
import java.util.Map;

public interface IAuditMapper {
	//保存审核
	public void saveAudit(Map<String,Object> parm);
	//根据工单ID查询审核意见列表
	public List<Map<String, Object>> findAuditListByOrderId(Map<String,Object> parm);

}
