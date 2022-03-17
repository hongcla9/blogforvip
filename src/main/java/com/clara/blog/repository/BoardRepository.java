package com.clara.blog.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.clara.blog.model.Board;

public interface BoardRepository extends JpaRepository<Board, Integer>{

}