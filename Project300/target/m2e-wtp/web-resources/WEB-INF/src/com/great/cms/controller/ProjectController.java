package com.great.cms.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.great.cms.bean.GroupBean;
import com.great.cms.bean.ProjectBean;
import com.great.cms.db.dao.ProjectDao;
import com.great.cms.db.dao.ProjectGroupDao;
import com.great.cms.db.dao.StudentDao;
import com.great.cms.db.dao.StudentGroupDao;
import com.great.cms.db.dao.UserDao;
import com.great.cms.db.entity.Groups;
import com.great.cms.db.entity.Project;
import com.great.cms.db.entity.ProjectGroup;
import com.great.cms.db.entity.Student;
import com.great.cms.db.entity.StudentGroup;
import com.great.cms.db.entity.Submission;
import com.great.cms.db.entity.Task;
import com.great.cms.db.entity.User;
import com.great.cms.service.ProjectGroupService;
import com.great.cms.service.ProjectGroupSubmitService;
import com.great.cms.service.TaskGroupService;
import com.great.cms.service.TaskProjectService;
import com.great.cms.service.TaskService;

@SessionAttributes("UserRole")
@Controller
public class ProjectController {

	@Autowired
	private TaskProjectService taskProjectService;
	
	@Autowired
	private TaskGroupService taskGroupService;
	
	@Autowired
	private TaskService taskService;
	
	@Autowired
	private ProjectGroupService projectGroupService;
	
	@Autowired
	private ProjectGroupDao projectGroupDao;
	
	@Autowired
	private ProjectGroupSubmitService projectGroupSubmitService;

	@Autowired
	private UserDao userDao;
	@Autowired
	private StudentDao stdDao;
	
	private Project project;


	private JSONArray jsonArray;


	//this is one is done by siam bhai for getting the projects of the task
	@SuppressWarnings("unchecked")
	@RequestMapping(method = RequestMethod.GET, value = "/ajaxprojects")
	public @ResponseBody String getProjectList(Model model, @RequestParam("task_id") int taskId,@ModelAttribute("UserRole") User user)
	{
		System.out.println("Project Controller -> getProjectList ");
		// System.out.println("Task Id: "+taskId);
		List<Project> projectList = null;

		projectList = taskProjectService.findProjectsByTaskID(taskId);

		// model.addAttribute("submissions",submissionList);

		jsonArray = new JSONArray();

		if (projectList == null)
			System.out.println("Project Controller -> getProjectList : LIST IS NULL");
		if (projectList.size() == 0)
			System.out.println("Project Controller -> getProjectList : LIST IS EMPTY");

		for (Project proj : projectList) {
			JSONArray jsonObj = new JSONArray();
			jsonObj.add(proj.getProjectId().toString());
			jsonObj.add(proj.getProjectTitle());
			jsonObj.add(proj.getProjectDesc());

			// proj.ge

			/*
			 * if( s.getTaskTypeId().getTaskTypeId()==1) jsonObj.add("Project");
			 * else jsonObj.add("Assignment");
			 */

			// System.out.println("proj id : " + proj.getProjectId());

			jsonArray.add(jsonObj);
		}

		JSONObject parameters = new JSONObject();

		parameters.put("draw", 1);

		parameters.put("recordsTotal", 1);

		parameters.put("recordsFiltered", 1);

		parameters.put("data", jsonArray);

		String submissionJson = parameters.toJSONString();

		// System.out.print("DLSJDHSLKJDH: "+taskJson);
		return submissionJson;

	}
	
//	@SuppressWarnings("unchecked")
//	@RequestMapping( method = RequestMethod.GET,value = "/ajaxprojects2")
//	public String ajaxProjects2(Model model,@RequestParam("task_id") int taskId)
//	{
//		System.out.println("INSIDE AJAX PROJECTS \n");
//		List<Project> projectList = null;
//
//		projectList = taskProjectService.findProjectsByTaskID(taskId);
//
//		model.addAttribute("projectList",projectList);
//		
//		return "StudentPersonalProjects";
//
//	}


	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/addproject", method = RequestMethod.GET)
	public String addProject(Model model,Project project,@RequestParam("task_id") int task_id) {
		
		System.out.println("inside addProject "+task_id);
		System.out.println(project.getProjectTitle()+" "+project.getProjectDesc());
		taskProjectService.addProjectOfTask(project, task_id);
		model.addAttribute("task_id", task_id);
		List<Project> projectList = null;

		projectList = taskProjectService.findProjectsByTaskID(task_id);
		model.addAttribute("projectList", projectList);
		
		
		List<GroupBean> groupList = null;
		groupList = projectGroupService.findGroupsByProjectId(0);
		ArrayList<String> groupMemberList = new ArrayList<String>();
		

		System.out.println("GroupController  -> groupList " + groupList);
		
		for (GroupBean gr : groupList){
			String allMemberString = " ";
			ArrayList<String> groupMemberList2 = gr.getMemberList();
			for (String str : groupMemberList2){
				allMemberString+=(str+" ");
			}
			gr.setMemberString(allMemberString);
		}	
		model.addAttribute("groupList", groupList);
		return "project-groups";
		
	}
	
