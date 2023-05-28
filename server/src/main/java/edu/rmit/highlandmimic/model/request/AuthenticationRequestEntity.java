package edu.rmit.highlandmimic.model.request;

import lombok.Builder;
import lombok.Data;
import org.springframework.lang.NonNull;

@Data
@Builder
public class AuthenticationRequestEntity {

    @NonNull
    private String loginIdentity;

    @NonNull
    private String hashedPassword;
}
