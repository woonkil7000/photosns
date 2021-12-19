package com.cos.photogram.domain.likes;

import java.sql.Timestamp;
import java.time.LocalDateTime;

import javax.persistence.*;

import org.hibernate.annotations.CreationTimestamp;

import com.cos.photogram.domain.image.Image;
import com.cos.photogram.domain.user.User;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Data
@Entity
@Table(
		name="likes",
		uniqueConstraints={
			@UniqueConstraint(
				name = "likes_uk",
				columnNames={"imageId","userId"} // 두 id로 유니크 설정
			)
		}
	)
public class Likes {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id; 

	// 무한 참조됨.
	@ManyToOne
	@JoinColumn(name = "imageId")
	private Image image;
	
	// 오류가 터지고 나서 잡아봅시다!!
	@JsonIgnoreProperties({"images"}) // User 안에서 images는 더이상 파싱하지마라. User안에서 images parsing시 무한잠조 발생.
	@ManyToOne
	@JoinColumn(name = "userId")
	private User user;
	
	@CreationTimestamp
	private Timestamp createDate;


	// 네이티브 쿼리 사용으로 아래는 의미없음.

//	private LocalDateTime createDate;
//
//	@PrePersist // DB에 insert될때 실행~~
//	public void createDate() {
//		this.createDate = LocalDateTime.now();
//	}
}










