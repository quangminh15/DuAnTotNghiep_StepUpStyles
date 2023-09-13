package com.sts.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sts.model.Favorite;

public interface FavoriteDAO extends JpaRepository<Favorite, Integer>{
    
}
