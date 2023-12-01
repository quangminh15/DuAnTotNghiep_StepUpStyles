package com.sts.controller;

import java.util.List;

import com.sts.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sts.model.Color;
import com.sts.model.Favorite;
import com.sts.model.Product;
import com.sts.model.Size;

@Controller
public class FavoriteController {
    @Autowired
    FavoriteService favoriteService;

    @Autowired
	ProductService productservice;

	@Autowired
	ProductDetailService productDetailService;
	
	@Autowired
	SizeService sizeService;
	
	@Autowired
	ColorService colorService;

	@Autowired
    UserService userService;

    @RequestMapping("/favorite")
    public String getFavoriteByUser(Model model){
        loadstatuslogin(model);
        // List<Favorite> item = favoriteService.findByUserId(3);
        // model.addAttribute("favoriteitems", item);
        return "users/favorite";
    }

    public void loadstatuslogin(Model model){
        Integer userIdCurrent = userService.getUserIdCurrent();
        if(userIdCurrent == null){
            model.addAttribute("loginStatus","no");

        }else{
            model.addAttribute("loginStatus","ok");
        }
    }
}
