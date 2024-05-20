
package com.store.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import com.store.jinyoung.service.CustomOAuth2UserService;
import com.store.jinyoung.service.UserService;




@Configuration
@EnableMethodSecurity
public class SpringSecurityConfig {
	
	private final CustomOAuth2UserService customOAuth2UserService;

	public SpringSecurityConfig(CustomOAuth2UserService customOAuth2UserService) {

		this.customOAuth2UserService = customOAuth2UserService;
	}
	
	@Autowired
	UserService userService;

	@Autowired
	CustomAuthFailureHandler customFailureHandler;
     
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
    	http.httpBasic().disable()
    	.csrf().disable()
    	.cors().and()
    	.authorizeHttpRequests()
    	.antMatchers("/index","/static","*/board/**", "/", "/oauth2/**", "/login/**").permitAll()
    	.and()
    	 .formLogin()
         .loginPage("/")
         .loginProcessingUrl("/loginform")
         .defaultSuccessUrl("/index")	
         .failureHandler(customFailureHandler) // 로그인 실패 핸들러
         .and()
    	 .oauth2Login()
    	 .loginPage("/")
    	 .defaultSuccessUrl("/index")	
    	 .userInfoEndpoint()
         .userService(customOAuth2UserService);
    	
        return http.build();
    }
    
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
    

}
