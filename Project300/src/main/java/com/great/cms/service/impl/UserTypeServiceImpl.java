package com.great.cms.service.impl;

import java.io.Serializable;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.great.cms.db.dao.UserTypeDao;
import com.great.cms.db.entity.UserType;
import com.great.cms.service.UserTypeService;

@Service("UserTypeService")
public class UserTypeServiceImpl implements UserTypeService, Serializable{
	
	@Autowired
	private UserTypeDao userTypeDao;
	
	public UserType getUserTypeByUserTypeName(String userTypeName){
		
		UserType userType = null;
		userType = userTypeDao.findByUserTypeName(userTypeName);
		return userType;
	}
}
