package com.sts.dao;

import com.sts.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface UserDAO extends JpaRepository<User, Integer>{
	@Query("SELECT u FROM User u WHERE u.fullName LIKE %:keyword%")
	List<User> findByFullName(@Param("keyword") String keyword);
}
