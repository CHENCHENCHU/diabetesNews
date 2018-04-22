package com.ccc.service.service.impl;

import com.ccc.core.mapper.TMemberMapper;
import com.ccc.core.model.TMember;
import com.ccc.service.service.TMemberService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
@Service
public class TMemberServiceImpl implements TMemberService{
    @Resource
    private TMemberMapper tMemberMapper;
    @Override
    public TMember findById(Integer id) {
        return tMemberMapper.selectByPrimaryKey(id);
    }
}
