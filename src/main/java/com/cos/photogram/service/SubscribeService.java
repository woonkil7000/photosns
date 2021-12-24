package com.cos.photogram.service;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query; // 반드시 persistence 인지 확인!!

import com.cos.photogram.handler.ex.CustomApiException;
import com.cos.photogram.handler.ex.CustomValidationException;
import com.cos.photogram.web.dto.subscribe.SubscribeDto;
import lombok.NoArgsConstructor;
import org.qlrm.mapper.JpaResultMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cos.photogram.domain.subscribe.SubscribeRepository;
import com.cos.photogram.web.dto.subscribe.SubscribeRespDto;

import lombok.RequiredArgsConstructor;

//@NoArgsConstructor
@RequiredArgsConstructor
@Service
public class SubscribeService {

	private final SubscribeRepository subscribeRepository;
	private final EntityManager em;


	@Transactional(readOnly = true)
	public List<SubscribeDto> 구독리스트(int principalId, int pageUserId){

		// 쿼리 준비
		StringBuffer sb = new StringBuffer();
		sb.append("select u.id userId, u.username, u.profileImageUrl,  ");
		sb.append("if( (select true from subscribe where fromUserId = ? and toUserId = u.id), true, false) subscribeState, ");  // ? = principalDetails.user.id
		sb.append("if(u.id = ?, true, false) equalState "); // ? = principalDetails.user.id
		sb.append("from subscribe f inner join user u on u.id = f.toUserId ");
		sb.append("where f.fromUserId = ? "); // ? = pageUserId 해당 페이지의 주인 id

		System.out.println(" ######################## 해당 페이지 주인의 구독자 구하는 쿼리 ###########################");
		System.out.println(sb.toString());
		// 쿼리 완성
		Query query = em.createNativeQuery(sb.toString())
				.setParameter(1, principalId) // 첫번째 ?표
				.setParameter(2, principalId) // 두번째 ?표
				.setParameter(3, pageUserId); // 세번째 ?표

		//System.out.println("해당 페이지 유저의  구독자들 쿼리 : "+query.getResultList().get(0));

		// 쿼리 실행!! JpaResultMapper
		JpaResultMapper result  = new JpaResultMapper(); // 결과값 매핑
		System.out.println(" ######################## 결과값 맴핑 #########################");
		System.out.println(" ########################  result = " +result.toString());

		List<SubscribeDto> subscribeDtos = result.list(query, SubscribeDto.class);
		System.out.println(" ######################## 리스트 담기 #########################");
		System.out.println(" ########################  subscribeDtos = " +subscribeDtos.toString());
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
