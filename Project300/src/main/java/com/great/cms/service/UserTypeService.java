package com.great.cms.service;

import java.util.List;

import com.great.cms.db.entity.User;
import com.great.cms.db.entity.UserType;

public interface UserTypeService{
	public UserType getUserTypeByUserTypeName(String userTypeName);
}
