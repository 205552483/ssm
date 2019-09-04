package dao;

import org.apache.ibatis.annotations.Param;

import entity.User;

public interface UserDao {
	public User findUserByName(String username);
	public void addUser(@Param("username")String username,@Param("password")String password);
}
