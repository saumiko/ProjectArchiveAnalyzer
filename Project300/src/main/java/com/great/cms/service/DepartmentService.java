package com.great.cms.service;

import com.great.cms.db.entity.Department;

public interface DepartmentService {
	public Department findByDeptCode(String deptCode);
	
}
