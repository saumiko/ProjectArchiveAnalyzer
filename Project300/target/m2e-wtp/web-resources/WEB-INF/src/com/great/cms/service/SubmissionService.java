package com.great.cms.service;

import org.springframework.web.multipart.MultipartFile;

import com.great.cms.bean.SubmissionBean;

public interface SubmissionService {
	
	public void updateSubmission(SubmissionBean submissionBean,int submissionId);
	
	public void updateSubmissionWithFile(SubmissionBean submissionBean,MultipartFile multipartFile,int submissionId,String path);
	
	public void saveSubmission(SubmissionBean submissionBean, MultipartFile multipartFile,String path);
	
	public void deleteSubmission(int submissionId,String path);
	
	public void saveSubmission(SubmissionBean submissionBean);
	

}
