package com.cos.photogram.web;

import com.cos.photogram.domain.user.User;
import com.cos.photogram.web.dto.auth.SignupDto;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.cos.photogram.service.AuthService;

import lombok.RequiredArgsConstructor;

import javax.validation.Valid;

// 시작주소 : /auth
@Slf4j
@RequiredArgsConstructor //final이 걸려있는 모든 객체의 생성자 실행됨. DI
@Controller
public class AuthController {

	private final AuthService authService; // final 정의시 생성자 호출됨.
/*	public AuthController(AuthService authService){ //AuthController 생성자
		this.authService = authService; // 의존성 주입
	}*/

	private SignupDto signupDto;

	@GetMapping("/auth/signin") // to auth/signin.jsp :login Form 으로
	public String loginForm() {
		return "auth/signin";
	}

	@GetMapping("/auth/signup") // to auth/signup.jsp joinForm: auth/signup 회원가입폼으로.
	public String joinForm() {
		return "auth/signup";
	}

	@PostMapping("/auth/signup") // /auth/signup.jsp <form action=post
	public String join(@Valid SignupDto signupDto, BindingResult bindingResult) {

		/*if(bindingResult.hasFieldErrors()){
			Map<String, String> errorMap = new HashMap<>();

			for(FieldError error:bindingResult.getFieldErrors()){
				errorMap.put(error.getField(),error.getDefaultMessage());
				System.out.println("=====================================");
				System.out.println(error.getDefaultMessage());
				System.out.println("=====================================");
			}
			throw new CustomValidationException("유효성 검사 실패함.",errorMap);
		} */

			log.info(signupDto.toString());

			//User <- SignupDto
			User user = signupDto.toEntity();
			//log.info(user.toString());

			User userEntity = authService.joinMember(signupDto.toEntity());
			System.out.println(userEntity);
			return "auth/signin";
			//return Script.href("회원가입에 성공하셨습니다.", "/auth/signin"


	}
	/*@PostMapping("/auth/signup") // signup form action method:post
	public String signup(SignupDto signupDto){
		log.info(signupDto.toString());
		return "auth/signin";
	}*/





}
