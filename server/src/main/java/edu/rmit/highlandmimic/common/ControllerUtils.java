package edu.rmit.highlandmimic.common;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;
import org.springframework.http.ResponseEntity;

import java.util.Map;
import java.util.NoSuchElementException;
import java.util.function.Supplier;

import static edu.rmit.highlandmimic.common.ExceptionLogger.logInvalidAction;

@NoArgsConstructor(access = AccessLevel.PRIVATE)
public class ControllerUtils {

    private static final Map<Class<?>, ?> exceptionalResponseMappings = Map.of(
            NoSuchElementException.class, ResponseEntity.notFound(),
            NullPointerException.class, ResponseEntity.notFound(),
            IllegalArgumentException.class, ResponseEntity.badRequest(),
            NoSuchFieldException.class, ResponseEntity.badRequest(),
            UnsupportedOperationException.class, ResponseEntity.internalServerError()
    );

    public static ResponseEntity<?> controllerWrapper(Supplier<?> controllerExecution) {
        try {
            return ResponseEntity.ok(controllerExecution.get());
        } catch (Exception e) {
            logInvalidAction(e);
            return switchExceptionsResponse(e);
        }
    }

    public static ResponseEntity<?> controllerWrapper(Runnable controllerExecution) {
        try {
            controllerExecution.run();
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            logInvalidAction(e);
            return switchExceptionsResponse(e);
        }
    }

    private static ResponseEntity<?> switchExceptionsResponse(Exception e) {
        return (exceptionalResponseMappings.containsKey(e.getClass()))
                ? ((ResponseEntity.BodyBuilder) exceptionalResponseMappings.get(e.getClass())).body(e.getMessage())
            : ResponseEntity.internalServerError().body(ExceptionLogger.ResponseException.fromExceptionObject(e));
    }
}
