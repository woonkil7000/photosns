package com.cos.photogram.domain.user;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.CreationTimestamp;

import com.cos.photogram.domain.image.Image;
import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Data
@Entity
public class User {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id; 
	
	@Column(length = 30, unique = true)
	private String username;
	@Column(nullable = false)
	private String password;
	private String website;
	@Column(nullable = false)
	private String name; // 이름
	private String bio; // 자기소개
	@Column(nullable = false)
	private String email;
	private String phone;
	private String gender;
	
	private String profileImageUrl;
	private String provider; // 제공자 Google, Facebook, Naver
	
	private String role; // USER, ADMIN

	//@OneToMany(mappedBy = "user", fetch = FetchType.EAGER)
	// 연관관계의 주인이 아니다, 테이블에 컴럼을 만들지마시오.
	// User를 select 할때 해당 User id로 등록된 image들을 다 가져와~~
	// LAZY = User를 select할때 User id로 등록된 image들을 가져오지마~~ 대신 getImages()함수의 image들이 호출될때 가져와~~
	// EAGER = User를 select할때 User id로 등록된 image들을 전부 Join해서 가져와~~
	@OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
	@JsonIgnoreProperties("user") // Jpa 무한 순환참조 해결. images에서 user는 더깊이 Json으로 파싱하지마라.
	private List<Image> images; // 양방향 매핑.
	
	private LocalDateTime createDate;

	@PrePersist // DB에 insert될때 실행~~
	public void createDate(){
		this.createDate = LocalDateTime.now();
	}

	//@CreationTimestamp
	//private Timestamp createDate;
}
