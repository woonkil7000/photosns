package com.cos.photogram.web.dto.subscribe;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigInteger;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class SubscribeDto {
	private int userId;
	private String username;
	private String name;
	private String profileImageUrl;
	private BigInteger subscribeState; // mariadb에서는 Integer
	private BigInteger equalUserState;
//	private int subscribeState;
//	private int equalUserState;

}
