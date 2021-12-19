package com.cos.photogram.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.resource.PathResourceResolver;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer{ // 웹 설정 파일

	@Value("${file.path}")
	private String uploadFolder;
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		WebMvcConfigurer.super.addResourceHandlers(registry);

		// D:/workspace/springbootwork/upload/ => jsp파일에서 /upload/ 경로를 만나면 무조건 full 경로로 대체됨.
		registry
		.addResourceHandler("/upload/**") // jsp 페이지에서 url 패턴 : /upload/ 패턴의 경로 -> 낚아챔
		.addResourceLocations("file:///"+uploadFolder) // 실제 물리적인 경로
		.setCachePeriod(60*10*6) // 1 시간.
		.resourceChain(true)
		.addResolver(new PathResourceResolver());
	}
}
