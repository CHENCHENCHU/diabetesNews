package com.ccc.core.mapper;

import com.ccc.core.model.TAuth;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TAuthMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(TAuth record);

    int insertSelective(TAuth record);

    TAuth selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(TAuth record);

    int updateByPrimaryKey(TAuth record);

    List<TAuth> selectListById(List<Integer> authIds);
}