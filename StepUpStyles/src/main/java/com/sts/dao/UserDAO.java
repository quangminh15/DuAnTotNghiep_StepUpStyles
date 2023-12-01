package com.sts.dao;

import com.sts.model.DTO.DResponseUser;
import com.sts.model.DTO.LResponseUser;
import com.sts.model.User;
import com.sts.model.DTO.OneUserForSecurity;
import com.sts.model.DTO.UserForSecurity;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.ColumnResult;
import javax.persistence.ConstructorResult;
import javax.persistence.SqlResultSetMapping;
import java.time.LocalDate;
import java.util.List;

public interface UserDAO extends JpaRepository<User, Integer>{
	@Query("SELECT u FROM User u WHERE u.fullName LIKE %:keyword%")
	List<User> findByFullName(@Param("keyword") String keyword);

	@Query(value = "SELECT * FROM users u WHERE u.email = ?1" ,nativeQuery = true)
	OneUserForSecurity findByEmail(String keyword);

	@Query(value = "SELECT * FROM users u WHERE u.email = ?1" ,nativeQuery = true)
	User findByEmailU(String keyword);

	@Query(value = "SELECT u.users_id FROM users u WHERE u.email = ?1" ,nativeQuery = true)
	Integer getIdByEmail(String keyword);

	@Query(value = "select u from User u")
	List<LResponseUser> findAllUser();

	@Query(value = "SELECT u FROM User u WHERE u.email = ?1" ,nativeQuery = false)
	DResponseUser getUserByEnail(String email);

	@Query(value = "SELECT u FROM User u WHERE u.phone = ?1" ,nativeQuery = false)
	DResponseUser getUserByPhone(String phone);

	@Query(value = "UPDATE users\n" +
					"SET password = ?2\n" +
					"WHERE email =  ?1" ,nativeQuery = true)
	String updatePass(String email, String pass);


	@Query(value = "Update User set fullName = ?1, birthday = ?2, phone = ?3, image = ?4 where  usersId = ?4")
	void updateProfile(String fullname, LocalDate birthday, String phone, String img, Integer userId);
}
