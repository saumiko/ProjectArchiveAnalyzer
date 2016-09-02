package com.great.cms.service;

import java.util.List;

import com.great.cms.db.entity.CourseRegistration;

public interface CourseRegistrationService {
	
	public List<CourseRegistration> getStudentRegistration(int id);
	
	public int getNextCourseRegId();
	
	public void save(CourseRegistration courseRegistration);
	
	//public List<String> getCountryList();
	
}
