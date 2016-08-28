package com.great.cms.service.impl;

import java.io.Serializable;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.great.cms.db.dao.DepartmentDao;
import com.great.cms.db.entity.Department;
import com.great.cms.service.DepartmentService;

@Repository
@Service("DepartmentService")
public class DepartmentServiceImpl implements DepartmentService,Serializable{
	
	@Autowired 
	private DepartmentDao departmentDao;
	
	public Department findByDeptCode(String deptCode){
		
		Department department = null;
		department = departmentDao.findByDeptCode(deptCode);
		return department;
		
	}
	
	
}
