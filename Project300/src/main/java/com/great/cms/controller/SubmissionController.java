package com.great.cms.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import org.springframework.web.multipart.MultipartFile;
import com.great.cms.bean.SubmissionBean;
import com.great.cms.db.dao.ProjectGroupDao;
import com.great.cms.db.dao.SubmissionDao;
import com.great.cms.db.entity.Submission;
import com.great.cms.db.entity.Task;
import com.great.cms.service.ProjectGroupSubmitService;
import com.great.cms.service.SubmissionService;

@Controller
public class SubmissionController {
	
	// TODO: Redirect to another page if there is no download file
    // TODO: Auto Reload With Updated values in the table after we edit.
	// TODO: Please Fix the Date Picking thing.
	
	
	@Autowired
	private SubmissionDao submissionDao;

	@Autowired
	private SubmissionService submissionService;

	@Autowired
	private ProjectGroupSubmitService projGrpSubService;
	
	@Autowired ProjectGroupDao projectGroupDao;

	private JSONArray jsonArray;

	@SuppressWarnings("unchecked")
	@RequestMapping(method = RequestMethod.GET, value = "/ajaxsubmissions")
	public @ResponseBody
	String getSubmissionList(Model model, @RequestParam("group_id") int groupId,HttpSession session) {
		System.out.println("Group Id: "+groupId);
		List<Submission> submissionList = null;

		submissionList = projGrpSubService
				.findSubmissionListByProjectGroupId(projectGroupDao.findByGroupId(groupId).getProjectGroupId());
		
		jsonArray = new JSONArray();

		if (submissionList == null)
			System.out
					.println("Hellllo Submission Controller -> getSubmissionList : LIST IS NULL");
	
		Date deadLine = (Date)session.getAttribute("taskDeadline");
		DateFormat df = new SimpleDateFormat("yyyy/MM/dd hh:mm:ss");
		
		try {
			for (Submission s : submissionList) {
				JSONArray jsonObj = new JSONArray();
				jsonObj.add(s.getSubmissionId().toString());
				System.out.println("thi is the sub time: "+s.getSubmissionTime());
				Date subTimeInDate = df.parse(s.getSubmissionTime());
				if(subTimeInDate.after(deadLine))
					jsonObj.add(s.getSubmissionTime()+" (Late)");
				else
					jsonObj.add(s.getSubmissionTime());
				//submissionDate = s.getSubmissionDeadline());
				jsonObj.add(s.getCommentTeacher());
				jsonObj.add(s.getSubmissionUrl());
				/*
				 * if( s.getTaskTypeId().getTaskTypeId()==1) jsonObj.add("Project");
				 * else jsonObj.add("Assignment");
				 */

				jsonArray.add(jsonObj);
			}
		} catch (Exception e) {
			System.out.println("Exception EXception!!!");
		}
		

		JSONObject parameters = new JSONObject();

		parameters.put("draw", 1);

		parameters.put("recordsTotal", 1);

		parameters.put("recordsFiltered", 1);

		parameters.put("data", jsonArray);

		String submissionJson = parameters.toJSONString();

		return submissionJson;
		//return "ProjectFileView";

	}

	
	// Updating Submissions
	@RequestMapping(value = "/editsubmission", method = RequestMethod.POST)
	public @ResponseBody
	String editSubmission(SubmissionBean submissionBean,
			@RequestParam("file") MultipartFile multipartFile,
			@RequestParam("submissionId") int submissionId,HttpSession session)
			throws FileNotFoundException {
		String path  = session.getServletContext().getRealPath("/");
		DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		Date date = new Date();
		System.out.println(dateFormat.format(date));
		submissionBean.setSubmissionTime(dateFormat.format(date));
		submissionService.updateSubmissionWithFile(submissionBean,multipartFile,submissionId,path);
		return "{ \"success\" : true }";
	}
	
	

