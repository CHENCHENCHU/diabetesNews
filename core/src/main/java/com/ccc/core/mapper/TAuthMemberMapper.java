package com.ccc.core.mapper;

import com.ccc.core.model.TAuthMember;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TAuthMemberMapper {
    int insert(TAuthMember record);

    int insertSelective(TAuthMember record);

    List<TAuthMember> selectByMemberId(Integer memberId);
}