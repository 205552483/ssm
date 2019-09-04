package service;

import entity.User;

public interface UserService {
	public User findUserByName(String username);
	public void addUser(String username,String password);
}
