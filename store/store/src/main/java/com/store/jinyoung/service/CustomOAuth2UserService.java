package com.store.jinyoung.service;

import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import com.store.jinyoung.dto.CustomOAuth2User;
import com.store.jinyoung.dto.GoogleResponse;
import com.store.jinyoung.dto.NaverResponse;
import com.store.jinyoung.dto.OAuth2Response;
import com.store.jinyoung.entity.UserEntity;
import com.store.jinyoung.repository.UserRepository;

@Service
public class CustomOAuth2UserService extends DefaultOAuth2UserService {

	private final UserRepository userRepository;
	
	// UserRepository를 주입받는 생성자
	public CustomOAuth2UserService(UserRepository userRepository) {
		
		this.userRepository = userRepository;
	}
	
	@Override
	public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
	    
	    // OAuth2UserService의 loadUser 메서드를 오버라이드하여 사용자 정보를 가져오는 로직 수행
	    OAuth2User oAuth2User = super.loadUser(userRequest);
	    System.out.println(oAuth2User.getAttributes());
	    
	    // OAuth2UserRequest로부터 클라이언트 등록 ID 가져오기
	    String registrationId = userRequest.getClientRegistration().getRegistrationId();
	    OAuth2Response oAuth2Response = null;
	    
	    // 클라이언트 등록 ID에 따라 사용자 정보를 가져온다
	    if (registrationId.equals("naver")) {
	        
	        oAuth2Response = new NaverResponse(oAuth2User.getAttributes());
	    }
	    else if (registrationId.equals("google")) {
	        
	        oAuth2Response = new GoogleResponse(oAuth2User.getAttributes());
	    }
	    else {
	        
	        return null;
	    }
	    
	    // 사용자 식별을 위한 username 생성
	    String userEmail = oAuth2Response.getEmail();
	    
	    // username을 이용하여 DB에서 사용자 정보 조회
	    UserEntity existData = userRepository.findByuserEmail(userEmail);
	    
	    String role = "ROLE_USER";
	    
	    if(existData == null) {
	        // DB에 해당 사용자 정보가 없는 경우 새로운 UserEntity 생성하여 저장
	        UserEntity userEntity = new UserEntity();
	        userEntity.setUserName(oAuth2Response.getName());
	        userEntity.setProvider(oAuth2Response.getProvider());       
	        userEntity.setUserEmail(oAuth2Response.getEmail());
	        userEntity.setRole(role);
	        
	        userRepository.save(userEntity);
	    }
	    else {
	    	return oAuth2User;
	    }	    
	    // 사용자 정보와 역할(role)을 이용하여 CustomOAuth2User 객체 생성하여 반환
	    return new CustomOAuth2User(oAuth2Response, role);
	}	
}
