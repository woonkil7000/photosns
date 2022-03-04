package com.cos.photogram.service;

import com.cos.photogram.domain.comment.handler.ex.CustomApiException;
import com.cos.photogram.domain.user.User;
import com.cos.photogram.domain.user.UserRepository;
import com.cos.photogram.domain.visitor.Visitor;
import com.cos.photogram.domain.visitor.VisitorRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@RequiredArgsConstructor
@Service
public class VisitorService {

    private final VisitorRepository visitorRepository;
    private final UserRepository userRepository;

    @Transactional
    public Visitor 방문기록(String ip,String pageUrl,String device,int userId){
        /*User user = new User();
        user.setId(userId);
        User userEntity=userRepository.findById(userId).orElseThrow(()->{
            throw new CustomApiException("유저를 찾을 수 없습니다");
        });*/

        Visitor visitor = new Visitor();
        visitor.setIp(ip);
        visitor.setPageUrl(pageUrl);
        visitor.setDevice(device);
        visitor.setUserId(userId);
        //visitor.setUser(userEntity);
        return  visitorRepository.save(visitor);
    }

    @Transactional(readOnly = true)
    public Page<Visitor> 방문조회(int userId, Pageable pageable) {

        Page<Visitor> visitors = visitorRepository.pagedList(userId,pageable);
        return visitors;
    }
}















