package com.great.cms.service.impl;

import org.springframework.stereotype.Service;

import com.great.cms.service.TeachesService;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.great.cms.db.dao.CourseDao;
import com.great.cms.db.dao.CourseRegistrationDao;
import com.great.cms.db.dao.StudentDao;
import com.great.cms.db.dao.TeacherDao;
import com.great.cms.db.dao.TeachesDao;
import com.great.cms.db.dao.UserDao;
import com.great.cms.db.entity.Course;
import com.great.cms.db.entity.CourseRegistration;
import com.great.cms.db.entity.Student;
import com.great.cms.db.entity.Teacher;
import com.great.cms.db.entity.Teaches;
import com.great.cms.db.entity.User;
import com.great.cms.db.entity.UserType;
import com.great.cms.service.CourseService;

@Service("TeachesService")
public class TeachesServiceImpl implements TeachesService,Serializable{
	
	@Autowired 
	private TeachesDao teachesDao;
	public void saveTeaches(Teaches teaches){
		teachesDao.save(teaches);
	}
}
