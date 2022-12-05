package org.egov.punjab.api.config;

import org.egov.infra.rest.support.CustomTokenEnhancer;
import org.egov.punjab.api.service.ClientCustomTokenEnhancer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class OAuth2ClientConfiguration {

    @Bean
    public CustomTokenEnhancer customTokenEnhancer() {
        return new ClientCustomTokenEnhancer();
    }

}
