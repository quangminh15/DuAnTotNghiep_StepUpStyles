package com.sts.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
public class test {
    
    @GetMapping(value="/test")
    public String getMethodName() {
        return "user/cart";
    }
    
}
