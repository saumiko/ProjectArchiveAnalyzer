package com.great.cms.db.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.great.cms.db.dao.CourseRegistrationDao;
import com.great.cms.db.entity.CourseRegistration;


/**
 * 
 * @author sknabil
 *
 */
@Repository("CourseRegistrationDao")
public class CourseRegistrationDaoImpl extends GenericDaoImpl<CourseRegistration, Integer> implements CourseRegistrationDao {

	public CourseRegistrationDaoImpl () {
		super ( CourseRegistration.class );
	}

	@SuppressWarnings("unchecked")
	@Override
	@Transactional(readOnly = true)
	public List<CourseRegistration> getRegistrationByIdStudent(int id) {
		List<CourseRegistration> list = null;
		//public ConfUser getConfUserByAccctMsisdn(long acctMsisdn){
		CourseRegistration courseReg = null;
			try{
				//courseReg = (CourseRegistration) em.createQuery("select o from " + type.getName() + " o where o.idStudent.idStudent ="+id+" ").getResultList();
				String query = "select o from " + type.getName() + " o where " +
     				   "o.studentId.studentId = ?1 " ;
     	list = em.createQuery(query)
     			 .setParameter(1, id)
     			 .getResultList();
     	
     	
     		}
			catch(Exception e){
				System.out.println("*******failure*******");
				return null;
	        }
			System.out.println("*******successful*******");
			return list;
		//}
	}
	
	public int getNextCourseRegId(){
		int nextId=0;
		try{
			String query = "from CourseRegistration";
			List<CourseRegistration> courseRegistrationList = em.createQuery(query).getResultList();
			nextId = courseRegistrationList.size()+1;
		}
		catch(Exception e){
			System.out.println("ERROR IN GETNEXT COURSE REG ID");
		}
		return nextId;
	}

}
