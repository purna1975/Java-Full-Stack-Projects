package com.tap.dao;

import java.util.List;
import com.tap.model.User;

public interface UserDao {
    int registerUser(User user);
    User loginUser(String email, String password);
    
    // Updated method to accept a search query
    List<User> getAllUsers(String searchQuery); // Modified method for search functionality

    int deleteUser(int userId);  // New method for deleting a user
    int toggleUserStatus(int userId);  // New method for blocking/unblocking a user
}