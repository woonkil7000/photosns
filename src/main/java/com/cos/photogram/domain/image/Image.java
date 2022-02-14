package com.cos.photogram.domain.image;

import java.sql.Timestamp;
import java.util.List;

import javax.persistence.*;

import org.hibernate.annotations.CreationTimestamp;

import com.cos.photogram.domain.comment.Comment;
import com.cos.photogram.domain.likes.Likes;
import com.cos.photogram.domain.tag.Tag;
import com.cos.photogram.domain.user.User;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Data // toString 자동생성
@Entity
@Table(
		name="image"
)
public class Image {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String caption; // 오늘 나 너무 피곤했어!!
	private String postImageUrl; //서버상의 이미지가 저장된 경로.
	
	@JsonIgnoreProperties({"images"}) // images의 User정보는 무시하라.
	@ManyToOne(fetch = FetchType.EAGER) // 이미지를 select하면 조인해서 User정보를 같이 들고옴.
	@JoinColumn(name = "userId")
	private User user;

	//@OneToMany(mappedBy = "image", cascade = {CascadeType.PERSIST, CascadeType.REMOVE}, fetch = FetchType.EAGER)
	// fetch = FetchType.EAGER 포함시 에러 발생됨. 추후 검토.
	@JsonIgnoreProperties({"image"})
	@OneToMany(mappedBy = "image", cascade = {CascadeType.PERSIST, CascadeType.REMOVE})
	private List<Tag> tags;

	// 이미지 좋아요~~
	@JsonIgnoreProperties({"image"}) // 무한참조 방지. Likes 안에서 image 파싱 금지시킴.
	@OneToMany(mappedBy = "image", cascade = {CascadeType.PERSIST, CascadeType.REMOVE})
	private List<Likes> likes; // A이미지에 홍길동, 장보고, 임꺽정 좋아요.   (고소영)

	// 댓글. 코맨트.
	@OrderBy("id DESC")  // 정렬
	@JsonIgnoreProperties({"image"}) // Comment에서 image파싱금지.
	@OneToMany(mappedBy = "image", cascade = {CascadeType.PERSIST, CascadeType.REMOVE})
	private List<Comment> comments; // 양방향 맵핑.


	@CreationTimestamp
	private Timestamp createDate;
	
	@Transient // 칼럼이 만들어지지 않는다.
	private int likeCount;
	
	@Transient // DB에 컬럼이 만들어지지않는다.
	private boolean likeState;

	// object를 콘솔에 출력할때 문제가 될수있어서 User부분을 출력되지않게 함.
	@Override
	public String toString() {
		return "Image{" +
				"id=" + id +
				", caption='" + caption + '\'' +
				", postImageUrl='" + postImageUrl + '\'' +
				// ", user=" + user +
				// useEntity 출력시 무한참조 에러 발생시킴
				", tags=" + tags +
				", likes=" + likes +
				", comments=" + comments +
				", createDate=" + createDate +
				", likeCount=" + likeCount +
				", likeState=" + likeState +
				'}';
	}
}





