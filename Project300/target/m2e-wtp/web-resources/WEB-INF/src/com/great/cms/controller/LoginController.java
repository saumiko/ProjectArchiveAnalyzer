package com.great.cms.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.great.cms.db.dao.CourseDao;
import com.great.cms.db.dao.impl.*;
import com.great.cms.db.entity.Course;
import com.great.cms.db.entity.User;
import com.great.cms.db.entity.UserType;
import com.great.cms.service.CourseService;
import com.great.cms.service.UserService;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;


@Controller
@SessionAttributes("UserRole")
public class LoginController {

	@Autowired
	private UserService userService;
//	@Autowired
//	public CourseDao courseDao;   // IT IS WRONG(Meaning Doing it here is wrong)
	@Autowired
	CourseService courseService;
	

	@RequestMapping(value = "/checklogin", method = RequestMethod.POST)
	public String checkLogin(@RequestParam("user_name") String username,
			@RequestParam("password") String password, Model model,
			HttpServletRequest request,HttpSession session) {

		System.out.println("Username and Password: " + username + " "
				+ password);
		User user = null;

		user = userService.getUserByName(username);
		System.out.println("loginController");
		if (user == null) {
			model.addAttribute("message", "Invalid usrname or password");
			return "login";
		}

		else if (user.getPassword().equals(password)) {
			
            UserType Type= user.getUserTypeId();
            
			System.out.println("User Id: " + user.getUserId());
			model.addAttribute("userId", user.getUserId());
			model.addAttribute("username", username);
			model.addAttribute("UserRole" , user);
			//new added
			session.setAttribute("User",user);
			//
			System.out.println("Password: " + password);
			String Role=user.getUserTypeId().getUserTypeName();
			System.out.println("role now "+Role);
			if(Role.equals("Teacher")){
				System.out.println("Going to teacher course");
				return "course";
			}
			else{
				List<Course> courses = null;
				courses = courseService.getCourseListByUserType(user);
				model.addAttribute("courseList", courses);
				return "stdcourse";
			}
			
		}

		else {
			System.out.println("Not a successful login");
			model.addAttribute("message", "Invalid usrname or password");
			return "login";
		}

	}
	
	@RequestMapping(value = "/goToHomePage")
	public String goToHomePage(Model model,HttpServletRequest request,HttpSession session) {

		
		User user = null;
		
		user = (User) session.getAttribute("User");
		
		if (user == null) {
			model.addAttribute("message", "Invalid usrname or password");
			return "login";
		}

		else {
			
            UserType Type= user.getUserTypeId();
            
			System.out.println("User Id: " + user.getUserId());
			model.addAttribute("userId", user.getUserId());
			model.addAttribute("username", user.getUserName());
			model.addAttribute("UserRole" , user);
			String Role=user.getUserTypeId().getUserTypeName();
			
				List<Course> courses = null;
				courses = courseService.getCourseListByUserType(user);
				model.addAttribute("courseList", courses);
				return "stdcourse";
		}

	}
	
	
	
	@RequestMapping(value = "/sign-in.html", method = RequestMethod.GET)
	public String logOut(Model model,HttpSession session) {
		
		 session.invalidate();
		  if(model.containsAttribute("UserRole")) model.asMap().remove("UserRole");
		
		return "login";
		
		
		
	
	}
	

}