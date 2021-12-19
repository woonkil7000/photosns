package com.cos.photogram.service;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import com.cos.photogram.handler.ex.CustomApiException;
import com.cos.photogram.handler.ex.CustomValidationException;
import com.cos.photogram.web.dto.subscribe.SubscribeDto;
import org.qlrm.mapper.JpaResultMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cos.photogram.domain.subscribe.SubscribeRepository;
import com.cos.photogram.web.dto.subscribe.SubscribeRespDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class SubscribeService {

	private final SubscribeRepository subscribeRepository;
	private final EntityManager em;
	
	@Transactional(readOnly = true)
	public List<SubscribeDto> 구독리스트(int principalId, int pageUserId){
		
		StringBuffer sb = new StringBuffer();
		sb.append("select u.id userId, u.username, u.profileImageUrl,  ");
		sb.append("if( (select true from subscribe where fromUserId = ? and toUserId = u.id), true, false) subscribeState, ");  // ? = principalDetails.user.id
		sb.append("if(u.id = ?, true, false) equalState "); // ? = principalDetails.user.id
		sb.append("from subscribe f inner join user u on u.id = f.toUserId ");
		sb.append("where f.fromUserId = ? "); // ? = pageUserId 해당 페이지의 주인 id
		
		Query query = em.createNativeQuery(sb.toString())
				.setParameter(1, principalId)
				.setParameter(2, principalId)
				.setParameter(3, pageUserId);
		
		System.out.println("쿼리 : "+query.getResultList().get(0));
		
		JpaResultMapper result  = new JpaResultMapper();
		List<SubscribeDto> subscribeDtos = result.list(query, SubscribeDto.class);
		return subscribeDtos;
	}
	
	@Transactional
	public int 구독하기(int fromUserId, int toUserId) {

		try {
			return subscribeRepository.mSubscribe(fromUserId, toUserId);
		} catch (Exception e){
			throw new CustomApiException("이미 구독을 하셨습니다.");
		}
	}
	
	@Transactional
	public int 구독취소(int fromUserId, int toUserId) {

		return subscribeRepository.mUnSubscribe(fromUserId, toUserId);
	}
}
