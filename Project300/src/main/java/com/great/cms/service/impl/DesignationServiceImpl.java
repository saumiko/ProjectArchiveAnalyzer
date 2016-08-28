package com.great.cms.service.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.great.cms.db.dao.CourseDao;
import com.great.cms.db.dao.CourseRegistrationDao;
import com.great.cms.db.dao.DesignationDao;
import com.great.cms.db.dao.StudentDao;
import com.great.cms.db.dao.TeacherDao;
import com.great.cms.db.dao.TeachesDao;
import com.great.cms.db.dao.UserDao;
import com.great.cms.db.entity.Course;
import com.great.cms.db.entity.CourseRegistration;
import com.great.cms.db.entity.Designation;
import com.great.cms.db.entity.Student;
import com.great.cms.db.entity.Teacher;
import com.great.cms.db.entity.Teaches;
import com.great.cms.db.entity.User;
import com.great.cms.db.entity.UserType;
import com.great.cms.service.CourseService;
import com.great.cms.service.DesignationService;
import org.springframework.stereotype.Repository;

@Repository
@Service("DesignationService")
public class DesignationServiceImpl implements DesignationService,Serializable{
	
	@Autowired DesignationDao designationDao;
	
	public Designation findByDesignationId(int dsgId){
		
		Designation designation = designationDao.findByDesignationId(dsgId);
		return designation;
		
	}
}
