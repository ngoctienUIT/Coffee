package edu.rmit.highlandmimic.model.request;

import edu.rmit.highlandmimic.model.User;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class UserRequestEntity {
    private String username;

    private String displayName;

    @Builder.Default
    private Boolean isMale = true;

    private String birthOfDate;

    private String email;
    private String phoneNumber;

    private String hashedPassword;

    private String imageUrl;

    @Builder.Default
    private User.UserRole userRole = User.UserRole.CUSTOMER;

}
