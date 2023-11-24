package com.sts.model.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class DataOTP {
    String input1;
    String input2;
    String input3;
    String input4;

    public String toString(){
        return String.valueOf(input1)+String.valueOf(input2)+String.valueOf(input3)+String.valueOf(input4);
    }
}
