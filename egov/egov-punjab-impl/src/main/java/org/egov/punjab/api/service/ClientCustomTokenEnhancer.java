package org.egov.punjab.api.service;

import java.util.Map;

import java.util.HashMap;

import org.apache.commons.collections4.map.HashedMap;
import org.egov.commons.entity.Source;
import org.egov.infra.config.security.authentication.userdetail.CurrentUser;
import org.egov.infra.rest.support.CustomTokenEnhancer;
import org.springframework.security.oauth2.common.DefaultOAuth2AccessToken;
import org.springframework.security.oauth2.common.OAuth2AccessToken;
import org.springframework.security.oauth2.provider.OAuth2Authentication;

public class ClientCustomTokenEnhancer implements CustomTokenEnhancer{

    private static final String SOURCE = "source";
    private static final String USER_ID = "userid";
/*    private static final String ESEVA_CLIENT = "eseva-client";
    private static final String APONLINE_CLIENT = "aponline-client";
    private static final String BILLDESK_CLIENT = "billdesk-client";
    private static final String PAYTM_CLIENT = "paytm-client";
    private static final String SMARTVIZAG_CLIENT = "smartvizag-client";
    private static final String ANYEMI_CLIENT = "anyemi-client";
*/    
    private static final String PMIDC_CLIENT = "pmidc-client";
    private static final String TEST_CLIENT = "test-client";
    private static final String AIRTEL_CLIENT = "airtel-client";
    private static final String FREECHARGE_CLIENT = "freecharge-client";
    private static final String PAYTM_CLIENT = "paytm-client";
    private static final String SEWAKENDRA_CLIENT = "sewakendra-client";
    private static final String PAYU_CLIENT = "payu-client";
    private static final String POS_CLIENT = "pos-client";
    private static final String BBPS_CLIENT = "bbps-client";
    private static final Map<String, Object> CLIENT_SOURCE_MAPPING = new HashMap<>();

    @Override
    public OAuth2AccessToken enhance(OAuth2AccessToken accessToken, OAuth2Authentication authentication) {
        final DefaultOAuth2AccessToken token = (DefaultOAuth2AccessToken) accessToken;
        final Map<String, Object> additionalInfo = new HashedMap<>();
        additionalInfo.put(SOURCE, CLIENT_SOURCE_MAPPING.get(authentication.getOAuth2Request().getClientId()));
        CurrentUser currentUser = (CurrentUser) authentication.getPrincipal();
        Long userId = currentUser.getUserId();
        additionalInfo.put(USER_ID, userId);
        token.setAdditionalInformation(additionalInfo);
        return token;
    }

    public ClientCustomTokenEnhancer() {
/*        CLIENT_SOURCE_MAPPING.put(ANYEMI_CLIENT, Source.ANYEMI);
        CLIENT_SOURCE_MAPPING.put(SMARTVIZAG_CLIENT, Source.SMARTVIZAG);
        CLIENT_SOURCE_MAPPING.put(PAYTM_CLIENT, Source.PAYTM);
        CLIENT_SOURCE_MAPPING.put(BILLDESK_CLIENT, Source.BILLDESK);
        CLIENT_SOURCE_MAPPING.put(APONLINE_CLIENT, Source.APONLINE);
        CLIENT_SOURCE_MAPPING.put(ESEVA_CLIENT, Source.ESEVA);
*/
        CLIENT_SOURCE_MAPPING.put(PMIDC_CLIENT, Source.PMIDC);
        CLIENT_SOURCE_MAPPING.put(TEST_CLIENT, Source.PMIDC);
        CLIENT_SOURCE_MAPPING.put(AIRTEL_CLIENT, Source.AIRTEL);
        CLIENT_SOURCE_MAPPING.put(FREECHARGE_CLIENT, Source.FREECHARGE);
        CLIENT_SOURCE_MAPPING.put(PAYTM_CLIENT, Source.PAYTM);
        CLIENT_SOURCE_MAPPING.put(SEWAKENDRA_CLIENT, Source.SEWAKENDRA);
        CLIENT_SOURCE_MAPPING.put(PAYU_CLIENT, Source.PAYU);
        CLIENT_SOURCE_MAPPING.put(POS_CLIENT, Source.POS);
        CLIENT_SOURCE_MAPPING.put(BBPS_CLIENT, Source.BBPS);
    }

}
