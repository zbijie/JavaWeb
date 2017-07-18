package com.fzy.demo.audit.controller;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fzy.common.util.Constants;
import com.fzy.common.util.ExtJSReturn;
import com.fzy.common.util.RandomGUID;
import com.fzy.demo.analyse.service.IAnalyseService;
import com.fzy.demo.attach.service.IAttachService;
import com.fzy.demo.audit.service.IAuditService;
import com.fzy.demo.confirm.service.IConfirmService;
import com.fzy.demo.sys.service.ISysService;
import com.fzy.demo.user.model.UserModel;

@Controller
@RequestMapping(value = "/audit/*")
public class AuditController {
	@Autowired
	IAuditService auditService;
	@Autowired
	private ISysService sysService;
	@Autowired
	private IAttachService attachService;
	@Autowired
	private IAnalyseService analyseService;
	@Autowired
	private IConfirmService confirmService;
	
	@RequestMapping(value = "to_audit.action", produces = "application/json")
	public String toAudit(@RequestParam String order_id,HttpServletRequest request, HttpSession httpSession){
		//获取工单详细信息
		Map<String, Object> parm=new HashMap<String, Object>();
		parm.put("id", order_id);
		Map<String, Object> order= sysService.findOrderById(parm);
		request.setAttribute("order", order);
		//获取工单的附件列表
		Map<String, Object> parm2=new HashMap<String, Object>();
		parm2.put("id", order_id);
		parm2.put("order_status", "0");//新建需求-但未提交
		List<Map<String, Object>> orderAttachList=attachService.findOrderAttachList(parm2);
		request.setAttribute("orderAttachList", orderAttachList);
		//获取需求分析信息
		Map<String, Object> parm3=new HashMap<String, Object>();
		parm3.put("order_id", order_id);
		Map<String ,Object> analyse=analyseService.findOrderAnalyseByOrderId(parm3);
		request.setAttribute("analyse", analyse);
		//获取需求分析的附件
		Map<String, Object> parm4=new HashMap<String, Object>();
		parm4.put("id", order_id);
		parm4.put("order_status", "1");//需求分析状态
		List<Map<String, Object>> analyse_attach_list=attachService.findOrderAttachList(parm4);
		request.setAttribute("analyse_attach_list", analyse_attach_list);
		//获取需求确认信息
		Map<String, Object> parm5=new HashMap<String, Object>();
		parm5.put("order_id", order_id);
		Map<String ,Object> confirm=confirmService.findOrderConfirmByOrderId(parm5);
		request.setAttribute("confirm", confirm);
		//获取需求确认信息的附件
		Map<String, Object> parm6=new HashMap<String, Object>();
		parm6.put("id", order_id);
		parm6.put("order_status", "2");//需求分析状态
		List<Map<String, Object>> confirm_attach_list=attachService.findOrderAttachList(parm6);
		request.setAttribute("confirm_attach_list", confirm_attach_list);
		return "order_audit";
	}
	/**
	 * 提交审核意见
	 * @param file
	 * @param request
	 * @param response
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping(value = "save_audit_ajax.action",produces = "application/json")
	@ResponseBody
	 public Map<String, Object> saveAudit(@RequestBody Map<String,Object> parm,HttpSession httpSession){
		UserModel login_user=(UserModel)httpSession.getAttribute("login_user");
		parm.put("audit_man", login_user.getLogin_name());
		RandomGUID myGUID = new RandomGUID();
		String id=myGUID.valueAfterMD5;
		parm.put("id", id);
		auditService.saveAudit(parm);
		//根据审核条件，改变工单状态
		Map<String,Object> parm2=new HashMap<String, Object>();
		String order_id=parm.get("order_id").toString();
		parm2.put("id", order_id);
		if(parm.get("audit_status").toString().equals("1")){
			parm2.put("status", Constants.ORDER_DEVELOP);
		}
		else if(parm.get("audit_status").toString().equals("0")){
			parm2.put("status", Constants.ORDER_CONFIRM);
		}
		sysService.updateOrder(parm2);
		return ExtJSReturn.mapOK("", "success");
	}
	/**
	 * 查看审核意见
	 * @param order_id 工单ID
	 * @param request
	 * @param httpSession
	 * @return
	 */
	@RequestMapping(value = "view_audit.action", produces = "application/json")
	public String viewAudit(@RequestParam String order_id,HttpServletRequest request, HttpSession httpSession){
		//获取审核意见列表
		Map<String,Object> parm=new HashMap<String, Object>();
		parm.put("order_id", order_id);
		List<Map<String, Object>> auditList=auditService.findAuditListByOrderId(parm);
		request.setAttribute("audit_list", auditList);
		return "view_audit";
	}
	/**
	 * //判断是否已经填写需求审核
	 * @param parm
	 * @param request
	 * @param httpSession
	 * @return
	 */
	@RequestMapping(value = "check_audit.action", produces = "application/json")
	public @ResponseBody 
	Map<String, Object> checkAuditAjax(@RequestBody Map<String,Object> parm,HttpServletRequest request, HttpSession httpSession) {
		List<Map<String, Object>> map = auditService.findAuditListByOrderId(parm);
		String flag="0";
		if(map!=null){
			flag="1";
		}
		else{
			flag="0";
		}
		Map<String, Object> rmap=ExtJSReturn.mapOK(flag, "success");
		return rmap;
	}
}
