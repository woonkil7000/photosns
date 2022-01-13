package com.cos.photogram.config.auth;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Map;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.cos.photogram.domain.user.User;

import lombok.Data;
import org.springframework.security.oauth2.core.user.OAuth2User;

@Data
public class PrincipalDetails implements UserDetails, OAuth2User {
	private User user;
	private Map<String,Object> attributes;
	
	public PrincipalDetails(User user) {
		this.user = user;
	}

	public PrincipalDetails(User user,Map<String,Object> attributes) {

		this.user = user;
	}

	@Override
	public String getPassword() {
		return user.getPassword();
	}

	@Override
	public String getUsername() {
		return user.getUsername();
	}

	@Override
	public boolean isAccountNonExpired() {
		return true ;
	}

	@Override
	public boolean isAccountNonLocked() {
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	@Override
	public boolean isEnabled() {
		return true;
	}


	//권한이 한개가 아닌수 있기때문에 원래는 컬렉션에 담는다.
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		Collection<GrantedAuthority> collectors = new ArrayList<>();
		collectors.add(()-> "ROLE_"+user.getRole().toString());
		return collectors;
	}

	@Override // facebook
	public Map<String, Object> getAttributes() {
		return attributes; // {id:2325485221,name=baekwoon,email:woonkil70@....}
	}

	@Override // facebook
	public String getName() {
		return (String) attributes.get("name");
	}
}
