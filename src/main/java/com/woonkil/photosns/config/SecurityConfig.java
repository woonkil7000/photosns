package com.woonkil.photosns.config;

import com.woonkil.photosns.config.auth.handler.CustomAuthFailureHandler;
import com.woonkil.photosns.config.auth.handler.CustomAuthSuccessHandler;
import com.woonkil.photosns.config.auth.oauth.OAuth2DetailsService;
import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.csrf.CsrfFilter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.web.filter.CharacterEncodingFilter;

//@AllArgsConstructor
//@PropertySource(value="classpath:/application.yml", encoding="UTF-8")
@RequiredArgsConstructor
@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter{

	//	@Autowired
	// 	private BCryptPasswordEncoder bCryptPasswordEncoder;

	/*@Autowired
	private UserDetailsService userDetailsService;
	*/
	//private CustomUserDetailsService userDetailsService;

	private final OAuth2DetailsService oAuth2DetailsService;

	//private AuthFailureHandler authFailureHandler;

	/*@Override
	protected void configure(HttpSecurity http) throws Exception {

		CharacterEncodingFilter filter = new CharacterEncodingFilter();
		filter.setEncoding("UTF-8");
		filter.setForceEncoding(true);
		http.addFilterBefore(filter, CsrfFilter.class);
		//rest of your code
	}*/


	// 모델 : Image, User, Likes, Subscribe, Tag : 인증 필요함.
	// auth 주소 : 인증 필요없음.
	@Override
	protected void configure(HttpSecurity http) throws Exception {

		http.csrf().disable();
		http.authorizeRequests()
			.antMatchers("/", "/user/**", "/image/**", "/subscribe/**, /comment/**","/api/**").access("hasRole('ROLE_USER') or hasRole('ROLE_ADMIN')")
			.antMatchers("/admin/**").access("hasRole('ROLE_ADMIN')")
				.antMatchers("/auth/failLogin").permitAll() //2022.02.19
			.anyRequest()
			.permitAll()
			.and()
			.formLogin()
				.loginPage("/auth/signin")
				.defaultSuccessUrl("/") //.usernameParameter() // username 변수를 다르게 사용할때
				.failureUrl("/auth/signin?error=true")
				//.successHandler(successHandler())//2022.02.19.
				//.failureHandler(failureHandler()) //2022.02.19.
				.loginProcessingUrl("/login") // Post => PrincipalDetailsService로 로그인 진행.
				.and()
			.logout().clearAuthentication(true)// .clearAuthentication(true) 나중에 추가됨. 2022.02.17
				.logoutRequestMatcher(new AntPathRequestMatcher("/logout"))// 2022.02.19
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

	/*@Bean
	@Override
	public UserDetailsService userDetailsService() {
		UserDetails user =
				User.withDefaultPasswordEncoder()
						.username("user")
						.password("password")
						.roles("USER")
						.build();

		return new InMemoryUserDetailsManager(user);
	}*/
	@Bean
	public BCryptPasswordEncoder encode() {
		return new BCryptPasswordEncoder();
	}

	@Bean
	public AuthenticationSuccessHandler successHandler(){
		return new CustomAuthSuccessHandler();
	}
	@Bean
	public AuthenticationFailureHandler failureHandler(){
		return new CustomAuthFailureHandler();
	}


	/*@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception{
		auth.userDetailsService((memberService).encode(encode()));
	}*/

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



