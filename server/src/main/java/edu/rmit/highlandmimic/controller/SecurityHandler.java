package edu.rmit.highlandmimic.controller;

import edu.rmit.highlandmimic.common.JwtUtils;
import edu.rmit.highlandmimic.model.User;
import edu.rmit.highlandmimic.repository.UserRepository;
import io.jsonwebtoken.impl.DefaultClaims;
import lombok.RequiredArgsConstructor;
import org.apache.logging.log4j.util.Strings;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Objects;
import java.util.Optional;
import java.util.function.Supplier;

import static edu.rmit.highlandmimic.common.ControllerUtils.controllerWrapper;
import static edu.rmit.highlandmimic.common.ExceptionLogger.logInvalidAction;

@Component
@RequiredArgsConstructor
public class SecurityHandler {

    public static final List<User.UserRole> ALLOW_AUTHORITIES = List.of(User.UserRole.STAFF, User.UserRole.ADMIN);
    public static final List<User.UserRole> ALLOW_STAKEHOLDERS = List.of(User.UserRole.STAFF, User.UserRole.ADMIN, User.UserRole.CUSTOMER);
    private final UserRepository userRepository;

    public ResponseEntity<?> roleGuarantee(String authenticationToken,
                                           Supplier<?> serviceExecutionSupplier,
                                           List<User.UserRole> allowedRoles) {
        User.UserRole requestUserRole;
        try {
            if (Strings.isBlank(authenticationToken)) {
                throw new NullPointerException("Action requires providing of the authentication token");
            }
            DefaultClaims claims = JwtUtils.decodeJwtToken(authenticationToken.split(" ")[1]);

            if (Objects.isNull(claims)) {
                throw new NullPointerException();
            }

            if (claims.getExpiration().getTime() < System.currentTimeMillis()) {
                throw new IllegalStateException("Expired jwt token");
            }

            String[] tokens = claims.getSubject().split("~");
            requestUserRole = User.UserRole.valueOf(tokens[1]);

            if(!checkIfUserIdIsExist(tokens[0]) || !checkIfRoleMatchesWithUser(tokens[0], User.UserRole.valueOf(tokens[1]))) {
                throw new IllegalArgumentException("Invalid user information");
            }

            if (!allowedRoles.contains(requestUserRole)) {
                throw new IllegalAccessException("User has insufficient privileges to perform this action");
            }
        } catch (Exception e) {
            logInvalidAction(e);
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body(e.getMessage());
        }

        return controllerWrapper(serviceExecutionSupplier);
    }

    private boolean checkIfUserIdIsExist(String userId) {
        return userRepository.existsByUserId(userId);
    }

    private boolean checkIfRoleMatchesWithUser(String userId, User.UserRole role) {
        return userRepository.findById(userId)
                .map(user -> user.getUserRole().equals(role))
                .orElseThrow(() -> new NullPointerException("Invalid user information"));
    }

}
