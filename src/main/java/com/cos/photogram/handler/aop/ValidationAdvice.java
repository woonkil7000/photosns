package com.cos.photogram.handler.aop;

import com.cos.photogram.handler.ex.CustomValidationApiException;
import com.cos.photogram.handler.ex.CustomValidationException;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;

import java.util.HashMap;
import java.util.Map;

@Slf4j
@Component // Restcontoller, Service 가  Component 의 구현체다.
@Aspect
public class ValidationAdvice {

    @Around("execution(* com.cos.photogram.web.api.*Controller.*(..))") // Before, After
    public Object apiAdvice(ProceedingJoinPoint proceedingJoinPoint) throws Throwable{
        // proceedingJoinPoint => profile 함수의 모든곳에 접근할수 있는 변수
        // profile 함수보다 먼저 실행
        log.info("web api 콘트롤러 ##########################");

        Object[] args = proceedingJoinPoint.getArgs();
        for(Object arg : args){
            log.info("######### web api controller ##################### arg= {}",arg);
            if(arg instanceof BindingResult){
                log.info("web api controller :  BindingResult 유효성 검사를 하는 함수입니다.");
                BindingResult bindingResult = (BindingResult) arg;

                // 유효성 검사 공통 처리 bindingResult
                if(bindingResult.hasFieldErrors()){
                    Map<String, String> errorMap = new HashMap<>();

                    for(FieldError error:bindingResult.getFieldErrors()){
                        errorMap.put(error.getField(),error.getDefaultMessage());
                        System.out.println("=====================================");
                        System.out.println(error.getDefaultMessage());
                        System.out.println("=====================================");
                    }
                    throw new CustomValidationApiException("CustomValidationApiException 유효성 검사 실패함.",errorMap);

                }
            }
        }

        return proceedingJoinPoint.proceed(); // 이때 profile 함수가 실행됨
    }

    @Around("execution(* com.cos.photogram.web.*Controller.*(..))") // Before, After
    public Object advice(ProceedingJoinPoint proceedingJoinPoint) throws  Throwable{
        log.info("web 콘트롤러 ##########################");

        Object[] args = proceedingJoinPoint.getArgs();
        for(Object arg : args){
            //log.info("########## web controller ################# arg= {}",arg);

            if(arg instanceof BindingResult){
                BindingResult bindingResult = (BindingResult) arg;
                log.info("web controller : BindingResult 유효성 검사를 하는 함수입니다.");

                if(bindingResult.hasFieldErrors()){
			Map<String, String> errorMap = new HashMap<>();

			for(FieldError error:bindingResult.getFieldErrors()){
				errorMap.put(error.getField(),error.getDefaultMessage());
				System.out.println("=====================================");
				System.out.println(error.getDefaultMessage());
				System.out.println("=====================================");
			}
			throw new CustomValidationException("CustomValidationException 유효성 검사 실패함.",errorMap);
		}
            }
        }
        return proceedingJoinPoint.proceed();
    }
}
