package edu.rmit.highlandmimic.common;

import lombok.Builder;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Stream;

@Slf4j
public class ExceptionLogger {

    public static final String LOG_NOT_IMPLEMENTED = "Feature is not implemented yet or being implemented.";
    public static final String LOG_OAUTH2_INVALID_USER_IDENTITY = "Invalid user identity. This could be caused since the user is not linked with any OAuth2 provider.";

    private enum ExceptionTag {
        INVALID_ACTION,
        UNEXPECTED_ISSUE
    }

    public static void logInvalidAction(Exception e) {
        logException(ExceptionTag.INVALID_ACTION, e);
    }
    public static void logUnexpectedIssue(Exception e) { logException(ExceptionTag.UNEXPECTED_ISSUE, e);}

    private static void logException(ExceptionTag tag, Exception e) {
        ResponseException response = ResponseException.fromExceptionObject(e);
        log.warn(getExceptionTag(tag) + "\u001B[93m %s \u001B[0m: \u001B[3;97m\"%s\"\u001B[0m".formatted(response.getExceptionName(), response.getMessage()));
        log.warn("\t\tThis is caused by: " + response.getClassName() + "::"  + response.getMethodName() + "@line:" + response.getLineNumber());
        log.warn("\t\tStack trace could be helpful:");
        response.getStackTrace().stream().limit(25).forEach(line -> log.warn("\t\t\t| " + line));
    }

    private static String getExceptionTag(ExceptionTag tag) {
        return "\u001B[1;91m[%s]\u001B[0m".formatted(tag.name());
    }

    public static ResponseEntity<String> getNotImplementedResponse() {
        return new ResponseEntity<>(LOG_NOT_IMPLEMENTED, HttpStatus.NOT_IMPLEMENTED);
    }

    @Data
    @Builder
    public static class ResponseException {
        private LocalDateTime dateTime;
        private String exceptionName;
        private String message;
        private String className;
        private String methodName;
        private Integer lineNumber;
        private List<String> stackTrace;

        public static ResponseException fromExceptionObject(Exception e) {
            return ResponseException.builder()
                    .message(e.getMessage())
                    .exceptionName(e.getClass().getSimpleName())
                    .dateTime(LocalDateTime.now())
                    .stackTrace(
                            Stream.of(e.getStackTrace())
                                    .map(stackTrace -> "Line %d - %s::%s".formatted(
                                            stackTrace.getLineNumber(),
                                            stackTrace.getClassName(),
                                            stackTrace.getMethodName()
                                    )).toList()
                    ).lineNumber(e.getStackTrace()[0].getLineNumber())
                    .className(e.getStackTrace()[0].getClassName())
                    .methodName(e.getStackTrace()[0].getMethodName())
                    .build();
        }
    }

}
