package com.store.jinyoung.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.store.jinyoung.entity.UserEntity;
import com.store.jinyoung.service.UserService;

@Controller
public class MainController {
	
	@Autowired
	UserService userService;

	@GetMapping("/")
	public String mainAPI() {	
<<<<<<< HEAD
		return "main";
=======
		return "login";
>>>>>>> branch 'main' of https://github.com/younghunk/store.git
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
    
    @GetMapping("/loginerror")
    public String loginsearch(@RequestParam(value = "error", required = false) String error,
                              @RequestParam(value = "exception", required = false) String exception,
                              Model model) {
    	
        model.addAttribute("error", error);
        model.addAttribute("exception", exception);
        return "login";
    }
    
    @PostMapping("/loginform")
    @ResponseBody
    public String processLogin(@RequestParam("username") String userEmail, @RequestParam("password") String password) {
        try {
            // Spring Security의 loadUserByUsername 메소드를 호출하여 인증을 수행합니다.
            UserEntity userEntity = userService.loadUserByUsername(userEmail);        
            return "success";
        } catch (UsernameNotFoundException e) {
            // 로그인 실패 시에는 예외 메시지를 반환합니다.
            return e.getMessage();
        }
    }
}
