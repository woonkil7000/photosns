package com.cos.photogram.domain.user;

import com.cos.photogram.domain.image.Image;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Data
@Entity
@Table(
		name="user"
)
public class User {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY) // 번호 증가 전략을 DB에서 자동증가 사용.
	private int id; 
	
	@Column(length = 100, unique = true) // OAuth2 로그인위해 컬럼 늘리기.
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
	@OrderBy("id desc") // 최근 이미지 순
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

	@Override
	public String toString() {
		return "User{" +
				"id=" + id +
				", username='" + username + '\'' +
				", password='" + password + '\'' +
				", website='" + website + '\'' +
				", name='" + name + '\'' +
				", bio='" + bio + '\'' +
				", email='" + email + '\'' +
				", phone='" + phone + '\'' +
				", gender='" + gender + '\'' +
				", profileImageUrl='" + profileImageUrl + '\'' +
				", provider='" + provider + '\'' +
				", role='" + role + '\'' +
				", images= <생략:무한참조 방지>" +
				", createDate=" + createDate +
				'}';
	}
}
