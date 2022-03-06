package com.woonkil.photosns.config.auth;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.woonkil.photosns.domain.user.User;
import com.woonkil.photosns.domain.user.UserRepository;

import lombok.RequiredArgsConstructor;
import org.springframework.transaction.annotation.Transactional;

@RequiredArgsConstructor
@Service
public class PrincipalDetailsService implements UserDetailsService{
	//protected Logger log = LoggerFactory.getLogger(this.getClass());
	private final UserRepository userRepository;
	//private AuthService authService;

	// 1. 패스워드는 알아서 함.
	// 2. 리턴만 잘되면 세션에 저장됨.

	@Override
	@Transactional
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

		System.out.println("////////////////////// Principal Details Service 로그인 프로세스 진행됨 ///////////////////////");

//		try {
//			User userEntity = userRepository.findByUsername(username); //////////////// 에러 유무 먼저 체크
//			System.out.print("/////////////////////  userEntity ==");
//			System.out.println(userEntity);
//		} catch (Exception e){
//			log.error(e.getMessage());
//			throw new UsernameNotFoundException(e.getMessage());
//		}

		User userEntity = userRepository.findByUsername(username);
		System.out.print("/////////////////////  userEntity ==");
		System.out.println(userEntity);

		//return new PrincipalDetails(userEntity); // SecurityContextHolder => Authentication 객체 내부에 담김.
		if(userEntity == null) {
			//return null; ////////////////////////////   username 없으면  AuthenticationService Exception 발생!!!!    ////////////////////////////
			return null;
		}else {
			return new PrincipalDetails(userEntity); // SecurityContextHolder => Authentication 객체 내부에 담김.
		}
		
	}

}
