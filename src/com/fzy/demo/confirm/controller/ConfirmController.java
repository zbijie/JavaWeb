package com.fzy.demo.confirm.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.fzy.common.util.Constants;
import com.fzy.common.util.ExtJSReturn;
import com.fzy.common.util.RandomGUID;
import com.fzy.demo.analyse.service.IAnalyseService;
import com.fzy.demo.attach.service.IAttachService;
import com.fzy.demo.confirm.service.IConfirmService;
import com.fzy.demo.sys.service.ISysService;

@Controller
@RequestMapping(value = "/confirm/*")
public class ConfirmController {
	@Autowired
	private IConfirmService confirmService;
	@Autowired
	private ISysService sysService;
	@Autowired
	private IAnalyseService analyseService;
	@Autowired
	private IAttachService attachService;
	@RequestMapping(value = "to_add_order_confirm.action", produces = "application/json")
	public String toAddOrderConfirm(@RequestParam String order_id,HttpServletRequest request, HttpSession httpSession){
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
		return "add_order_confirm";
	}
	/**
	 * 提交需求确认
	 * @param file
	 * @param request
	 * @param response
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping(value = "saveConfirm.action",produces = "text/html")
	@ResponseBody
	public String saveConfirm(
			MultipartHttpServletRequest multipartRequest,
			HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		String result="";
		String order_id=request.getParameter("order_id");
		
		System.out.println("begin upload confirm....");
		int i=0;
		for (Iterator it = multipartRequest.getFileNames(); it.hasNext();) {
			RandomGUID myGUID = new RandomGUID();
			String key = (String) it.next(); 
			System.out.println(key);
			 MultipartFile file = multipartRequest.getFile(key);
			// 获取保存的路径，
			String url="/upload/order/"+order_id+"/order_confirm/";
			String realPath = request.getSession().getServletContext().getRealPath(url);
			 if (file.getOriginalFilename().length() > 0) {  
				// 文件原名称
					String originFileName = file.getOriginalFilename();
					System.out.println(originFileName);
					//文件后缀名     te.st.jpg
					String ext_name=originFileName.substring(originFileName.lastIndexOf(".")) ;
					SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMddhhmmssSSS");
					String str_date=sdf.format(new Date());
					String server_name=str_date+ext_name;
					try {
						//上传并写入文件
						FileUtils.copyInputStreamToFile(file.getInputStream(),new File(realPath, server_name));
						//附件入库
						Map<String, Object> parm2=new HashMap<String, Object>();
						String attach_id=myGUID.valueAfterMD5;
						//parm2 入attach的参数
						parm2.put("id", attach_id);
						parm2.put("attach_name", originFileName);
						parm2.put("server_name", server_name);
						parm2.put("url", url);
						attachService.addAttach(parm2);
						//parm3 入OrderAttach的参数
						Map<String, Object> parm3=new HashMap<String, Object>();
						parm3.put("order_id", order_id);
						parm3.put("attach_id", attach_id);
						parm3.put("order_status", "2");
						if(key.equals("file_name1")){
							parm3.put("attach_tag", "order_confirm");//识别附件的类型	
						}
						else if(key.equals("file_name2")){
							parm3.put("attach_tag", "work_estimate");//识别附件的类型	
						}
						attachService.addOrderAttach(parm3);
					
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
		     }  
		}//end for...
		
		//需求确认其余字段入库
		RandomGUID myGUID2 = new RandomGUID();
		String estimate_date=request.getParameter("estimate_date");
		String estimate_work=request.getParameter("estimate_work");
		String evaluation_work=request.getParameter("evaluation_work");
		Map<String,Object> parm=new HashMap<String, Object>();
		parm.put("id", myGUID2.valueAfterMD5);
		parm.put("order_id", order_id);
		parm.put("estimate_date", estimate_date);
		parm.put("estimate_work", estimate_work);
		parm.put("evaluation_work", evaluation_work);
		confirmService.saveConfirm(parm);
		result="{\"flag\":\"success\"}";
		return result;
	}
	
	/**
	 * //判断是否已经填写需求分析文档
	 * @param parm
	 * @param request
	 * @param httpSession
	 * @return
	 */
	@RequestMapping(value = "check_confirm.action", produces = "application/json")
	public @ResponseBody 
	Map<String, Object> checkConfirmAjax(@RequestBody Map<String,Object> parm,HttpServletRequest request, HttpSession httpSession) {
		Map<String, Object> map = confirmService.findOrderConfirmByOrderId(parm);
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
