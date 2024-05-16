package com.store.jinyoung.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.store.jinyoung.entity.UserEntity;

public interface UserRepository extends JpaRepository<UserEntity, Long> {

	UserEntity findByUsername(String username);
	
}
