package com.woonkil.photosns.domain.visitor;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface VisitorRepository extends JpaRepository<Visitor,Integer> {

    // 모든 방문리스트 보기 createDate DESC // mStory(Pageable)
    @Query(value = "select * from visitor  order by createDate desc", nativeQuery = true)
    Page<Visitor> pagedList(int userId,Pageable pageable);

}
