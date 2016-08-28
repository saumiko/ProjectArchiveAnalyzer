package com.great.cms.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.great.cms.db.entity.Course;
import com.great.cms.db.entity.CourseRegistration;
import com.great.cms.db.entity.Student;
import com.great.cms.db.entity.Task;
import com.great.cms.db.entity.Teacher;
import com.great.cms.db.entity.Teaches;
import com.great.cms.db.entity.User;
import com.great.cms.service.CourseRegistrationService;
import com.great.cms.service.CourseService;
import com.great.cms.service.StudentService;
import com.great.cms.service.TaskService;
import com.great.cms.service.TeacherService;
import com.great.cms.service.TeachesService;
import com.great.cms.service.UserService;

@Controller
public class CourseController {

	@Autowired
	private CourseService courseService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	TaskService taskService;
	
	@Autowired
	TeacherService teacherService;

	@Autowired
	private CourseRegistrationService courseRegistrationService;
	
	@Autowired
	private TeachesService teachesService;
	
	@Autowired
	private StudentService studentService;

	JSONArray jsonArray;
	
	

	
	
	@SuppressWarnings("unchecked")
	@RequestMapping(method = RequestMethod.GET, value = "/ajaxcourse")
	public @ResponseBody
	String getCourse(@RequestParam("username") String username, Model model) {

		System.out.println("In course Controller");
		User user = userService.getUserByName(username);
		model.addAttribute("username", username);
		model.addAttribute("user",user);
		// TODO: use username to return filtered course list
		List<Course> courses = null;
		courses = courseService.getCourseListByUserType(user);
		
     System.out.println("courseController " +user.getUserName());
		jsonArray = new JSONArray();
		if (courses == null)
			System.out.println("CourseController : LIST IS NULL");

		for (Course c : courses) {
			JSONArray jObj = new JSONArray();
			jObj.add(c.getCourseId());
			jObj.add(c.getCourseCode());
			jObj.add(c.getCourseTitle());
			jObj.add(c.getCredit());
			jObj.add(c.getSession());
			jsonArray.add(jObj);
		}
		JSONObject parameters = new JSONObject();

		parameters.put("draw", 1);
		parameters.put("recordsTotal", 1);
		parameters.put("recordsFiltered", 1);
		parameters.put("data", jsonArray);
		String taskJson = parameters.toJSONString();
		System.out.println(taskJson);
		System.out.println("going to teacher course page course");
		return taskJson;
	}
	
	//method for going back to the course page of a teacher
		@SuppressWarnings("unchecked")
		@RequestMapping(value = "/courseback",method=RequestMethod.GET)
		public String goBackToCoursePage(Model model){
			
			return "course";
					
		}
	
	
	//initialization of public view
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/publicview",method=RequestMethod.GET)
	public String tester(@RequestParam(value="session",required=false) String rsession,
			Model model,HttpSession courseSession){
		System.out.println("INISDE");
		int session;
		if (rsession!=null)
			session = Integer.parseInt(rsession);
		else
			session = 2011;
		courseSession.setAttribute("courseSession", session);
		System.out.println(rsession);
		List<Course> courses = (List<Course>) courseService.getCourseBySession(session);
		for (Course c:courses)
			System.out.println(c);
		model.addAttribute("courses",courses);
		
		return "publicview";
				
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/takecourse",method=RequestMethod.GET)
	public String takeCourse(@RequestParam(value="session",required=false) String rsession,
			Model model,HttpSession courseSession){
		System.out.println("INISDE");
		int session;
		if (rsession!=null)
			session = Integer.parseInt(rsession);
		else
			session = 2011;
		courseSession.setAttribute("courseSession", session);
		System.out.println(rsession);
		List<Course> courses = (List<Course>) courseService.getCourseBySession(session);
		for (Course c:courses)
			System.out.println(c);
		model.addAttribute("courses",courses);
		return "TakeCourseView";
				
	}
	
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/addtocourse",method=RequestMethod.GET)
	public String takeCourse(HttpSession session,@RequestParam(value="courseCode") String courseCode,@RequestParam(value="courseSession") int courseSession,Model model){
		System.out.println("INSIDE ADD TO COURSE\n");
		Course course = (Course) courseService.findByCourseCode2(courseCode, courseSession);
		System.out.println(course);
		User user = (User)session.getAttribute("User");
		Student student = studentService.getStudentByUserId(user.getUserId());
		
		//newly added
		
		int returnFlag = 0;
		List<CourseRegistration> courseRegistrationList = courseRegistrationService.getStudentRegistration(student.getStudentId());
		
		for (CourseRegistration creg : courseRegistrationList){
			System.out.println("Course Registration Id --> "+creg.getCourseId());
			if (creg.getCourseId().equals(course)){
				returnFlag = 1;
			}
		}
		
		//ends here
		
		if (returnFlag == 1)
			return "Failure";
		else{
			System.out.println(student);
			System.out.println("Next Course Registration Id is : "+courseRegistrationService.getNextCourseRegId());
			Long nextId = new Long (courseRegistrationService.getNextCourseRegId());
			CourseRegistration courseRegistration = new CourseRegistration(); 
			courseRegistration.setCourseRegId(nextId);
			courseRegistration.setIsApproved(true);
			courseRegistration.setCourseId(course);
			courseRegistration.setGpa(0.0);
			courseRegistration.setMarks(0.0);
			courseRegistration.setStudentId(student);
			courseRegistrationService.save(courseRegistration);
			return "TakeCourseView";
		}
		
	}
	
	
	@RequestMapping(value="/courseTaskViewReq",method=RequestMethod.GET)
	public String tester2(Model model,HttpSession session,@RequestParam("courseId") String strCourseId){
		int courseId = Integer.parseInt(strCourseId);
		int currentSession = Integer.parseInt(session.getAttribute("courseSession").toString());
		String courseTitle = courseService.getCourseById(courseId);
		//model.addAttribute("courseTitle", courseTitle);
		session.setAttribute("courseTitle",courseTitle);
		//newly added
		session.setAttribute("strCourseId", strCourseId);
		System.out.println(courseTitle);
		List<Task> tasks = taskService.getTaskListByCourseId(courseId);
		model.addAttribute("tasks", tasks);
		return "CourseTaskView";
	}
	
	@RequestMapping(value="/addcourse")
	public String addCourse(Model model){
		return "AddCourse";
	}
	
	@RequestMapping(value="/submitNewCourse",method=RequestMethod.POST)
	public String submitNewCourse(Model model,HttpSession session,Course course){
		System.out.println("this is new course Info");
		
		//newly added
		Course courseCheck = null;
		courseCheck = courseService.findByCourseCode2(course.getCourseCode(), course.getSession());
		if (courseCheck!=null)
			return "Failure";
		//ends here 
		else{
			courseService.saveCourse(course);
			User user = (User)session.getAttribute("User");
			Teacher teacher = teacherService.findByUserId(user.getUserId());
			System.out.println(" this is course info"+course.getCourseCode()+" "+ course.getSession());
			Course course2 = courseService.findByCourseCode2(course.getCourseCode(), course.getSession());
			System.out.println(course2.getCourseId());
			Teaches teaches = new Teaches(); 
			teaches.setCourseId(course2);
			teaches.setInstructorId(teacher);
			teachesService.saveTeaches(teaches);
			return "course";
		}
	}
}