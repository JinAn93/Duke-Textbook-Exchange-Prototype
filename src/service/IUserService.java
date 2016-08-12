package service;

import java.util.List;

import model.User;

public interface IUserService {

	User findById(String id);
	
	void saveUser(User user);
	
	void updateUserProfile(User user);
	
	void updateUserPassword(User user);
	
	void deleteUserById(String id);
	
	List<User> findAllUsers();

	boolean isUserIdUnique(String user_id);
	
	int isPasswordValid(String password);
}
