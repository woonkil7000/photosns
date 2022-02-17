package com.cos.photogram.config;

import com.cos.photogram.config.auth.oauth.OAuth2DetailsService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@RequiredArgsConstructor
@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter{

	private final OAuth2DetailsService oAuth2DetailsService;

	@Bean
	public BCryptPasswordEncoder encode() {
		return new BCryptPasswordEncoder();
	}
	
	// 모델 : Image, User, Likes, Subscribe, Tag : 인증 필요함.
	// auth 주소 : 인증 필요없음.
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.csrf().disable();
		http.authorizeRequests()
			.antMatchers("/", "/user/**", "/image/**", "/subscribe/**, /comment/**","/api/**").access("hasRole('ROLE_USER') or hasRole('ROLE_ADMIN')")
			.antMatchers("/admin/**").access("hasRole('ROLE_ADMIN')")
			.anyRequest()
			.permitAll()
			.and()
			.formLogin()
				.loginPage("/auth/signin")
				.loginProcessingUrl("/login") // Post => PrincipalDetailsService로 로그인 진행.
				.defaultSuccessUrl("/") //.usernameParameter() // username 변수를 다르게 사용할때
				.and()
			.logout().clearAuthentication(true)// .clearAuthentication(true) 나중에 추가됨. 2022.02.17
				.logoutUrl("/logout")
				.logoutSuccessUrl("/")
			.and()
			.oauth2Login()// form login과 더불어 oauth2로그인도 사용
			.loginPage("/loginForm")
			.userInfoEndpoint()//oauth2로 로그인. 회원정보 바로받음.
			.userService(oAuth2DetailsService);
			// OAuth2.0 추가하기!
//				.failureForwardUrl() // 기타 함수 사용법 익히기
//				.failureUrl()
//				.successForwardUrl()
/*			.successHandler(new AuthenticationSuccessHandler() {
			@Override
			public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
												Authentication authentication) throws IOException, ServletException {
			}
		})*/
	}

	// 2022.02.17 added
/*	@Autowired
	public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
		auth.inMemoryAuthentication()
				.withUser("copycoding").password(password.Encode().encode("copycopy")).roles("ADMIN");
		auth.inMemoryAuthentication()
		.withUser("honggil").password(passwordEncode().encode("hoho")).roles("USER");
	}

	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}*/

}



