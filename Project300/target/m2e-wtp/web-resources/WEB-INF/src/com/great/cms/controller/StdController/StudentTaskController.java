package com.great.cms.controller.StdController;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.great.cms.bean.TaskBean;
import com.great.cms.db.dao.StudentDao;
import com.great.cms.db.dao.UserDao;
import com.great.cms.db.entity.Student;
import com.great.cms.db.entity.Task;
import com.great.cms.db.entity.User;
import com.great.cms.service.CourseTaskService;
import com.great.cms.service.ExamCommitteeService;
import com.great.cms.service.TaskService;
import com.great.cms.service.TaskTypeService;


@SessionAttributes("UserRole")
@Controller

public class StudentTaskController {

	
	@Autowired
	private TaskService taskService;
	@Autowired
	private TaskTypeService taskTypeService;
	@Autowired
	private CourseTaskService courseTaskService;
	@Autowired
	private ExamCommitteeService examCommitteeService;


	JSONArray jsonArray;
	
	
	@SuppressWarnings("unchecked")
	@RequestMapping(method = RequestMethod.GET, value = "/ajaxstdtasks")
	public
	String getstdTaskList(Model model,@RequestParam("course_id")int courseId, @ModelAttribute("UserRole") User user) {
		

			System.out.println("StudentCourse Id in student Task Controller: "+courseId);
				
				
				
				List<Task> tasks = taskService.getTaskListByCourseId(courseId);
				
				model.addAttribute("tasks", tasks);
				System.out.println("User in taskcontroller" +user.getUserName());
				
				
				
			
			return "stdtasks";
		

	}
}
