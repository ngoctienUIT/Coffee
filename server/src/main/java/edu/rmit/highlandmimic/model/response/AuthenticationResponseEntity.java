package edu.rmit.highlandmimic.model.response;

import edu.rmit.highlandmimic.model.User;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class AuthenticationResponseEntity {

    private String requestedAccessToken;
    private User userInformation;

}
