package com.store.jinyoung.service;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.store.jinyoung.entity.UserEntity;
import com.store.jinyoung.repository.UserRepository;

@Service
public class UserService implements UserDetailsService{
	
	
private final UserRepository userRepository;
	
	public UserService(UserRepository userRepository) {	
		this.userRepository = userRepository;
	}
	
	  @Override
	    public UserEntity loadUserByUsername(String userEmail) throws UsernameNotFoundException {
	        //여기서 받은 유저 패스워드와 비교하여 로그인 인증
	        UserEntity userEntity = userRepository.findByuserEmail(userEmail);
	        if (userEntity == null){
	            throw new UsernameNotFoundException("User not authorized.");
	        }
	        return userEntity;
	    }
	

       	@Transactional
	    public void joinUser(UserEntity userEntity){
	        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
	        userEntity.setUserPw(passwordEncoder.encode(userEntity.getPassword()));
	        userEntity.setUserName(userEntity.getUserName());
	        userEntity.setUserEmail(userEntity.getUserEmail());
	        userEntity.setProvider("local");
	        userEntity.setRole("ROLE_USER");
	        userRepository.save(userEntity);	        
	    }
}
