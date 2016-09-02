package com.great.cms.db.dao.impl;

import org.springframework.stereotype.Repository;

import com.great.cms.db.dao.UserTypeDao;
import com.great.cms.db.entity.UserType;

//Tested
@Repository("UserType")
public class UserTypeDaoImpl extends GenericDaoImpl<UserType, Integer> implements UserTypeDao {
	

	public UserTypeDaoImpl( ) {
		super(UserType.class);
		
	}

	@Override
	public UserType findByUserTypeName(String name) {
		UserType user = null;
		try{
			String query = "select o from "+type.getName()+" o where o.userTypeName = ?1"; 
			user = (UserType) em.createQuery(query).setParameter(1, name).getResultList().get(0);
 	
 		}
		catch(Exception e){
			System.out.println(e);
        }
		    System.out.println("*******successful*****");
		return user;
		
		
	}
    
}
