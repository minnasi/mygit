package com.show.movie.model.service.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Service;

import com.show.movie.model.dao.UserDAO;
import com.show.movie.model.domain.Login;
import com.show.movie.model.domain.User;
import com.show.movie.model.service.UserService;

import lombok.extern.log4j.Log4j;


@Service
@Log4j
public class UserServiceImpl implements UserService {
	@Autowired
	UserDAO userDAO;
	
	@Override
	public User getUser(String userId) {
		return userDAO.getUser(userId);
	}

	@Override
	public void insertNewUser(User user) {
		userDAO.insertNewUser(user);
	}

	@Override
	public User isUser(String userId) {
		return null;/*userDao.isUser(userId);*/
	}
	
	@Override
	public User getLogin(User login) {
		return userDAO.getLogin(login);
	}
	
	
	//예나
	@Override
	public void signUpUser(User user) {
		userDAO.signUpUser(user);
	}

	
	/*중훈
	
	@Override
	public Login encrypt(Login login) {
		return userDAO.encrypt(login);
	}*/

	@Override
	public int userIdCheck(User user) {
		int result = userDAO.userIdCheck(user);
		return result;
	}


}
