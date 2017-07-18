package com.fzy.test;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.fzy.demo.user.service.IUserService;


@RunWith(SpringJUnit4ClassRunner.class)  
@ContextConfiguration(locations = "classpath:applicationContext.xml")  
public class GetUserTest {
//    private IUserService userService;  
//    private static Logger logger = Logger.getLogger(GetUserTest.class);
//    @Before
//	public void before(){                                                                    
//		@SuppressWarnings("resource")
//		ApplicationContext context = new ClassPathXmlApplicationContext(new String[]{"classpath:conf/spring.xml"
//				,"classpath:conf/spring-mybatis.xml"});
//		userService = (UserService) context.getBean("userServiceImpl");
//	}
//    @Test  
//    public void test() { 
////    	UserModel c=new UserModel();
////    	c.setLogin_name("zhangsan");
////    	c.setLogin_password("123");
////        UserModel user = userService.checkLogin(c);
////        logger.info(user);  
//    }  
}
