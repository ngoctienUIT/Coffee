package edu.rmit.highlandmimic.common;

import com.nimbusds.jwt.JWT;
import edu.rmit.highlandmimic.model.User;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwt;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.impl.DefaultClaims;
import org.springframework.security.oauth2.jwt.JwtDecoder;

import java.util.Date;

public class JwtUtils {

    private static final long EXPIRE_DURATION_1_HOUR = 60 * 60 * 1000;

    public static String issueAuthenticatedAccessToken(User documentUserEntity) {
        return Jwts.builder()
                .setSubject(documentUserEntity.getUserId() + "~" + documentUserEntity.getUserRole())
                .setIssuedAt(new Date())
                .setExpiration(new Date(System.currentTimeMillis() + EXPIRE_DURATION_1_HOUR))
                .compact();
    }

    public static DefaultClaims decodeJwtToken(String jwtToken) {
        return (DefaultClaims) Jwts.parserBuilder()
                .build()
                .parse(jwtToken)
                .getBody();
    }

}
