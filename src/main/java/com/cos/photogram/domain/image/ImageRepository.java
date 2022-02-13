package com.cos.photogram.domain.image;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface ImageRepository extends JpaRepository<Image, Integer>{

	// 구독중인 게시자 userid 의 사진들 목록 보기. select * from image WHERE userId IN (toUserId FROM SUBSCRIBE where fromUserId = principalId)
	@Query(value = "select * from image where userId in (select toUserId from subscribe where fromUserId = :principalId) order by id desc", nativeQuery = true)
	Page<Image> mFeed(int principalId, Pageable pageable);

	// 구독중인 게시자 userid 의 사진들 목록 보기 // 위와 쿼리 동일함. subscribe 에서 내가 구독중인 게시자의 ToUerId
	@Query(value = "select * from image where userId in (select toUserId from subscribe where fromUserId = :principalId) order by id desc", nativeQuery = true)
	Page<Image> mStory(int principalId, Pageable pageable);

	// 모든 사진 리스트 보기 createDate DESC // mStory(Pageable)
	@Query(value = "select * from image  order by createDate desc", nativeQuery = true)
	Page<Image> mStory(Pageable pageable);

	// 좋아요 랭킹. order by likeCount desc //좋아요 가 많은 순서대로 정렬.
	//@Query(value = "SELECT i.* FROM image i INNER JOIN (SELECT imageId, COUNT(imageId) likeCount FROM likes GROUP BY imageId " +
	//		" ORDER BY likeCount DESC) c ON i.id=c.imageId ORDER BY likeCount desc,i.id desc limit 10", nativeQuery = true)

	/*
	@Query(value = "select * from image i where id in (select imageId, likeCount from "
			+ "(select imageId, count(imageId) likeCount from likes group by imageId order by 2 desc,1 desc) "
			+ " t) and userId != :principalId  ", nativeQuery = true)
	*/

	// 좋아요가 많은 순으로 사진 정렬. 내 id 사진 제외.

	@Query(value = "select i.*,l.* from image i inner join "
			+" (select imageId,count(imageId) likeCount from likes group by imageId order by likeCount desc,imageId desc) l "
			+" on i.id = l.imageId where i.userId != :principalId", nativeQuery = true)
	List<Image> mExplore(int principalId);

	//@Query(value = "select * from image where id in (select imageId from (select imageId, count(imageId) likeCount from likes group by imageId order by 2 desc) t) and userId != :principalId  ", nativeQuery = true)
	//List<Image> mExplore(int principalId);
}
