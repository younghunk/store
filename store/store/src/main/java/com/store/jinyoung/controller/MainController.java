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
		return "login";
	}
	
	@GetMapping("/index")
	public String mainpage() {	
		return "index";
	}
	
	
    @GetMapping("/join")
    public String join() {
        return "join";
    }
    
    //회원가입
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
    
    // 로그인
    @PostMapping("/loginform")
    @ResponseBody
    public String processLogin(@RequestParam("username") String userEmail, @RequestParam("password") String password) {
        try {
            // Spring Security의 loadUserByUsername 메소드를 호출하여 인증을 수행
            UserEntity userEntity = userService.loadUserByUsername(userEmail);        
            return "success";
        } catch (UsernameNotFoundException e) {
            // 로그인 실패 시에는 예외 메시지를 반환
            return e.getMessage();
        }
    }
    
    //아이디 중복 확인
	@PostMapping("/idCheck")
	@ResponseBody
    public boolean idOverlap(@RequestParam("userEmail") String userEmail) throws Exception {
        boolean type = userService.existsByuserEmail(userEmail);
        return type;  
	 }
    
}
