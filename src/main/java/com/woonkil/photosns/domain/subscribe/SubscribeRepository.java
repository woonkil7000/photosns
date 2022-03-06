package com.woonkil.photosns.domain.subscribe;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

public interface SubscribeRepository extends JpaRepository<Subscribe, Integer>{

	// write (@Modifying) insert,delete,update를 네이티브 쿼리 사용시 반드시 필요.
	@Modifying
	@Query(value = "INSERT INTO subscribe(fromUserId, toUserId, createDate) VALUES(:fromUserId, :toUserId, now())", nativeQuery = true)
	int mSubscribe(int fromUserId, int toUserId); // prepareStatement updateQuery() => -1:실패 0:변경된 갯수 없음. 1:성공갯수
	
	@Modifying
	@Query(value = "DELETE FROM subscribe WHERE fromUserId = :fromUserId AND toUserId = :toUserId", nativeQuery = true)
	int mUnSubscribe(int fromUserId, int toUserId); // prepareStatement updateQuery() => -1 0 1
	
	@Query(value = "select count(*) from subscribe where fromUserId = :principalId AND toUserId = :pageUserId", nativeQuery = true)
	int mSubscribeState(int principalId, int pageUserId);
	
	@Query(value = "select count(*) from subscribe where fromUserId = :pageUserId", nativeQuery = true)
	int mSubscribeCount(int pageUserId);
}
