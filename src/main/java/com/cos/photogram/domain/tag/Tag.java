package com.cos.photogram.domain.tag;

import java.sql.Timestamp;

import javax.persistence.*;

import org.hibernate.annotations.CreationTimestamp;

import com.cos.photogram.domain.image.Image;

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
		name="tag"
)
public class Tag {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id; 
	private String name;
	
	@ManyToOne
	@JoinColumn(name="imageId")
	private Image image;
	
	@CreationTimestamp
	private Timestamp createDate;
}
