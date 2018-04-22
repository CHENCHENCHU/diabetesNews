package com.ccc.service.service;



import com.ccc.core.mapper.TAuthMapper;
import com.ccc.core.mapper.TAuthMemberMapper;
import com.ccc.core.mapper.TMemberMapper;
import com.ccc.core.model.TAuth;
import com.ccc.core.model.TAuthMember;
import com.ccc.core.model.TMember;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class MyUserDetailService implements UserDetailsService{

    @Autowired
    private TAuthMapper tAuthMapper;

    @Autowired
    private TAuthMemberMapper tAuthMemberMapper;

    @Autowired
    private TMemberMapper tMemberMapper;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        TMember tMember = tMemberMapper.selectByUserName(username);
        if (tMember == null)
            throw new UsernameNotFoundException(username);
        List<SimpleGrantedAuthority> authenic = new ArrayList<>();
        /**
         * 权限和角色之间的关系表  一个角色有多个权限
         */
        List<TAuthMember> tAuthMember = tAuthMemberMapper.selectByMemberId(tMember.getId());
        List<Integer> collect = tAuthMember.stream().map(TAuthMember::getAuthId).collect(Collectors.toList());
        List<TAuth> tAuths = tAuthMapper.selectListById(collect);
        tAuths.stream().forEach(i->authenic.add(new SimpleGrantedAuthority(i.getAuthName())));
        return new User(username,"{noop}"+tMember.getPassword(),authenic);
    }
}
