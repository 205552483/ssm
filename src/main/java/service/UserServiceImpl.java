package service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import dao.UserDao;
import entity.User;

@Service("userSerive")
public class UserServiceImpl implements UserService{

	@Resource
	private UserDao dao;
	
	public User findUserByName(String username) {
		User user = dao.findUserByName(username);
		return user;
	}

	public void addUser(String username, String password) {
		dao.addUser(username, password);
	}

}
