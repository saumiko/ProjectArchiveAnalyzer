package com.great.cms.service.impl;

import java.io.Serializable;

import com.great.cms.db.entity.Teacher;
import com.great.cms.service.CourseService;
import com.great.cms.service.TeacherService;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
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

@Repository
@Service("TeacherService")
public class TeacherServiceImpl implements TeacherService, Serializable{
	
	@Autowired 
	private TeacherDao teacherDao;
	
	public void saveTeacher(Teacher teacher){
		teacherDao.save(teacher);
	}
	
	public Long getAllTeacher(){
		
		Long totalEntries = teacherDao.getAllTeacher();

		return totalEntries;
		
	}
	
	public Teacher findByUserId(Long id){
		Teacher teacher = teacherDao.findByUserId(id);
		return teacher;
	}
}
