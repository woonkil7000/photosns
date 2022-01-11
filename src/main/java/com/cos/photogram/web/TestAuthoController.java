package com.cos.photogram.web;

import com.cos.photogram.domain.user.User;
import com.cos.photogram.web.dto.auth.SignupDto;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Slf4j
@Controller
public class TestAuthoController {

    @GetMapping("/jsp/java/model")
    public String jspToJavaToModel(Model model){

        User user = new User();
        user.setUsername("ssar");

        model.addAttribute("username",user.getUsername());

        return "test";

    }
    @GetMapping("/testsignup")
    public String test(){

        return "testsignup";
    }
    @PostMapping("/testsignup")
    public String test1(SignupDto signupDto){

        log.info("signupDto.toString() => {}",signupDto.toString());

        User user = signupDto.toEntity();
        log.info("user = user.toString()=> {}",user);
        return null;
    }


}
