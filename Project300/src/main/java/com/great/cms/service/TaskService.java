package com.great.cms.service;

import java.util.Date;
import java.util.List;

import com.great.cms.bean.TaskBean;
import com.great.cms.db.entity.Task;

public interface TaskService {
	
	List<Task>getTaskList();
	
	void saveTask(TaskBean taskBean, int courseId,Date date);

	void updateTask(TaskBean taskBean,Date date);
	
	void deleteTask(Task task);
	
	public Task findTaskById(int id);
	
	public void deleteTaskById(int id);
	
    public List<Task> getTaskListByCourseId(int courseId);	
	

}
