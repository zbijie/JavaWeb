package com.fzy.demo.sys.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fzy.common.util.ExtJSReturn;
import com.fzy.common.util.FileToZip;
import com.fzy.common.util.RandomGUID;
import com.fzy.demo.analyse.service.IAnalyseService;
import com.fzy.demo.attach.service.IAttachService;
import com.fzy.demo.company.service.ICompanyService;
import com.fzy.demo.confirm.service.IConfirmService;
import com.fzy.demo.sys.service.ISysService;
import com.fzy.demo.user.model.UserModel;

@Controller
@RequestMapping(value = "/sys/*")
public class SysController {
	Logger logger=Logger.getLogger(SysController.class);
	@Autowired
	private ISysService sysService;
	@Autowired
	private IAttachService attachService;
	@Autowired
	private ICompanyService companyService;
	@Autowired
	private IAnalyseService analyseService;
	@Autowired
	private IConfirmService confirmService;
	
	@RequestMapping(value = "main.action", produces = "application/json")
	public String main(HttpServletRequest request, HttpSession httpSession) {
		List<Map<String, Object>> doneList = sysService.findAllOrder(null);
		request.setAttribute("doneList", doneList);
		// http://localhost:8080/ssmdemo/sys/WEB-INF/jsp/main.jsp
		String app_type=request.getParameter("app_type");
		if(app_type!=null && app_type.equals("mobile")){
			return "main_mobile";	
		}
		return "main";

	}
	@RequestMapping(value = "left.action", produces = "application/json")
	public String left(HttpServletRequest request, HttpSession httpSession) {
		return "left";
	}
	@RequestMapping(value = "order_list.action", produces = "application/json")
	public String orderList(HttpServletRequest request, HttpSession httpSession) {
		//		List<Map<String, Object>> list = sysService.findAllOrder(null);
		//		request.setAttribute("list", list);
		List<Map<String,Object>> company_list=companyService.findCompanyList(null);
		request.setAttribute("company_list", company_list);
		String app_type=request.getParameter("app_type");
		if(app_type!=null && app_type.equals("mobile")){
			
			return "order_mobile";	
		}
		return "order_list";

	}
	/**
	 * 使用Ajax方式查询
	 * @param parm
	 * @param request
	 * @param httpSession
	 * @return
	 */
	@RequestMapping(value = "order_list_ajax.action", produces = "application/json")
	public @ResponseBody 
	Map<String, Object> orderListAjax(@RequestBody Map<String,Object> parm,HttpServletRequest request, HttpSession httpSession) {
		List<Map<String, Object>> list = sysService.findAllOrder(parm);
		return ExtJSReturn.mapOK(list, "success");
	}
	/**
	 * 使用Ajax方式查询-需求编辑
	 * @param parm
	 * @param request
	 * @param httpSession
	 * @return
	 */
	@RequestMapping(value = "update_order_ajax.action", produces = "application/json")
	public @ResponseBody 
	Map<String, Object> updateOrderAjax(@RequestBody Map<String,Object> parm,HttpServletRequest request, HttpSession httpSession) {
		try {
			String order_id=parm.get("order_id").toString();
			parm.put("id", order_id);
			sysService.updateOrder(parm);
			return ExtJSReturn.mapOK("", "success");
		} catch (Exception e) {
			return ExtJSReturn.mapOK("", "fail");
		}
		
	}
	
