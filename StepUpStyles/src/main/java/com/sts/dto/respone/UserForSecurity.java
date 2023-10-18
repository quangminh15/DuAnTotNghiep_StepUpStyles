package com.sts.dto.respone;

import javax.persistence.ConstructorResult;

public class UserForSecurity {
    public Integer usersId;
    public String  pass;
    public String role;
    public String email;

    public Integer getUsersId() {
        return usersId;
    }

    public void setUsersId(Integer usersId) {
        this.usersId = usersId;
    }

    public String getPassword() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public UserForSecurity(Integer usersId, String pass, String role, String email) {
        this.usersId = usersId;
        this.pass = pass;
        this.role = role;
        this.email = email;
    }
}
