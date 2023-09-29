package com.sts.config;

import com.sts.dao.UserDAO;
import com.sts.dto.respone.OneUserForSecurity;
import com.sts.dto.respone.UserForSecurity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;


import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Bean
    public BCryptPasswordEncoder bCryptPasswordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Autowired
    UserDAO userDAO;

    @Override
    public void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(email -> {
            try {
                OneUserForSecurity user = userDAO.findByEmail(email);
                String pass = user.getPassword();
                String role = user.getRole();
                List<String> list = new ArrayList<>();

                list.add(user.getRole());
                return org.springframework.security.core.userdetails.User.withUsername(email).password(pass).roles(role).build();
            } catch (Exception e) {
                System.out.println("Exep "+e);
                throw new UsernameNotFoundException("Not found user has email: " + email);
            }
        });
    }

    private String determineTargetUrl(Authentication authentication) {
        String role = authentication.getAuthorities().toString();
        if (role.contains("ADMIN") || role.contains("EMPLOYEE")) {
            return "/admin";
        } else {
            return "/index";
        }
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.csrf().disable().cors().disable();

        // Phân quyền
        http.authorizeRequests()
                .antMatchers("/cart/**").hasRole("USER")
                .antMatchers("/admins/**").hasAnyRole("ADMIN","EMPLOYEE")
                .antMatchers("/admins/thongke").hasRole("ADMIN")
                .antMatchers("/static/**").permitAll()
                .anyRequest().permitAll()
                .and()
                .exceptionHandling()
                .accessDeniedPage("/accessdenied");

        http.formLogin()
                .loginPage("/loginSTS")
                .loginProcessingUrl("/auth/login")
                .successHandler((request, response, authentication) -> {
                    String targetUrl = determineTargetUrl(authentication);
                    response.sendRedirect(targetUrl);
                })
                .failureUrl("/login/error")
                .usernameParameter("email")
                .passwordParameter("pass");


        http.logout()
                .logoutUrl("/auth/logoff")
                .logoutSuccessUrl("/loginSTS");
    }

}