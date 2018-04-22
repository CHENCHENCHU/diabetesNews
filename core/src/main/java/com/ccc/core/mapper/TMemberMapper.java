package com.ccc.core.mapper;

import com.ccc.core.model.TMember;
import org.springframework.stereotype.Repository;

@Repository
public interface TMemberMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(TMember record);

    int insertSelective(TMember record);

    TMember selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(TMember record);

    int updateByPrimaryKey(TMember record);

    TMember selectByUserName(String username);
}