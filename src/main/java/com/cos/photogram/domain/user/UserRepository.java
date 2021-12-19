package com.cos.photogram.domain.user;

import org.springframework.data.jpa.repository.JpaRepository;

// 어노테이션없어도 IoC자동 등록됨. JpaRepository 상속시.
public interface UserRepository extends JpaRepository<User, Integer>{

	// JPA query method
	User findByUsername(String username);
}
