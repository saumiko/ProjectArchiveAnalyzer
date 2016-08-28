package com.great.cms.db.dao.impl;

import org.springframework.stereotype.Repository;
import com.great.cms.db.dao.CourseTaskDao;
import com.great.cms.db.dao.DepartmentDao;
import com.great.cms.db.dao.DesignationDao;
import com.great.cms.db.entity.Course;
import com.great.cms.db.entity.CourseTask;
import com.great.cms.db.entity.Department;
import com.great.cms.db.entity.Designation;

@Repository("DesignationDao")
public class DesignationDaoImpl extends GenericDaoImpl<Designation, Integer> implements DesignationDao {

	@Override
	public Designation findByDesignationId(int dsgId) {
		Designation designation = null;

		try {
			
			String query = "select o from " + type.getName() + " o where o.desigId = ?1";
			designation = (Designation) em.createQuery(query).setParameter(1, dsgId).getResultList().get(0);

		} catch (Exception e) {
			System.out.println("*******failure*******in designation" + "trace of error " + e);
			return null;
		}
		System.out.println("*******successful*******designation");
		return designation;

	}

	public DesignationDaoImpl() {
		super(Designation.class);
	}

}
