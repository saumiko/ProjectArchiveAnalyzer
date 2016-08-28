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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.great.cms.bean.GroupBean;
import com.great.cms.bean.GroupInputBean;
import com.great.cms.db.entity.Project;
import com.great.cms.db.entity.Task;
import com.great.cms.service.ProjectGroupService;
import com.great.cms.service.TaskProjectService;

@Controller
public class GroupController {

	@Autowired
	private ProjectGroupService projectGroupService;

	@Autowired
	private TaskProjectService taskProjectService;

	private JSONArray jsonArray;

	@SuppressWarnings("unchecked")
	@RequestMapping(method = RequestMethod.GET, value = "/ajaxgroups")
	public @ResponseBody String getGroupListbyProjectId(
			@RequestParam(value = "project_id", required = false) int projectID, Model model) {

		System.out.println("GroupController  -> getGroupListbyProjectId");
		System.out.println("this is " + projectID);
		// List<Groups> groupList = null;
		List<GroupBean> groupList = null;
		if ((Object) projectID == null)
			projectID = 0;

		groupList = projectGroupService.findGroupsByProjectId(projectID);
		model.addAttribute("groupList", groupList);

		System.out.println("GroupController  -> groupList " + groupList);

		// jsonArray = new JSONArray();
		//
		// if (groupList == null)
		// System.out
		// .println("GroupController -> getGroupListbyProjectId : LIST IS
		// NULL");
		// if (groupList.size() == 0)
		// System.out
		// .println("GroupController -> getGroupListbyProjectId : LIST IS
		// EMPTY");
		//
		// for(GroupBean grp : groupList){
		// JSONArray jsonObj = new JSONArray();
		// jsonObj.add(grp.getGroupId());
		// jsonObj.add(grp.getGroupName());
		// JSONArray memberArray = new JSONArray();
		// for(String member : grp.getMemberList())
		// memberArray.add(member);
		// jsonObj.add(memberArray);
		//
		// jsonArray.add(jsonObj);
		// }
		//
		// JSONObject parameters = new JSONObject();
		// parameters.put("draw", 1);
		// parameters.put("recordsTotal", 1);
		// parameters.put("recordsFiltered", 1);
		// parameters.put("data", jsonArray);
		// String groupJson = parameters.toJSONString();
		// System.out.print("Json Data: " + groupJson);
		return "project-groups";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(method = RequestMethod.GET, value = "/ajaxstdgroups")
	public @ResponseBody String getstdGroupListbyProjectId(@RequestParam("project_id") int projectID) {

		System.out.println("GroupController  -> getGroupListbyProjectId");

		// List<Groups> groupList = null;
		List<GroupBean> groupList = null;
		if ((Object) projectID == null)
			projectID = 0;

		groupList = projectGroupService.findGroupsByProjectId(projectID);

		System.out.println("GroupController  -> groupList " + groupList);

		// model.addAttribute("submissions",submissionList);

		jsonArray = new JSONArray();

		if (groupList == null)
			System.out.println("GroupController  -> getGroupListbyProjectId : LIST IS NULL");
		if (groupList.size() == 0)
			System.out.println("GroupController  -> getGroupListbyProjectId : LIST IS EMPTY");

		for (GroupBean grp : groupList) {
			JSONArray jsonObj = new JSONArray();
			jsonObj.add(grp.getGroupId());
			jsonObj.add(grp.getGroupName());
			JSONArray memberArray = new JSONArray();
			for (String member : grp.getMemberList())
				memberArray.add(member);
			jsonObj.add(memberArray);

			jsonArray.add(jsonObj);
		}

		JSONObject parameters = new JSONObject();
		parameters.put("draw", 1);
		parameters.put("recordsTotal", 1);
		parameters.put("recordsFiltered", 1);
		parameters.put("data", jsonArray);
		String groupJson = parameters.toJSONString();
		System.out.print("Json Data:  " + groupJson);
		return groupJson;
	}

	@RequestMapping(value = "/addgroup", method = RequestMethod.POST)
	public String addGroup(GroupInputBean groupInputBean, @RequestParam("projectId") int projectId,
			@RequestParam("taskId") int taskId, Model model,HttpSession session) {
		System.out.println("ProjectGroupController  -> addgroup");
		model.addAttribute("task_id", taskId);

		List<Project> projectList = null;

		projectList = taskProjectService.findProjectsByTaskID(taskId);
		model.addAttribute("projectList", projectList);

		List<GroupBean> groupList = null;
		groupList = projectGroupService.findGroupsByProjectId(0);
		ArrayList<String> groupMemberList = new ArrayList<String>();

		System.out.println("GroupController  -> groupList " + groupList);

		for (GroupBean gr : groupList) {
			String allMemberString = " ";
			ArrayList<String> groupMemberList2 = gr.getMemberList();
			for (String str : groupMemberList2) {
				allMemberString += (str + " ");
			}
			gr.setMemberString(allMemberString);
		}
		model.addAttribute("groupList", groupList);
		
		//newly added
		
		Task task = (Task)session.getAttribute("Task");
		
		//ends here
		
		projectGroupService.addGroup(groupInputBean, projectId,task);
		return "project-groups";

	}

	@RequestMapping(value = "/goToAddGroupFormPage", method = RequestMethod.GET)
	public String addGroupFormPage(HttpSession session, @RequestParam("task_id") int task_id, Model model) {
		int projectId = (int) session.getAttribute("projectId");
		model.addAttribute("task_id", task_id);
		System.out.println("INside addgroupformpage" + projectId);
		return "AddNewGroup";
	}

	@RequestMapping(value = "/updategroup", method = RequestMethod.POST)
	public String editGroup(GroupInputBean groupInputBean, @RequestParam("taskId") int taskId, Model model) {
		System.out.println("GroupController  -> editgroup");
		// projectGroupService.editGroupOfProject(groupId, studentList);
		projectGroupService.editGroup(groupInputBean);
		model.addAttribute("task_id", taskId);

		List<Project> projectList = null;

		projectList = taskProjectService.findProjectsByTaskID(taskId);
		model.addAttribute("projectList", projectList);

		List<GroupBean> groupList = null;
		groupList = projectGroupService.findGroupsByProjectId(0);
		ArrayList<String> groupMemberList = new ArrayList<String>();

		System.out.println("GroupController  -> groupList " + groupList);

		for (GroupBean gr : groupList) {
			String allMemberString = " ";
			ArrayList<String> groupMemberList2 = gr.getMemberList();
			for (String str : groupMemberList2) {
				allMemberString += (str + " ");
			}
			gr.setMemberString(allMemberString);
		}
		model.addAttribute("groupList", groupList);
		return "project-groups";
	}

	@RequestMapping(value = "/gotoupdategroupformpage")
	public String goToUpdateGroupFormPage(@RequestParam("groupId") int groupId, @RequestParam("taskId") int taskId,
			Model model) {
		model.addAttribute("groupId", groupId);
		model.addAttribute("task_id", taskId);
		return "UpdateGroupPage";
	}

	@RequestMapping(value = "/deletegroup", method = RequestMethod.GET)
	public String deleteGroup(@RequestParam("groupId") int groupId, @RequestParam("taskId") int taskId, Model model) {
		System.out.println("GroupController  -> deletegroup");

		projectGroupService.deleteGroupOfProject(groupId);

		model.addAttribute("task_id", taskId);

		List<Project> projectList = null;

		projectList = taskProjectService.findProjectsByTaskID(taskId);
		model.addAttribute("projectList", projectList);

		List<GroupBean> groupList = null;
		groupList = projectGroupService.findGroupsByProjectId(0);
		ArrayList<String> groupMemberList = new ArrayList<String>();

		System.out.println("GroupController  -> groupList " + groupList);

		for (GroupBean gr : groupList) {
			String allMemberString = " ";
			ArrayList<String> groupMemberList2 = gr.getMemberList();
			for (String str : groupMemberList2) {
				allMemberString += (str + " ");
			}
			gr.setMemberString(allMemberString);
		}
		model.addAttribute("groupList", groupList);
		return "project-groups";

	}

}