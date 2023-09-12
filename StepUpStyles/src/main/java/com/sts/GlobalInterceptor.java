package com.sts;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.sts.model.Size;
import com.sts.service.BrandService;
import com.sts.service.CategoryService;
import com.sts.service.ColorService;
import com.sts.service.ProductDetailService;
import com.sts.service.ProductService;
import com.sts.service.SizeService;

@Component
public class GlobalInterceptor implements HandlerInterceptor {
	@Autowired
	BrandService brandService;

	@Autowired
	SizeService sizeService;

	@Autowired
	CategoryService categoryService;

	@Autowired
	ColorService colorService;

	@Autowired
	ProductService productservice;

	@Autowired
	ProductDetailService productDetailService;

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		request.setAttribute("brans", brandService.findAll());
//		request.setAttribute("bransU", brandService.findAllBrandUser());
		
		request.setAttribute("sizs", sizeService.findAll());
//		request.setAttribute("sizsU", sizeService.findAllSizeUser());
		

		request.setAttribute("cates", categoryService.findAll());
//		request.setAttribute("catesU", categoryService.findAllCategoryUser());

		request.setAttribute("cols", colorService.findAll());
//		request.setAttribute("colsU", colorService.findAllColorUser());

		request.setAttribute("prods", productservice.findAll());
//		request.setAttribute("prodsU", productservice.findAllProductUser());

		request.setAttribute("prodetais", productDetailService.findAll());
//		request.setAttribute("prodetaisU", productDetailService.findAllVariantUser());
	}
}
