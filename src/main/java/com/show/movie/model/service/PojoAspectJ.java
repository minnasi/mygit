package com.show.movie.model.service;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;


@Aspect
public class PojoAspectJ {
	
	public PojoAspectJ(){
		System.out.println("::" + getClass() + " default Construct");
	}

		@Around("execution(* com.show.movie.model.dao..*(..))")
		public Object invoke(ProceedingJoinPoint joinPoint) throws Throwable {
			System.out.println("-------------------------------------------------------");
			System.out.println("[Log] 호출 METHOD :"+joinPoint.getSignature().toShortString());
			if(joinPoint.getArgs().length !=0){
				System.out.println("[Log] 받은 parameter: "+ joinPoint.getArgs()[0]);
			}
			Object obj = null;
			try {
				obj = joinPoint.proceed();
			}catch (Exception e) {
				System.out.println("[Log] 오류 : "+ joinPoint.getTarget()+"에서 오류남 !");
			}

			System.out.println("[Log] DB 에서 나온 값  : "+obj);
			System.out.println("-------------------------------------------------------");

			return obj;
		}
}
