package com.clara.blog.model;

import lombok.Data;

@Data
public class KakaoProfile {
	public long id;
	public String connected_at;
	public Properties properties;
	public KakaoAccount kakao_account;

	@Data
	public class Properties {
		public String nickname;
		public String profile_image;
		public String thumbnail_image;
	}

	@Data
	public class KakaoAccount {
		public Boolean profile_nickname_needs_agreement;
		public Boolean profile_needs_agreement;
		public Boolean profile_image_needs_agreement;
		public Profile profile;
		public Boolean has_email;
		public Boolean email_needs_agreement;
		public Boolean is_email_valid;
		public Boolean is_email_verified;
		public String email;

		@Data
		public class Profile {
			public String nickname;
			public String thumbnail_image_url;
			public String profile_image_url;
			public boolean is_default_image;
		}
	}
}



/**
	"id":2149730009,
	"connected_at":"2022-03-07T05:41:29Z",
	"properties":{
	"nickname":"."
	},
	"kakao_account":{
	"profile_nickname_needs_agreement":false,
	"profile_image_needs_agreement":false,
	"profile":{
	"nickname":".",
	"thumbnail_image_url":"http://k.kakaocdn.net/dn/dpk9l1/btqmGhA2lKL/Oz0wDuJn1YV2DIn92f6DVK/img_110x110.jpg",
	"profile_image_url":"http://k.kakaocdn.net/dn/dpk9l1/btqmGhA2lKL/Oz0wDuJn1YV2DIn92f6DVK/img_640x640.jpg",
	"is_default_image":true
	},
	"has_email":true,
	"email_needs_agreement":false,
	"is_email_valid":true,
	"is_email_verified":true,
	"email":"hongcla9@gmail.com"
*/
