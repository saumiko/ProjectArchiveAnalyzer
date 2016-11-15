package com.great.cms.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.great.cms.db.dao.DepartmentDao;
import com.great.cms.db.dao.StudentDao;
import com.great.cms.db.dao.UserTypeDao;
import com.great.cms.db.entity.Department;
import com.great.cms.db.entity.Designation;
import com.great.cms.db.entity.Project;
import com.great.cms.db.entity.Student;
import com.great.cms.db.entity.Task;
import com.great.cms.db.entity.Teacher;
import com.great.cms.db.entity.User;
import com.great.cms.db.entity.UserType;
import com.great.cms.service.CourseService;
import com.great.cms.service.DepartmentService;
import com.great.cms.service.DesignationService;
import com.great.cms.service.ProjectGroupService;
import com.great.cms.service.StudentService;
import com.great.cms.service.TaskProjectService;
import com.great.cms.service.TaskService;
import com.great.cms.service.TeacherService;
import com.great.cms.service.UserService;
import com.great.cms.service.UserTypeService;
import com.great.cms.bean.GroupBean;
import com.great.cms.bean.ProjectBean;


@Controller


public class HomeController {
	
	private JSONArray jsonArray;
	
	@Autowired
	private CourseService courseService;
	@Autowired
	private TaskProjectService taskProjectService;
	@Autowired
	private ProjectGroupService projectGroupService;
	@Autowired
	private StudentDao studentDao;
	@Autowired
	private UserService userService;
	@Autowired
	private UserTypeService userTypeService;
	@Autowired 
	private UserTypeDao userTypeDao; 
	@Autowired
	private DepartmentDao departmentDao;
	@Autowired
	private DepartmentService departmentService;
	@Autowired
	private StudentService studentService;
	@Autowired
	private TeacherService teacherService;
	@Autowired
	private DesignationService designationService;
	@Autowired
	private TaskService taskService;
	
	
	
	@RequestMapping("/hello")
	public String showHello(){
		//System.out.println("Spring - Great Web Hello Controller!");
		return "hello";
	}
	
	@RequestMapping("/register")
	public String goToRegPage(){
		//System.out.println("Spring - Great Web Hello Controller!");
		return "Registration";
	}
	
	@RequestMapping(value="/submitRegistrationForm",method = RequestMethod.POST)
	public String saveUserAndGoToTeacherOrStudentPageReg(@RequestParam("userTypeName") String userTypeName,User user,Model model,HttpSession session){
		
		
		System.out.println(userTypeName);
		UserType userType = userTypeService.getUserTypeByUserTypeName(userTypeName);
		List<User> allUsers = userService.getAllUser();
		int maxUserId = 0;
		for (User usr : allUsers){
			if (usr.getUserId()>maxUserId)
				maxUserId =  usr.getUserId().intValue();
		}
		++maxUserId;
		user.setUserName(user.getUserName()+maxUserId);
		user.setUserTypeId(userType);
		session.setAttribute("User", user);
		if(userTypeName.equals("Student"))
			return "StudentRegister";
		else
			return "TeacherRegister";
	}
	
	@RequestMapping(value="/submitStudentRegistrationForm",method = RequestMethod.POST)
	public String submitStdRegForm(@RequestParam("deptCode") String deptCode,Student student,Model model,HttpSession session){
		
		Department department = (Department)departmentService.findByDeptCode(deptCode);
		System.out.println(department.getDeptName());
		student.setDeptId(department);
		System.out.println(student.getRegistrationNo()+" "+student.getDeptId());
		User user = (User) session.getAttribute("User");
		student.setUserId(user);
		userService.saveUser(user);
		studentService.saveStudent(student);
		return "RegistrationSuccessful";
		
	}
	
	@RequestMapping(value="/submitTeacherRegistrationForm",method = RequestMethod.POST)
	public String submitTchRegForm(Model model,HttpSession session,Teacher teacher,@RequestParam("dsgId") int dsgId){
		
		Department department = (Department)departmentService.findByDeptCode("CSE");
		System.out.println(department.getDeptName());
		teacher.setDeptId(department);
		User user = (User) session.getAttribute("User");
		teacher.setUserId(user);
		Designation designation = (Designation) designationService.findByDesignationId(dsgId);
		System.out.println("this is designation object "+designation);
		teacher.setDesigId(designation);
		userService.saveUser(user);
		Long inst_id = teacherService.getAllTeacher();
		System.out.println("this is inst_id "+inst_id);
		teacher.setInstructorId(inst_id);
		try{
			teacherService.saveTeacher(teacher);
			return "RegistrationSuccessful";
		}
		catch(Exception e){
			return "Failure";
		}
		
	}
	
	@RequestMapping("/")
	public String showIndex(){
		//System.out.println("Spring - Great Web Hello Controller!");
		return "publicview";
	}
	
	@RequestMapping("/ajaxstdcourse")
	public String showCourse(){
		//System.out.println("Spring - Great Web Hello Controller!");
		return "stdcourse";
	}
	
	@RequestMapping("/ajaxcourse")
	public String showTeacherCourse(){
		//System.out.println("Spring - Great Web Hello Controller!");
		return "course";
	}
	@RequestMapping("/gototasks")
	public String showTasks(Model model, @RequestParam("course_id") int courseId,HttpSession session){
		model.addAttribute("course_id", courseId);
		model.addAttribute("course_code", courseService.getCourseById(courseId));
		System.out.println("INSIDE GO TO TASKS");
		List<Task> tasks = taskService.getTaskListByCourseId(courseId);
		
		for (Task t : tasks)
			System.out.println("this is deadline "+t.getTaskDeadline());
			
		model.addAttribute("taskList", tasks);
		
//		session.setAttribute("course_id", courseId);
//		session.setAttribute("course_code", courseService.getCourseById(courseId));
		session.setAttribute("courseId", courseId);
		return "tasks";
	}

