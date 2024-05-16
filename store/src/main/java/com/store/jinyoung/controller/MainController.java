package com.store.jinyoung.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.store.jinyoung.entity.UserEntity;
import com.store.jinyoung.service.UserService;

@Controller
public class MainController {
	
	@Autowired
	UserService userService;

	@GetMapping("/")
	public String mainAPI() {	
		return "store/jinyoung/main";
	}
	
	@GetMapping("/index")
	public String mainpage() {	
		return "index";
	}
	
	
    @GetMapping("/join")
    public String join() {
        return "join";
    }
    
    @PostMapping("/join")
    public String signUp(UserEntity userEntity) {
        userService.joinUser(userEntity);
        return "redirect:/";

    }
}
