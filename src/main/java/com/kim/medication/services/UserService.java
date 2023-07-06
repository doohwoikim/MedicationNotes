package com.kim.medication.services;

import java.util.List;
import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import com.kim.medication.models.LoginUser;
import com.kim.medication.models.User;
import com.kim.medication.repositories.UserRepository;

@Service
public class UserService {
	@Autowired
	private UserRepository userRepository;

	public User register(User newUser, BindingResult result) {
		Optional<User> optionalUser = userRepository.findByEmail(newUser.getEmail());
		if (optionalUser.isPresent()) {
			result.rejectValue("email", "Unique", "Account with this email already exists.");
		}
		if (!newUser.getPassword().equals(newUser.getConfirm())) {
			result.rejectValue("confirm", "Matches", "The Confirm Password must match Password!");
		}
		if (result.hasErrors()) {
			return null;
		}
		String hashed = BCrypt.hashpw(newUser.getPassword(), BCrypt.gensalt());
		newUser.setPassword(hashed);

		newUser = userRepository.save(newUser);
		System.out.println("***New user created with ID: " + newUser.getId());
		return newUser;
	}

	public User login(LoginUser newLogin, BindingResult result) {
		Optional<User> optionalUser = userRepository.findByEmail(newLogin.getEmail());
		if (!optionalUser.isPresent()) {
			result.rejectValue("email", "MissingAccount", "No Account found.");
			return null;
		}
		User user = optionalUser.get();
		if (!BCrypt.checkpw(newLogin.getPassword(), user.getPassword())) {
			result.rejectValue("password", "Matches", "Invalid Password!");
		}
		if (result.hasErrors()) {
			return null;
		}
		System.out.println("***Log in user with ID: " + user.getId());
		return user;
	}

	public User findUser(Long id) {
		Optional<User> optionalUser = userRepository.findById(id);
		if (optionalUser.isPresent()) {
			return optionalUser.get();
		} else {
			return null;
		}
	}

	public List<User> allUsers() {
		return userRepository.findAll();
	}

	public User updateUser(User oneUser) {
		return userRepository.save(oneUser);
	}
}
