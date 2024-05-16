package com.store.jinyoung.entity;



import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
@Table(name="user")
public class UserEntity {
	
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

	
}
