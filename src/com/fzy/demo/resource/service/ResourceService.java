package com.fzy.demo.resource.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fzy.demo.resource.mapper.IResourceMapper;
import com.fzy.demo.resource.model.Resource;
@Service
public class ResourceService implements IResourceService {
	@Autowired
	IResourceMapper resourceMapper;
	@Override
	public List<Resource> getAllResource() {
		// TODO Auto-generated method stub
		return resourceMapper.getAllResource();
	}

}
