package com.fzy.demo.analyse.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
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

import com.fzy.common.util.Constants;
import com.fzy.common.util.ExtJSReturn;
import com.fzy.common.util.RandomGUID;
import com.fzy.demo.analyse.service.IAnalyseService;
import com.fzy.demo.attach.service.IAttachService;
import com.fzy.demo.sys.service.ISysService;

@Controller
@RequestMapping(value = "/analyse/*")
public class AnalyseController {
	@Autowired
	private IAnalyseService analyseService;
	@Autowired
	private ISysService sysService;
	@Autowired
	private IAttachService attachService;
	@RequestMapping(value = "to_add_order_analyse.action", produces = "application/json")
	public String toAddOrderAnalyse(@RequestParam String order_id,HttpServletRequest request, HttpSession httpSession){
		//获取工单详细信息
		Map<String, Object> parm=new HashMap<String, Object>();
		parm.put("id", order_id);
		Map<String, Object> order= sysService.findOrderById(parm);
		request.setAttribute("order", order);
		//获取工单的附件列表
		Map<String, Object> parm2=new HashMap<String, Object>();
		parm2.put("id", order_id);
		List<Map<String, Object>> orderAttachList=attachService.findOrderAttachList(parm2);
		request.setAttribute("orderAttachList", orderAttachList);
		return "add_order_analyse";
	}
	/**
	 * 提交需求分析
	 * @param file
	 * @param request
	 * @param response
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping(value = "saveAnalyse.action",produces = "text/html")
	@ResponseBody
	public String saveAnalyse(
			@RequestParam(value = "file_name") MultipartFile file,
			HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		String result="";
		String order_id=request.getParameter("order_id");
		String analyse_opinion=request.getParameter("analyse_opinion");
		analyse_opinion = new String(analyse_opinion.getBytes("iso8859-1"),"utf-8");
		//需求分析入库
		Map<String ,Object> parm=new HashMap<String, Object>();
		RandomGUID myGUID = new RandomGUID();
		String id=myGUID.valueAfterMD5;
		parm.put("id", id);
		parm.put("order_id", order_id);
		parm.put("analyse_opinion", analyse_opinion);
		analyseService.saveAnalyse(parm);
		//修改工单状态
		Map<String ,Object> update_parm=new HashMap<String, Object>();
		update_parm.put("id", order_id);
		update_parm.put("status", Constants.ORDER_CONFIRM);
		sysService.updateOrder(update_parm);
		
		if (file != null) {
			// 获取保存的路径，
			String url="/upload/order/"+order_id+"/order_analyse/";
			String realPath = request.getSession().getServletContext()
					.getRealPath(url);
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
					parm3.put("order_status", "1");
					parm3.put("attach_tag", "order_analyse");//识别附件的类型
					attachService.addOrderAttach(parm3);
					//回传（工单-文件）ID
					String r=String.valueOf(parm3.get("id"));
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
					System.out.println("提交需求分析失败");
					result="fail";
					e.printStackTrace();
				}

			}
		}
		return result;
	}
	
	/**
	 * //判断是否已经填写需求分析文档
	 * @param parm
	 * @param request
	 * @param httpSession
	 * @return
	 */
	@RequestMapping(value = "check_analyse.action", produces = "application/json")
	public @ResponseBody 
	Map<String, Object> checkAnalyseAjax(@RequestBody Map<String,Object> parm,HttpServletRequest request, HttpSession httpSession) {
		Map<String, Object> map = analyseService.findOrderAnalyseByOrderId(parm);
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
