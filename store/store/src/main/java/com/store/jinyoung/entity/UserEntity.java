package com.store.jinyoung.entity;

<<<<<<< HEAD
=======


import java.util.Collection;
import java.util.Collections;

>>>>>>> branch 'main' of https://github.com/younghunk/store.git
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
@Table(name="user")
public class UserEntity implements UserDetails{
	
	@Id
    @Column(name = "id")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@Column(name = "user_name")
	private String userName;
	
	@Column(name = "provider")
	private String provider;
	
	@Column(name = "user_email")
	private String userEmail;
	
	@Column(name ="user_pw")
	private String userPw;
	
	@Column(name = "role")
	private String role;


	 @Override
	    public String getPassword() {
	        return this.userPw;
	    }
	
	    @Override
	    public String getUsername() {
	        return this.userEmail;
	    }


	    public String getUserName(){
	        return this.userName;
	    }
	
	    @Override
	    public boolean isAccountNonExpired() {
	        return true;
	    }

	    @Override
	    public boolean isAccountNonLocked() {
	        return true;
	    }

	    @Override
	    public boolean isCredentialsNonExpired() {
	        return true;
	    }

	    @Override
	    public boolean isEnabled() {
	        return true;
	    }

		@Override
		public Collection<? extends GrantedAuthority> getAuthorities() {
			  return Collections.singletonList(new SimpleGrantedAuthority(this.role));
		}
	
}
