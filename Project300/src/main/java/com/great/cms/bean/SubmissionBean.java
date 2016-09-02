package com.great.cms.bean;

public class SubmissionBean {
	private String commentTeacher;
	private String submissionTime;
	private byte[] submissionFile;
	private Integer groupId;
	private Integer submissionVer;
	
	
	public Integer getSubmissionVer(){
		return submissionVer;
	}
	
	public void setSubmissionVer(Integer submissionVer){
		this.submissionVer = submissionVer;
	}
	
	public Integer getGroupId() {
		return groupId;
	}
	public void setGroupId(Integer groupId) {
		this.groupId = groupId;
	}
	public String getCommentTeacher() {
		return commentTeacher;
	}
	public void setCommentTeacher(String commentTeacher) {
		this.commentTeacher = commentTeacher;
	}
	public String getSubmissionTime() {
		return submissionTime;
	}
	public void setSubmissionTime(String submissionTime) {
		this.submissionTime = submissionTime;
	}
	public byte[] getSubmissionFile() {
		return submissionFile;
	}
	public void setSubmissionFile(byte[] submissionFile) {
		this.submissionFile = submissionFile;
	}

}
