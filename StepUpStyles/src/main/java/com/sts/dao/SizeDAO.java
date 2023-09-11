package com.sts.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.sts.model.Size;

public interface SizeDAO extends JpaRepository<Size, Integer>{
	@Query("SELECT c FROM Size c WHERE c.sizeNumber LIKE %:keyword%")
	List<Size> findBySizeNumberContaining(@Param("keyword") String keyword);
}
