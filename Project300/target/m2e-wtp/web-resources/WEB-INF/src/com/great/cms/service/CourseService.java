package com.great.cms.service;

import java.util.List;

import com.great.cms.db.entity.Course;
import com.great.cms.db.entity.User;

public interface CourseService {
	List<Course> getCourseList();
	List<Course> getCourseBySession(int session);
	
	public Course findByCourseCode2(String courseCode,int session);
	
	List<Course> getCourseListByUserId(Long id);
	String getCourseById(int id);
	List<Course> getCourseListByUser(String username);
	List<Course> getCourseListByUserType(User user);
	
	public void saveCourse(Course course);

}
