package com.show.movie.test;

import javax.servlet.ServletContext;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.show.movie.model.dao.UserDAO;
import com.show.movie.model.domain.User;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/resources/config/mybatis-contextxml.xml")
@Log4j
public class UserMapperTest {
		
	@Autowired(required = false)
	ServletContext context;
	
	@Autowired(required = false)
	UserDAO userDao;
	
	@Test
	public void testGet() {
		String filePath =context.getRealPath("/");
		System.out.println("aaaaa "+filePath);
	}
	
}