	/**
	 * 跳转到添加工单的页面
	 * 
	 * @param request
	 * @param httpSession
	 * @return
	 */
	@RequestMapping(value = "to_add_order.action", produces = "application/json")
	public String toAddOrder(HttpServletRequest request, HttpSession httpSession) {
		 List<Map<String,Object>> company_list=companyService.findCompanyList(null);
		 request.setAttribute("company_list", company_list);
		return "add_order";

	}	
	/**
	 * 删除一条工单
	 * 
	 * @param request
	 * @param httpSession
	 * @return
	 */
	@RequestMapping(value = "delete_order.action", produces = "application/json")
	public String deleteOrder(@RequestParam String order_id,HttpServletRequest request, HttpSession httpSession) {
		Map<String,Object> parm=new HashMap<String, Object>();
		parm.put("id", order_id);
		sysService.deleteOrder(parm);
		String app_type=request.getParameter("app_type");
		if(app_type!=null && app_type.equals("mobile")){
			return "order_mobile";		
		}
		return "order_list";

	}
	/**
	 * 获取主键
	 * @param request
	 * @param httpSession
	 * @return
	 */
	@RequestMapping(value = "get_key_ajax.action", produces = "application/json")
	public @ResponseBody
	Map<String, Object> getKeyAjax(@RequestBody Map<String,Object> parm, HttpSession httpSession) {
		//获取order_attach的ID列表
		RandomGUID myGUID = new RandomGUID();
		String key=myGUID.valueAfterMD5;
		Map<String,String> map=new HashMap<String, String>();
		map.put("key", key);
		return ExtJSReturn.mapOK(map, "success");

	}
	/**
	 * Ajax提交--添加工单
	 * 
	 * @param request
	 * @param httpSession
	 * @return
	 */
	@RequestMapping(value = "add_order_ajax.action", produces = "application/json")
	public @ResponseBody
	Map<String, Object> addOrderAjax(@RequestBody Map<String,Object> parm, HttpSession httpSession) {
		//获取order_attach的ID列表
		String order_id=parm.get("order_id").toString();
		parm.put("id", order_id);
		parm.put("status", "0");
		//添加工单
		sysService.addOrder(parm);
		//回填order_attach的order_id
		String order_attach_ids=(String)parm.get("order_attach_ids");//12,13,14
		if(order_attach_ids!=null && !order_attach_ids.equals("")){	
			String[] order_attach_arr = order_attach_ids.split(",");
			for (int i = 0; i < order_attach_arr.length; i++) {
				Map<String, Object> parm2 = new HashMap<String, Object>();
				parm2.put("order_id", order_id);
				parm2.put("id", order_attach_arr[i]);
				if (order_attach_arr[i]!=null && !order_attach_arr[i].equals("")) {
					attachService.updateOrderAttach(parm2);
				}
			}
		}
		return ExtJSReturn.mapOK(parm, "success");

	}
	/**
	 * 表单提交--添加工单
	 * 
	 * @param request
	 * @param httpSession
	 * @return
	 */
	@RequestMapping(value = "add_order.action", produces = "application/json")
	public String addOrder(HttpServletRequest request, HttpSession httpSession) {
		String order_name = request.getParameter("order_name");
		String sys_no = request.getParameter("sys_no");
		String execute_company = request.getParameter("execute_company");
		//获取order_attach的ID列表
		Map<String, Object> parm = new HashMap<String, Object>();
		RandomGUID myGUID = new RandomGUID();
		String order_id=myGUID.valueAfterMD5;
		parm.put("id", order_id);
		parm.put("order_name", order_name);
		parm.put("sys_no", sys_no);
		parm.put("execute_company", execute_company);
		parm.put("status", "0");
		//添加工单
		sysService.addOrder(parm);
		//回填order_attach的order_id
		String order_attach_ids=request.getParameter("order_attach_ids");//12,13,14
		
		if(order_attach_ids==null && !order_attach_ids.equals("")){
			String[] order_attach_arr=order_attach_ids.split(",");
			for (int i = 0; i < order_attach_arr.length; i++) {
			
			Map<String, Object> parm2 = new HashMap<String, Object>();
			parm2.put("order_id", order_id);
			parm2.put("id", order_attach_arr[i]);
			if (order_attach_arr[i]!=null && !order_attach_arr[i].equals("")) {
				attachService.updateOrderAttach(parm2);
			}
		}
		}
		request.setAttribute("order_id", order_id);
		return "add_order";

	}
	/**
	 * 转向编辑工单的页面
	 * 
	 * @param request
	 * @param httpSession
	 * @return
	 */
	@RequestMapping(value = "to_edit_order.action", produces = "application/json")
	public String toEditOrder(HttpServletRequest request, HttpSession httpSession) {
		List<Map<String,Object>> company_list=companyService.findCompanyList(null);
		request.setAttribute("company_list", company_list);
		String id = request.getParameter("id");//工单ID
		Map<String, Object> parm = new HashMap<String, Object>();
		parm.put("id", id);
		//查询工单数据
		Map<String, Object> order= sysService.findOrderById(parm);
		request.setAttribute("order", order);
		//查询附件列表
		List<Map<String,Object>> attachList =attachService.findOrderAttachList(parm);
		request.setAttribute("attachList", attachList);
		
		return "edit_order";

	}
	/**
	 * 上传文件
	 * @param file
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "fileUpload.action",produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String fileUpload(
			@RequestParam(value = "file_name") MultipartFile file,
			HttpServletRequest request, HttpServletResponse response) {
			String result="";
		if (file != null) {
			String order_id=request.getParameter("order_id");
			// 获取保存的路径，
			String url="/upload/order/"+order_id+"/add_order/";
			String realPath = request.getSession().getServletContext().getRealPath(url);
			if (file.isEmpty()) {
				// 未选择文件
				result="empty";
			} else {
				// 文件原名称
				String originFileName = file.getOriginalFilename();
				//文件后缀名     te.st.jpg
				String ext_name=originFileName.substring(originFileName.lastIndexOf(".")) ;
				SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMddhhmmssSSS");
				String str_date=sdf.format(new Date());
				String server_name=str_date+ext_name;
				try {
					// 这里使用Apache的FileUtils方法来进行保存
					FileUtils.copyInputStreamToFile(file.getInputStream(),
					new File(realPath, server_name));
					//入库
					Map<String, Object> parm=new HashMap<String, Object>();
					RandomGUID myGUID = new RandomGUID();
					String attach_id=myGUID.valueAfterMD5;
					
					//parm 入attach的参数
					parm.put("id", attach_id);
					parm.put("attach_name", originFileName);
					parm.put("server_name", server_name);
					parm.put("url", url);
					attachService.addAttach(parm);
					//parm2 入OrderAttach的参数
					Map<String, Object> parm2=new HashMap<String, Object>();
					parm2.put("order_id", request.getParameter("order_id"));
					parm2.put("attach_id", attach_id);
					parm2.put("order_status", "0");
					parm2.put("attach_tag", "order");
					attachService.addOrderAttach(parm2);
					//回传（工单-文件）ID
					String r=String.valueOf(parm2.get("id"));
					//回传文件名
					String r2=originFileName;
					//回传文件路径
					String r3=url;
					//回传文件ID
					String r4=attach_id;
					//将三个数据拼接后回传客户端
					//result=r+","+r2+","+r3+","+r4;
					result="{\"flag\":\"success\",\"r\":\""+r+"\",\"r2\":\""+r2+"\",\"r3\":\""+r3+"\",\"r4\":\""+r4+"\"}";
				} catch (IOException e) {
					System.out.println("文件上传失败");
					result="fail";
					e.printStackTrace();
				}

			}
		}
		return result;
	}
	/**
	 * 下载单个文件
	 * @param request
	 * @return
	 * @throws IOException
	 */
	 @RequestMapping("downloadTest.action")    
	    public ResponseEntity<byte[]> downloadTest(HttpServletRequest request) throws IOException {    
	       //先压缩  D:/a/b/zz.zip
	    	// String path="C:\\Users\\Administrator\\Workspaces\\MyEclipse 9\\.metadata\\.me_tcat\\webapps\\ssmdemo\\upload\\ssmdemo.zip";  
	        String basePath=request.getSession().getServletContext().getRealPath("");
	        String url=request.getParameter("url");
	        String server_name=request.getParameter("server_name");
	        String attach_name=request.getParameter("attach_name");
	        String path=basePath+url+server_name;
	    	File file=new File(path);  
	        HttpHeaders headers = new HttpHeaders();    
	       // String fileName=new String(attach_name.getBytes("UTF-8"),"iso-8859-1");//为了解决中文名称乱码问题  
	        headers.setContentDispositionFormData("attachment", server_name);   
	        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);   
	        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file), headers, HttpStatus.CREATED);    
	    } 
	    /**
	     * 下载全部
	     * @param request
	     * @return
	     * @throws IOException
	     */
	    @RequestMapping("downloadAll.action")    
	    public ResponseEntity<byte[]> downloadAll(HttpServletRequest request) throws IOException {    
	       //先压缩  D:/a/b/zz.zip
	    	// String path="C:\\Users\\Administrator\\Workspaces\\MyEclipse 9\\.metadata\\.me_tcat\\webapps\\ssmdemo\\upload\\ssmdemo.zip";  
	    	String basePath=request.getSession().getServletContext().getRealPath("");
	        String order_id=request.getParameter("order_id");
	        String url="\\upload\\order\\"+order_id+"\\add_order";
	        String path=basePath+url;
	        SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMddhhmmssSSS");
			String zipFileName=sdf.format(new Date());
			String zipFilePath=basePath+"\\upload\\order\\"+order_id+"\\temp";
			//调用压缩方法
			FileToZip.fileToZip(path, zipFilePath, zipFileName);
			logger.info("生成压缩文件成功....");
			String furl=zipFilePath+"\\"+zipFileName+".zip";
	    	File file=new File(furl);  
	        HttpHeaders headers = new HttpHeaders();    
	       // String fileName=new String(attach_name.getBytes("UTF-8"),"iso-8859-1");//为了解决中文名称乱码问题  
	        headers.setContentDispositionFormData("attachment", zipFileName+".zip");   
	        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);   
	        logger.info("正在下载文件....");
	        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file), headers, HttpStatus.CREATED);    
	    }   
		/**
		 * 删除文件(伪删除，is_del=1)
		 * @param file
		 * @param request
		 * @param response
		 * @return
		 */
	    @RequestMapping(value = "delFile.action",produces = "application/json",method = {RequestMethod.POST } )
		@ResponseBody
		public Map<String, Object>  delFile(@RequestBody Map<String,Object> jsonstr,HttpServletRequest request){
			System.out.println("jsonstr------------->"+jsonstr);
			jsonstr.put("is_del", "1");
			try {
				attachService.updateAttach(jsonstr);
				return ExtJSReturn.mapOK("", "success");
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return ExtJSReturn.mapOK("", "fail");
			}
			
			
		}
	    
	    /**
	     * 查看工单详情
	     * @param order_id
	     * @param request
	     * @param httpSession
	     * @return
	     */
	    @RequestMapping(value = "view_order.action", produces = "application/json")
		public String viewOrder(@RequestParam String order_id,HttpServletRequest request, HttpSession httpSession){
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
			return "view_order";
		}
	    //移动版-查看详情-跳转页面
		@RequestMapping(value = "demand2.action", produces = "application/json")
		public String demand2(@RequestParam String order_id,HttpServletRequest request, HttpSession httpSession) {
			request.setAttribute("order_id", order_id);
			return "demand2";
		}
		@RequestMapping(value = "left1_mobile.action", produces = "application/json")
		public String left1(@RequestParam String order_id,HttpServletRequest request, HttpSession httpSession) {
			Map<String, Object> parm=new HashMap<String, Object>();
			parm.put("id", order_id);
			Map<String, Object> order= sysService.findOrderById(parm);
			request.setAttribute("order", order);
			return "left1_mobile";
		}
		@RequestMapping(value = "right5_mobile.action", produces = "application/json")
		public String right5_mobile(@RequestParam String order_id,HttpServletRequest request, HttpSession httpSession) {
			Map<String, Object> parm=new HashMap<String, Object>();
			parm.put("id", order_id);
			Map<String, Object> order= sysService.findOrderById(parm);
			request.setAttribute("order", order);
			return "right5_mobile";
		}
		@RequestMapping(value = "right1_mobile.action", produces = "application/json")
		public String right1_mobile(@RequestParam String order_id,HttpServletRequest request, HttpSession httpSession) {
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
			return "right1_mobile";
		}
		//跳转到编辑页面-移动版
		@RequestMapping(value = "to_edit_mobile.action", produces = "application/json")
		public String toeditmobile(@RequestParam String order_id,HttpServletRequest request, HttpSession httpSession) {
			List<Map<String,Object>> company_list=companyService.findCompanyList(null);
			request.setAttribute("company_list", company_list);
			Map<String, Object> parm=new HashMap<String, Object>();
			parm.put("id", order_id);
			//查询工单数据
			Map<String, Object> order= sysService.findOrderById(parm);
			request.setAttribute("order", order);
			//查询附件列表
			List<Map<String,Object>> attachList =attachService.findOrderAttachList(parm);
			request.setAttribute("attachList", attachList);
			return "edit_mobile";

		}

}
