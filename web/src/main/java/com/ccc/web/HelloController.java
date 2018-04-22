package com.ccc.web;

import com.ccc.service.service.TMemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HelloController {
    @Autowired
    private TMemberService tMemberService;

    @GetMapping(value = "/index")
    public String index() {
        return "front/front_forward";
    }

    @GetMapping(value = "/map")
    public String getMapper() {
        return tMemberService.findById(1).toString();
    }
}
