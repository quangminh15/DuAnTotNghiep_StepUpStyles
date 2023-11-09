package com.sts.model.DTO;

import java.time.LocalDate;

public interface LResponseUser {
    public Integer getUsersId();
    public String getFullName();
    public String getEmail();
    public String getPhone();
    public LocalDate getBirthday();
    public String getRole();
    public Boolean getStatus();
    public Boolean getActivaties();
    public String getImage();
    public String getOrigin();
    public LocalDate getCreatedDate();
    public String getAddress();
}