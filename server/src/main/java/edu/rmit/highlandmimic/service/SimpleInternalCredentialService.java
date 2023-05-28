package edu.rmit.highlandmimic.service;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.NoSuchElementException;
import java.util.UUID;

@Slf4j
@Service
@RequiredArgsConstructor
public class SimpleInternalCredentialService {

    private final List<ResetRequestCredential> resetRequestCredentials;

    public ResetRequestCredential issueAndPersistResetCredential(String userEmail) {
        String uuid = UUID.randomUUID().toString();
        String tokenSource = UUID.randomUUID().toString();
        String resetToken = tokenSource.substring(tokenSource.length() - 6);
        ResetRequestCredential preparedCredential = new ResetRequestCredential(uuid, resetToken, userEmail);
        this.resetRequestCredentials.add(preparedCredential);

        return preparedCredential;
    }

    public String acceptResetCredential(String credential) {
        return this.resetRequestCredentials.stream()
                .filter(e -> e.getResetCredential().equalsIgnoreCase(credential))
                .findFirst()
                .map(e -> {
                    String issuedEmail = e.getIssuedUserIdentity();
                    resetRequestCredentials.remove(e);
                    return issuedEmail;
                }).orElseThrow();
    }

    public boolean isValid(String resetCredential, String resetToken) {

        return resetRequestCredentials.stream()
                .filter(e -> e.getResetCredential().equalsIgnoreCase(resetCredential))
                .findFirst()
                .map(e -> {
                    boolean result = e.getResetToken().equalsIgnoreCase(resetToken);
                    log.info("[VALIDATE@" + resetCredential + "] resetToken: "
                            + resetToken
                            + "; is matched with stored: " + e.getResetToken() + " => " + result);
                    return result;
                }).orElseThrow();
    }

    @AllArgsConstructor
    @Getter
    public static class ResetRequestCredential {
        private String resetCredential;
        private String resetToken;
        private String issuedUserIdentity;
    }

}

