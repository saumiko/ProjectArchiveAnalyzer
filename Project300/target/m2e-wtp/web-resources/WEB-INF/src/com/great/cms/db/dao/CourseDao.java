package com.great.cms.db.dao;

import java.util.List;

import com.great.cms.db.entity.Course;

public interface CourseDao extends GenericDao<Course, Integer> {

	public Course findByCourseCode2(String CourseCode,int session);
	public Course findByCourseCode(String CourseCode);
	public List<Course> findByCourseSession(int session);
	
}
