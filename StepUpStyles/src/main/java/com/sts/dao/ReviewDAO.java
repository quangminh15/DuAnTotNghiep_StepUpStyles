package com.sts.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sts.model.Review;

public interface ReviewDAO extends JpaRepository<Review, Integer>{
    
}
