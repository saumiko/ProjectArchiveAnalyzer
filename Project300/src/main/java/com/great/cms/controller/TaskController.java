package com.great.cms.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

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
import com.great.cms.service.CourseService;
import com.great.cms.service.CourseTaskService;
import com.great.cms.service.ExamCommitteeService;
import com.great.cms.service.TaskService;
import com.great.cms.service.TaskTypeService;


@SessionAttributes("UserRole")
@Controller

public class TaskController {

	@Autowired
	private TaskService taskService;
	@Autowired
	private TaskTypeService taskTypeService;
	@Autowired
	private CourseTaskService courseTaskService;
	@Autowired
	private ExamCommitteeService examCommitteeService;
	@Autowired
	private CourseService courseService;


	JSONArray jsonArray;
    
	@SuppressWarnings("unchecked")
	@RequestMapping(method = RequestMethod.GET, value = "/ajaxtasks")
	public @ResponseBody
	String getTaskList(Model model,@RequestParam("course_id")int courseId) {
		System.out.println("TeacherCourse Id in Task Controller: "+courseId);
		
		// TODO: static list of tasks displayed for course_id 1, change to dynamic
		List<Task> tasks = taskService.getTaskListByCourseId(courseId);
		
		model.addAttribute("tasks", tasks);
		
		jsonArray = new JSONArray();
		if (tasks == null)
			System.out.println("TaskController : LIST IS NULL");

		for (Task t : tasks) {
			JSONArray jObj = new JSONArray();
			jObj.add(t.getTaskId().toString());
			jObj.add(t.getTaskTitle());
			/*
			 * if( t.getTaskTypeId().getTaskTypeId()==1) jObj.add("Project");
			 * else jObj.add("Assignment");
			 */
			//jObj.add(t.getTaskTypeId().getTaskTypeId());
			switch(t.getTaskTypeId().getTaskTypeId()){
			case 1:
				jObj.add("Assignment");
				break;
			case 2:
				jObj.add("Project");
				break;
			case 3:
				jObj.add("Thesis");
			}
			jObj.add(t.getTaskDesc());
			jObj.add(t.getTaskDeadline().toString());
			jObj.add(String.valueOf(t.getIsOpen()));
			jObj.add(String.valueOf(t.getTaskTotalGroupNo()));
			jObj.add(String.valueOf(t.getTaskTotalSubmissonNo()));

			jsonArray.add(jObj);

		}
		JSONObject parameters = new JSONObject();

		parameters.put("draw", 1);

		parameters.put("recordsTotal", 1);

		parameters.put("recordsFiltered", 1);

		parameters.put("data", jsonArray);

		String taskJson = parameters.toJSONString();

		// System.out.print("DLSJDHSLKJDH:  "+taskJson);
		return taskJson;

	}
	
	
	
	@RequestMapping(value = "/edittask", method = RequestMethod.POST)
	//public @ResponseBody String
	public String 
	updateTask( @RequestParam("taskTitle") String taskTitle,@RequestParam("taskDesc") String taskDesc,@RequestParam("deadline") String deadline,HttpSession session,Model model) {
		TaskBean taskBean = new TaskBean();
		System.out.println("this si taskDeadline "+deadline);
		System.out.println("this is taskTitle "+taskTitle);
		//taskBean.setTaskDeadline(deadline);
		taskBean.setTaskTitle(taskTitle);
		Task task = (Task) session.getAttribute("task");
		taskBean.setTaskId(task.getTaskId());
		taskBean.setTaskDesc(taskDesc);
		taskBean.setSession(2011);
		taskBean.setIsOpen(true);
		taskBean.setTaskTotalGroupNo(10);
		taskBean.setTaskTotalSubmissonNo(12);
		taskBean.setTaskType("Project");
		String startDateString = deadline;
	    SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss",Locale.ENGLISH); 
	    Date startDate = null;
	    try {
	        startDate = df.parse(startDateString);
	        String newDateString = df.format(startDate);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
		
		taskService.updateTask(taskBean,startDate);
		int courseId = (int) session.getAttribute("courseId");
		List<Task> tasks = taskService.getTaskListByCourseId(courseId);
		model.addAttribute("taskList", tasks);
		model.addAttribute("course_id", courseId);
		model.addAttribute("course_code", courseService.getCourseById(courseId));
		return "tasks";

	}
	
	@RequestMapping(value = "/addtask", method = RequestMethod.POST)
	public 
	
	String addTask( @RequestParam("taskTitle") String taskTitle,@RequestParam("taskDesc") String taskDesc,@RequestParam("deadline") String deadline,HttpSession session,Model model){
		TaskBean taskBean = new TaskBean();
		System.out.println("this si taskDeadline "+deadline);
		System.out.println("this is taskTitle "+taskTitle);
		//taskBean.setTaskDeadline(deadline);
		taskBean.setTaskTitle(taskTitle);
		Task task = (Task) session.getAttribute("task");
		//taskBean.setTaskId(task.getTaskId());
		taskBean.setTaskDesc(taskDesc);
		taskBean.setSession(2011);
		taskBean.setIsOpen(true);
		taskBean.setTaskTotalGroupNo(10);
		taskBean.setTaskTotalSubmissonNo(12);
		taskBean.setTaskType("Project");
		String startDateString = deadline;
	    DateFormat df = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss",Locale.ENGLISH); 
	    Date startDate = null;
	    try {
	        startDate = df.parse(startDateString);
	        String newDateString = df.format(startDate);
	        System.out.println("This is converrted date "+newDateString);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    int courseId = (int) session.getAttribute("courseId");
		taskService.saveTask(taskBean, courseId,startDate);
		
		List<Task> tasks = taskService.getTaskListByCourseId(courseId);
		model.addAttribute("taskList", tasks);
		model.addAttribute("course_id", courseId);
		model.addAttribute("course_code", courseService.getCourseById(courseId));
		return "tasks";
	}

	@RequestMapping(value = "/deletetask", method = RequestMethod.POST)
	public @ResponseBody
	String deletetask(@RequestParam("taskId") int id) {
		
		System.out.println("inside deletetaskbyid");
		taskService.deleteTaskById(id);
		
		return "{ \"success\" : true }";
	}
	
	@RequestMapping(value = "/getsessions", method = RequestMethod.GET)
	public @ResponseBody String getSessionList(){
		String data =  examCommitteeService.getAllSession();
		//System.out.println("Session data in controller: " + data);
		return "{\"Result\":\"OK\",\"Options\":" + data + "}";
		//return data;
	}

	@RequestMapping(value = "/goToUpdateTaskPage", method = RequestMethod.GET)
	//public @ResponseBody
	public 
	String goToUpdateTaskPage(@RequestParam("taskId") int id,Model model,HttpSession session) {
		System.out.println("THIS IS INSDE TASKE PAGE EDIT TASKI ID IS "+id);
		Task task = (Task) taskService.findTaskById(id);
		System.out.println(task);
		System.out.println(task.getTaskDeadline());
		session.setAttribute("task",task);
		model.addAttribute("taskTitle",task.getTaskTitle());
		model.addAttribute("taskDesc",task.getTaskDesc());
		model.addAttribute("taskDeadline",task.getTaskDeadline());
		return "UpdateTask";

	}
	
	@RequestMapping(value = "/goToAddTaskPage")
	//public @ResponseBody
	public 
	String goToAddTaskPage() {
		
		return "AddTaskPage";

	}
	
}
