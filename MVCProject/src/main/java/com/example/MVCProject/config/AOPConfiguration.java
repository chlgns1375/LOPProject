package com.example.MVCProject.config;


import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class AOPConfiguration {
	Logger logger =  LoggerFactory.getLogger(AOPConfiguration.class);
	
	//�ش� �޼��� �����ϱ� ��
	@Before("execution(* com.example.MVCProject.controller.*.*(..))")
    public void logBefore(JoinPoint joinPoint) {
		logger.info("contoller: [" + joinPoint.getSignature()+"]");
    }
	
	//�ش� �޼��� �����ϱ� ��
	@After("execution(* com.example.MVCProject.service.*.*(..))")
    public void logAfter(JoinPoint joinPoint) {
		logger.info("service: [" + joinPoint.getSignature()+"]");
    }
	
	//�ش� �޼��忡�� �������� ����ǰ� ��ȯ �� �Ŀ� Advice ����
	@AfterReturning(pointcut = "execution(* com.example.MVCProject.controller.*.*(..))", returning = "result")
    public void logAfterReturning(JoinPoint joinPoint, Object result) {
		logger.info("AfterReturning: " + joinPoint.getSignature().getName() + " result: " + result);
    }
	
	
	//�ش� �޼��忡�� ���ܰ� �߻��� ��� Advice ����
	@AfterThrowing(pointcut = "execution(* com.example.MVCProject.controller.*.*(..))", throwing = "e")
    public void logAfterThrowing(JoinPoint joinPoint, Throwable e) {
		logger.error("AfterThrowing: " + joinPoint.getSignature().getName() + " exception: " + e.getMessage());
    }
}
