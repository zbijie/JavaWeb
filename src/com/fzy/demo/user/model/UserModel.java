package com.fzy.demo.user.model;

import java.util.List;

import com.fzy.demo.role.model.Role;

public class UserModel {
	private int id;
	private String login_name;
	private String login_password;
	private String real_name;
	private int dept_id;
	private List<Role> role_list;
	public List<Role> getRole_list() {
		return role_list;
	}
	public void setRole_list(List<Role> role_list) {
		this.role_list = role_list;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getLogin_name() {
		return login_name;
	}
	public void setLogin_name(String login_name) {
		this.login_name = login_name;
	}
	public String getLogin_password() {
		return login_password;
	}
	public void setLogin_password(String login_password) {
		this.login_password = login_password;
	}
	public String getReal_name() {
		return real_name;
	}
	public void setReal_name(String real_name) {
		this.real_name = real_name;
	}
	public int getDept_id() {
		return dept_id;
	}
	public void setDept_id(int dept_id) {
		this.dept_id = dept_id;
	}

	
	

}
