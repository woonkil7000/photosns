package com.cos.photogram.service;

import com.cos.photogram.domain.user.UserRepository;
import com.cos.photogram.handler.ex.CustomApiException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cos.photogram.domain.comment.Comment;
import com.cos.photogram.domain.comment.CommentRepository;
import com.cos.photogram.domain.image.Image;
import com.cos.photogram.domain.user.User;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class CommentService {

	private final CommentRepository commentRepository;
	private final UserRepository userRepository;

	@Transactional
	public Comment 댓글쓰기(String content, int imageId,int userId) {


		//Tip 객체를 만들때 id값만 담아서 insert 할 수있다.
		// 대신에 return 시 image객체와 uesr객체의 id값만 가지고 있는 빈 객체를 리턴받는다.
		Image image = new Image();
		image.setId(imageId);

		User userEntity = userRepository.findById(userId).orElseThrow(()->{
			throw new CustomApiException("유저를 찾을 수 없습니다.");
		});

		Comment comment = new Comment();
		comment.setContent(content);
		comment.setImage(image);
		comment.setUser(userEntity); // userEntity!! <- user.username등 포함.

		return commentRepository.save(comment);
	}
	
	@Transactional
	public void 댓글삭제(int id, int principalId) {
		
		Comment commentEntity = commentRepository.findById(id).get();
		if(commentEntity.getUser().getId() == principalId) {
			commentRepository.deleteById(id);
		}else {
			// 스로우 익센션 날려서 ControllAdvice 처리
		}
	}
}




