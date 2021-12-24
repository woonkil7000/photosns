package com.cos.photogram.domain.comment;

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
		name="comment"
)
public class Comment {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@Column(length = 100, nullable = false) // 글자수 제약.
	private String content;
	
	@JoinColumn(name = "imageId")
	@ManyToOne(fetch = FetchType.EAGER) // EAGER: 기본값
	private Image image;
	
	@JsonIgnoreProperties({"images"}) // images 정보 가져오지않게
	@JoinColumn(name = "userId")
	@ManyToOne(fetch = FetchType.EAGER)
	private User user;
	
//	@CreationTimestamp
//	private Timestamp createDate;

	private LocalDateTime createDate;

	@PrePersist // DB에 insert될때 실행~~
	public void createDate(){
		this.createDate = LocalDateTime.now();
	}
}





