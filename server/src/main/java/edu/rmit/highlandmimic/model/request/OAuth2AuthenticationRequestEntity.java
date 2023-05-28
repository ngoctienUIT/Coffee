package edu.rmit.highlandmimic.model.request;

import lombok.Builder;
import lombok.Data;
import lombok.NonNull;

@Data
@Builder
public class OAuth2AuthenticationRequestEntity {

    @NonNull
    private String oauth2ProviderUserId;

    @NonNull
    private String oauth2ProviderUserIdentity;

    @NonNull
    private String oauth2ProviderAccessToken;

    @NonNull
    private String oauth2ProviderProviderName;
}
