package com.sts.dao;

import com.sts.model.User;
import com.sts.model.DTO.OneUserForSecurity;
import com.sts.model.DTO.UserForSecurity;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.ColumnResult;
import javax.persistence.ConstructorResult;
import javax.persistence.SqlResultSetMapping;
import java.util.List;

public interface UserDAO extends JpaRepository<User, Integer>{
	@Query("SELECT u FROM User u WHERE u.fullName LIKE %:keyword%")
	List<User> findByFullName(@Param("keyword") String keyword);

	@Query(value = "SELECT * FROM users u WHERE u.email = ?1" ,nativeQuery = true)
	OneUserForSecurity findByEmail(String keyword);

	@Query(value = "SELECT u.users_id FROM users u WHERE u.email = ?1" ,nativeQuery = true)
	Integer getIdByEmail(String keyword);

}