	@RequestMapping(value = "/addproject2",method = RequestMethod.GET)
	public String addProject2(@RequestParam("task_id") int task_id,Model model) {
		System.out.println("in addproject2"+task_id);
		model.addAttribute("task_id", task_id);
		return "AddProjectFormPage";
	}

	
	
	@RequestMapping(value = "/toUpdateProjectFormPage")
	public String toUpdateProjectPage(@RequestParam("task_id") int task_id,@RequestParam("projectId") int projectId,
			@RequestParam("projectTitle") String projectTitle,@RequestParam("projectDesc") String projectDesc,Model model) {
		System.out.println("task_id="+task_id+" projectId="+projectId+" projectTitle="+projectTitle+" projectDesc="+projectDesc);
		model.addAttribute("task_id", task_id);
		model.addAttribute("projectId", projectId);
		model.addAttribute("projectTitle", projectTitle);
		model.addAttribute("projectDesc", projectDesc);
		return "UpdateProjectFormPage";
	}
	
	@RequestMapping(value = "/updateproject", method = RequestMethod.GET)
	public String updateProject(ProjectBean project,Model model,@RequestParam("taskId") int taskId) {
		System.out.println("Project Controller -> updateProject");
		taskProjectService.updateProject(project,(float)taskId);
		model.addAttribute("task_id", taskId);
		List<Project> projectList = null;

		projectList = taskProjectService.findProjectsByTaskID(taskId);
		
		for (Project pr : projectList)
			System.out.println(pr.getProjectTitle()+" "+pr.getProjectDesc());
		model.addAttribute("projectList", projectList);
		
		
		List<GroupBean> groupList = null;
		groupList = projectGroupService.findGroupsByProjectId(0);
		ArrayList<String> groupMemberList = new ArrayList<String>();
		

		System.out.println("GroupController  -> groupList " + groupList);
		
		for (GroupBean gr : groupList){
			String allMemberString = " ";
			ArrayList<String> groupMemberList2 = gr.getMemberList();
			for (String str : groupMemberList2){
				allMemberString+=(str+" ");
			}
			gr.setMemberString(allMemberString);
		}	
		model.addAttribute("groupList", groupList);
		return "project-groups";
	}

	@RequestMapping(value = "/deleteproject")
	public String deleteProject(@RequestParam("taskId") int task_id,@RequestParam("projectId") int projectId,Model model) {
		System.out.println("inside deleteproject");
		
		//new
		taskProjectService.deleteTaskProjectByProjectId(projectId);
		//ends here
		
		taskProjectService.deleteProjectOfTask(projectId);
		model.addAttribute("task_id", task_id);
		List<Project> projectList = null;

		projectList = taskProjectService.findProjectsByTaskID(task_id);
		model.addAttribute("projectList", projectList);
		
		
		List<GroupBean> groupList = null;
		groupList = projectGroupService.findGroupsByProjectId(0);
		ArrayList<String> groupMemberList = new ArrayList<String>();
		

		System.out.println("GroupController  -> groupList " + groupList);
		
		for (GroupBean gr : groupList){
			String allMemberString = " ";
			ArrayList<String> groupMemberList2 = gr.getMemberList();
			for (String str : groupMemberList2){
				allMemberString+=(str+" ");
			}
			gr.setMemberString(allMemberString);
		}	
		model.addAttribute("groupList", groupList);
		return "project-groups";
		
	}
	
