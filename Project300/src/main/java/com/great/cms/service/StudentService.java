package com.great.cms.service;

import com.great.cms.db.entity.Student;

public interface StudentService {
	
	public void saveStudent(Student student);
	public Student getStudentByUserId(Long userId);
}
