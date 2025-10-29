package com.tap.dao;

import java.util.List;

import com.tap.model.User;

public interface UserDAO {
	
	void addUser(User u);
	User getUser(int userId);
	void updateUser(User u);
	void deleteUser(int userId);
	List<User> getAllUsers();
	
}
