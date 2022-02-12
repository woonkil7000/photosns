package com.cos.photogram.service;

import com.cos.photogram.domain.comment.handler.ex.ErrorCode;
import com.cos.photogram.domain.comment.handler.ex.UsernameDuplicateException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.cos.photogram.domain.user.User;
import com.cos.photogram.domain.user.UserRepository;

import lombok.RequiredArgsConstructor;

@Slf4j
@RequiredArgsConstructor // final 선언된 객체의 생성자 자동실행
@Service // 1.IoC 2.Tranjaction management
public class AuthService {

	private final UserRepository userRepository;
	private final BCryptPasswordEncoder bCryptPasswordEncoder;
	
	public User joinMember(User user) {
		User aleadyUser = userRepository.findByUsername(user.getUsername());
		if(aleadyUser != null){
			throw new UsernameDuplicateException("username duplicated", ErrorCode.USERNAME_DUPLICATION);
		}
		String rawPassword = user.getPassword();
		String encPassword = bCryptPasswordEncoder.encode(rawPassword);
		user.setPassword(encPassword);
		user.setRole("USER");
		User userEntity = userRepository.save(user);
		log.info("########### userEntity = userRepository.save(user) => {}",userEntity);
		return userEntity;
	}
	public User findUserByUsername(String username){
		User aleadyUser = userRepository.findByUsername(username);
		return aleadyUser;
	}
}
