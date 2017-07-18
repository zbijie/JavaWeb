package com.fzy.common.util;

public class Constants {
	/**
	 * 工单状态
	 */
	public static final String ADD_ORDER="0";
	public static final String ORDER_ANALYSE="1";
	public static final String ORDER_CONFIRM="2";
	public static final String ORDER_AUDIT="3";
	public static final String ORDER_DEVELOP="4";
	
	/**
	 * 角色
	 */
	public static final String DEMAND_DRAFT_MAN="1"; //需求起草人    大写：ctrl+shift+x
	public static final String DEVELOP_MAN="2"; //开发负责人
	public static final String CAMPANY_MANAGER="3"; //厂家项目经理
	public static final String DEMAND_ADMIN_MAN="4"; //部门需求管理员
	
	/**
	 * 不用拦截器拦截的路径规则
	 */
	public static final String NO_INTERCEPTOR_PATH = ".*/((login)|(logout)|(checkLogin)|(main)|(order_list)|(left)|(code)).*";
	public static final String NO_LOGIN_INTERCEPTOR_PATH = ".*/((login)|(logout)|(checkLogin)).*";
}
