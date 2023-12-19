package com.sts.model.DTO;

import java.time.LocalDate;

public interface DResponseUser {
    public Boolean getActivaties();
    public String getAddress();
    public LocalDate getBirthday();
    public LocalDate getCreatedDate();
    public String getEmail();
    public String getFullName();
    public String getImage();
    public String getPhone();
    public String getRole();
    public Boolean getStatus();
}
