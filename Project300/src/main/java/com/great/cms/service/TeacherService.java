package com.great.cms.service;

import com.great.cms.db.entity.Teacher;

public interface TeacherService {
	public void saveTeacher(Teacher teacher);
	public Long getAllTeacher();
	public Teacher findByUserId(Long id);
}
