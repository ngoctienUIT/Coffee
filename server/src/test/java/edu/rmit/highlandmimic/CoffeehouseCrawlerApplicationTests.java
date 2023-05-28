package edu.rmit.highlandmimic;

import edu.rmit.highlandmimic.common.JwtUtils;
import edu.rmit.highlandmimic.model.User;
import io.jsonwebtoken.Jwt;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ContextConfiguration;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

@Slf4j
@ContextConfiguration
@SpringBootTest
class CoffeehouseCrawlerApplicationTests {

    @Test
    void contextLoads() {
    }

    @Test
    void getContentFromUrl() throws NoSuchMethodException, InvocationTargetException, IllegalAccessException {
        UserDTO user = new UserDTO("admin", "admin");

//        user.setUsername("changed"); // setter is private, cannot access normally

        Class<?> clazz = user.getClass(); // đối tượng class biểu diễn cho lớp User

        System.out.println("Before change: " + user.getUsername());

        Method setterMethod = clazz.getDeclaredMethod("setUsername", String.class);

        setterMethod.setAccessible(true);
        System.out.println(setterMethod.getName());
        System.out.println(setterMethod.invoke(user, "testUser"));


        System.out.println("After change: " + user.getUsername());
    }

}

class UserDTO {
    private String username;
    private String password;

    public UserDTO(String u, String p) {
        this.username = u;
        this.password = p;
    }

    private void setUsername(String username) {
        this.username = username;
    }

    public String getUsername() {
        return username;
    }
}