	@RequestMapping(value="/projectViewReq",method=RequestMethod.GET)
	public String tester2(Model model,HttpSession session,@RequestParam(value="taskId",required=false) String strTaskId){
		int taskId = Integer.parseInt(strTaskId);
		System.out.println("inside project View Req");
		List<Project> projects = taskProjectService.findProjectsByTaskID(taskId);
		model.addAttribute("projects", projects);
		model.addAttribute("project", "ProjectView");
		//model.addAttribute("taskId",taskId);
		session.setAttribute("taskId", taskId);
		String taskTitle = taskService.findTaskById(taskId).getTaskTitle();
		session.setAttribute("taskDeadline",taskService.findTaskById(taskId).getTaskDeadline());
		session.setAttribute("taskTitle", taskTitle);
		return "ProjectView";
	}
	
	@RequestMapping(value="/projectGroupViewReq",method=RequestMethod.GET)
	public String tester3(Model model,HttpSession session,@RequestParam(value="taskId",required=false) String strTaskId){
		System.out.println("INside projectGroupViewReq");
		int taskId = Integer.parseInt(strTaskId);
		List<Groups> groups = taskGroupService.findGroupsByTaskID(taskId);
		for (Groups grp : groups){
			grp.setProjectTitle(projectGroupService.findProjectTitleByGroupId(grp.getGroupId()));
		}
		for (Groups grp : groups){
			System.out.println(grp);
		}
		model.addAttribute("groups", groups);
		model.addAttribute("taskId",taskId);
		model.addAttribute("group","GroupView");
		String taskTitle = taskService.findTaskById(taskId).getTaskTitle();
		session.setAttribute("taskTitle", taskTitle);
		return "GroupView";
	}
	
	@RequestMapping(value="/projectGroupView",method=RequestMethod.GET)
	public String tester4(Model model,HttpSession session,@RequestParam(value="projectId") String strProjectId,@RequestParam(value="projectTitle") String projectTitle){
		int projectId = Integer.parseInt(strProjectId);
		List<GroupBean> projectGroup = projectGroupService.findGroupsByProjectId(projectId);
		for (GroupBean gr : projectGroup){
			if (gr.getGroupName().endsWith(")")){
				int lastIndex = gr.getGroupName().lastIndexOf('(');
				int lastIndex2 = gr.getGroupName().length();
				gr.setGroupName(gr.getGroupName().substring(lastIndex+1, lastIndex2-1));
			}
		}
		model.addAttribute("projectGroup", projectGroup);
		//model.addAttribute("projectTitle",projectTitle);
		session.setAttribute("projectTitle",projectTitle);
		session.setAttribute("projectId", projectId);
		return "ProjectGroupView";
	}
	
	@RequestMapping(value="/projectFileView",method=RequestMethod.GET)
	public String tester5(Model model,HttpSession session,@RequestParam(value="groupId") int groupId,@RequestParam(value="projectTitle",required=false) String projectTitle,@RequestParam(value="groupName",required=false) String groupName){
		//int groupId = Integer.parseInt(strGroupId);
		//int projectGroupId = projectGroupService.findProjectGroupIdByGroupId(groupId);
		System.out.println("Group Id is : "+groupId);;
		List<Submission> submissions = null;
		ArrayList<Submission> submissions2 = new ArrayList<Submission>();
		//submissions = projectGroupSubmitService.findSubmissionListByProjectGroupId(groupId);this was previous
		submissions = projectGroupSubmitService.findSubmissionListByProjectGroupId(projectGroupDao.findByGroupId(groupId).getProjectGroupId());
		//from here
		
		for(Submission sbm : submissions)
			System.out.println("this is submission ver "+sbm.getSubmissionVer());
		
		
		
		int count = 0;
		for (Submission sbm : submissions){
			++count;
			try{
				if (sbm.getSubmissionVer().intValue() == 1){
					System.out.println("This is submission ver "+sbm.getSubmissionVer());
					submissions2.add(sbm);
				}
					
			}
			catch(Exception e){
				System.out.println("This is count "+count);
				e.printStackTrace();
			}
		}
		
		//ends here
		
		if (submissions2.size()!=0){
			System.out.println("Hello"+groupId);
			model.addAttribute("projectTitle",projectTitle);
			model.addAttribute("submissions",submissions2);
			model.addAttribute("groupName",groupName);
			for (Submission s:submissions)
				System.out.println(s);
			return "ProjectFileView";
		}
		else
			return "Failure";
		
	}

}