	@RequestMapping("/gotostdtasks")
	public String showstdTasks(Model model, @RequestParam("course_id") int courseId){
		model.addAttribute("course_id", courseId);
		model.addAttribute("course_code", courseService.getCourseById(courseId));
		
		return "stdtasks";
	}

	@RequestMapping(value="/projectgroups")
	public String showProjectGroup(Model model, @RequestParam("task_id")int taskId,@RequestParam(value="project_id",required=false)Integer projectid,HttpSession session){
		System.out.println("Project Group  Page Mapping"+projectid);
		session.setAttribute("projectId", projectid);
		
		//newly added from here
		
		session.setAttribute("Task", taskService.findTaskById(taskId));
		session.setAttribute("taskDeadline",taskService.findTaskById(taskId).getTaskDeadline());
		//ends here
		
		
		model.addAttribute("task_id", taskId);
		System.out.println("task id in project groups: " + taskId);
		System.out.println("project id in project groups: " + projectid);
		List<Project> projectList = null;

		projectList = taskProjectService.findProjectsByTaskID(taskId);
		model.addAttribute("projectList", projectList);
		if( (Object) projectid == null)
			projectid = 0;
		
		List<GroupBean> groupList = null;
		groupList = projectGroupService.findGroupsByProjectId(projectid.intValue());
		ArrayList<String> groupMemberList = new ArrayList<String>();
		

		System.out.println("GroupController  -> groupList " + groupList);
		
		for (GroupBean gr : groupList){
			String allMemberString = " ";
			ArrayList<String> groupMemberList2 = gr.getMemberList();
			for (String str : groupMemberList2){
				allMemberString+=(str+" ");
			}
			gr.setMemberString(allMemberString);
			if (gr.getGroupName().endsWith(")")){
				int lastIndex = gr.getGroupName().lastIndexOf('(');
				int lastIndex2 = gr.getGroupName().length();
				gr.setGroupName(gr.getGroupName().substring(lastIndex+1, lastIndex2-1));
			}
				
		}	
		model.addAttribute("groupList", groupList);
		return "project-groups";
	}
	
	
	@RequestMapping(value="/viewAllProject")
	public String viewProjectGroupstd(Model model){
		System.out.println("Project Group  Page Mapping");
		
		//return "project-groups";
		return "ViewAllProjectInStudent";
	}
	
	@RequestMapping(value="/projectstdgroups")
	public String showstdProjectGroup(Model model, @RequestParam("task_id")int taskId,HttpSession session){
		System.out.println("student Project Group  Page Mapping");
		
		session.setAttribute("Task", taskService.findTaskById(taskId));
		//from here 
		
		model.addAttribute("task_id", taskId);
		System.out.println("task id in project groups: " + taskId);
		
		List<Project> projectList = null;
		ArrayList<Project> finalProjectList = new ArrayList<Project>();
		
		projectList = taskProjectService.findProjectsByTaskID(taskId);
		
		
		User user = (User)session.getAttribute("User");
		Student student = studentDao.getStudentByUserId(user.getUserId());
		int registrationNumber = student.getRegistrationNo();
		ArrayList<GroupBean> finalGroupList = new ArrayList<GroupBean>();
		
		for (Project pr : projectList){
			List<GroupBean> groupList = null;
			
			groupList = projectGroupService.findGroupsByProjectId(pr.getProjectId());
			ArrayList<String> groupMemberList = new ArrayList<String>();
			

			System.out.println("GroupController  -> groupList " + groupList);
			
			int groupFlag = 0;
			int breakFlag = 0;
			
			for (GroupBean gr : groupList){
				if (gr.getGroupName().endsWith(")")){
					int lastIndex = gr.getGroupName().lastIndexOf('(');
					int lastIndex2 = gr.getGroupName().length();
					gr.setGroupName(gr.getGroupName().substring(lastIndex+1, lastIndex2-1));
				}
				String allMemberString = " ";
				ArrayList<String> groupMemberList2 = gr.getMemberList();
				for (String str : groupMemberList2){
					allMemberString+=(str+" ");
					if (Integer.parseInt(str)==registrationNumber){
						finalProjectList.add(pr);
						groupFlag = 1;
					}
				}
				if (groupFlag == 1){
					gr.setMemberString(allMemberString);
					finalGroupList.add(gr);
					groupFlag = 0;
					breakFlag = 1;
					break;
				}
				
			}	
			if (breakFlag == 1)
				break;
		}
		model.addAttribute("projectList", finalProjectList);
		model.addAttribute("groupList", finalGroupList);
		session.setAttribute("taskDeadline",taskService.findTaskById(taskId).getTaskDeadline());
		return "student-project-groups";
	}
	
	@RequestMapping("/submissions")
	public String showSubmission(HttpSession session){
		System.out.println("HMM Here it is !!!!! Submission Page Mapping");
		
			User user = (User)session.getAttribute("User");
			System.out.println("this is user "+user.getUserTypeId().getUserTypeName());
			if (user.getUserTypeId().getUserTypeName().equals("Teacher"))
				return "submission";
			else
				return "submission2";	
		
		
		
	}
	@RequestMapping("/stdsubmissions")
	public String showstudentSubmission(){
		System.out.println("Submission Page Mapping");
		return "stdsubmission";
	}
	
}