package com.woonkil.photosns;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;

/*@SpringBootApplication
@EnableAutoConfiguration
@ComponentScan
@Configuration*/

/*@SpringBootApplication
public class PhotogramApplication extends SpringBootServletInitializer {

	// WAR 배포를 위해 수정된 부분
	public static void main(String[] args){
		SpringApplication app = new SpringApplication((com.woonkil.photosns.PhotogramApplication.class));
		app.run(args);
	}

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application){
		return application.sources(com.woonkil.photosns.PhotogramApplication.class);
	}
}*/

//@PropertySource(value = "classpath:/application.yml", encoding="UTF-8")
@EnableAutoConfiguration
@ComponentScan
@Configuration
@PropertySource(value = "classpath:/application.yml", encoding="UTF-8")
public class PhotogramApplication extends SpringBootServletInitializer {

	// WAR 배포를 위해 수정된 부분
	public static void main(String[] args){
		SpringApplication app = new SpringApplication((PhotogramApplication.class));
		app.run(args);
	}

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application){
		return application.sources(PhotogramApplication.class);
	}
}

/* 2022.03.06
public class PhotogramApplication extends SpringBootServletInitializer {

	// WAR 배포를 위해 수정된 부분
	public static void main(String[] args){
		SpringApplication app = new SpringApplication((com.cos.photogram.PhotogramApplication.class));
		app.run(args);
	}

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application){
		return application.sources(com.cos.photogram.PhotogramApplication.class);
	}
}
*/

/*

	@SpringBootApplication
	public class PhotogramApplication extends SpringBootServletInitializer {

		// WAR 배포를 위해 수정된 부분
		@Override
		protected SpringApplicationBuilder configure(SpringApplicationBuilder application){
			return application.sources(com.cos.photogram.PhotogramApplication.class);
		}

		public static void main(String[] args){
			SpringApplication app = new SpringApplication((com.cos.photogram.PhotogramApplication.class));
			app.run(args);
		}
*/

	/*
	public static void main(String[] args) {
		System.setProperty("spring.devtools.restart.enabled","false");
		System.setProperty("spring.devtools.livereload.enabled","true");
		SpringApplication.run(PhotogramApplication.class, args);
	}
*/

/*@SpringBootApplication
class Application extends SpringBootServletInitializer {

	// WAR 배포를 위해 수정된 부분
	// public class PhotogramApplication {

	// WAR 배포를 위해 수정된 부분
	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application){
		return application.sources(Application.class);
	}

	public static void main(String[] args){
		SpringApplication app = new SpringApplication((Application.class));
		app.run(args);
	}
	// 여기까지


//	public static void main(String[] args) {
//		System.setProperty("spring.devtools.restart.enabled","false");
//		System.setProperty("spring.devtools.livereload.enabled","true");
//		SpringApplication.run(PhotogramApplication.class, args);
//	}


}*/