	// Adding Submissions
	//addsubmissionnofile
	@RequestMapping(value = "/addsubmission", method = RequestMethod.POST)
	public @ResponseBody
	String doUpload(SubmissionBean submissionBean,
			@RequestParam("file") MultipartFile multipartFile,HttpSession session)
			throws FileNotFoundException {
		
		
		System.out
				.println("We're in addSubmission/doUpload method.\nfilename: "
						+ multipartFile.getOriginalFilename() + "\nComment: "
						+ submissionBean.getCommentTeacher());
		System.out.println("this is the group id in do upload "+submissionBean.getGroupId());
		String path  = session.getServletContext().getRealPath("/");
		//String path  = "F://Work//Upload Repo//";
		submissionBean.setSubmissionVer(0);
		DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		Date date = new Date();
		System.out.println(dateFormat.format(date));
		
		
		//newly added
		Task task = (Task) session.getAttribute("Task");
		Date deadLine = task.getTaskDeadline();
		System.out.println("this is the deadline"+dateFormat.format(deadLine));
//		if (date.compareTo(deadLine)>0){
//			submissionBean.setSubmissionTime(dateFormat.format(date)+" (Late)");
//		}
//		//ends here
//		else
			submissionBean.setSubmissionTime(dateFormat.format(date));
		submissionService.saveSubmission(submissionBean, multipartFile,path);
		return "Uploaded: " + multipartFile.getSize() + " bytes";
	}
	
	@RequestMapping(value = "/addsubmissionnofile", method = RequestMethod.POST)
	public @ResponseBody
	String doUploadWithNoFile(SubmissionBean submissionBean)
	{
		System.out.println("Add Submission with no file-Controller Layer");

		submissionService.saveSubmission(submissionBean);
		return "{ \"success\" : true }";
	}
	
	@RequestMapping(value = "/editsubmissionnofile", method = RequestMethod.POST)
	public @ResponseBody
	String doUploadEditWithNoFile(SubmissionBean submissionBean,@RequestParam("submissionId")int submissionId)
	{
		System.out.println("Edit Submission with no file upload hit in the Controller layer");

		submissionService.updateSubmission(submissionBean,submissionId);
		return "{ \"success\" : true }";
	}
	
	

	@RequestMapping(value = "/downloadfile", method = RequestMethod.GET)
	public @ResponseBody
	String provideDownloadable(HttpServletRequest request,
			HttpServletResponse response,HttpSession session) throws IOException {
		System.out.println("Download file path: "
				+ request.getParameter("filename"));

		// submissionService.updateSubmission(submission);

		// Downloading the File
		System.out.println("File Name: "+request.getParameter("filename"));
		String path  = session.getServletContext().getRealPath("/");
		try {
			File file = new File(path
					+ request.getParameter("filename") + ".zip");
			
			
			FileInputStream inputStream = new FileInputStream(file);

			// MIME type of the file
			response.setContentType("application/octet-stream");
			response.setHeader("Content-Disposition", "attachment; filename=\""
					+ file.getName() + "\"");

			// Read from the file and write into the response
			ServletOutputStream os = response.getOutputStream();

			byte[] buffer = new byte[1024];
			int len;
			while ((len = inputStream.read(buffer)) != -1) {
				os.write(buffer, 0, len);
			}

			os.flush();
			os.close();
			inputStream.close();

		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
		}

		return "{ \"success\" : true }";
	}
	
	@RequestMapping(value = "/verifysubmission", method = RequestMethod.GET)
	public
	String verifySubmission(@RequestParam("submissionId") int submissionId) {

		System.out.println("This is the submission info from verifysubmission "+submissionDao.findById(submissionId));
		Submission submission = submissionDao.findById(submissionId);
		submission.setSubmissionVer(1);
		submissionDao.update(submission);
		return "RegistrationSuccessful";
	}

	@RequestMapping(value = "/deletesubmission", method = RequestMethod.POST)
	public @ResponseBody
	String deleteSubmission(@RequestParam("submissionId") int submissionId,HttpSession session) {
		String path  = session.getServletContext().getRealPath("/");
		submissionService.deleteSubmission(submissionId,path);
		return "{ \"success\" : true }";
	}

}