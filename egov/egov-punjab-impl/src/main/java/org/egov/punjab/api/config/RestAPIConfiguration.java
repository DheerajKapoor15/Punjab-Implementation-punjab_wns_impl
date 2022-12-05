package org.egov.punjab.api.config;

import org.egov.infra.rest.support.APIRequestEnricher;
import org.egov.punjab.api.service.ClientAPIRequestEnricher;
import org.springframework.beans.factory.annotation.Autowire;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.core.env.ConfigurableEnvironment;
import org.springframework.core.env.MapPropertySource;

import java.util.HashMap;
import java.util.Map;

import static org.apache.commons.lang3.StringUtils.substringAfter;

@Configuration
public class RestAPIConfiguration {

    @Autowired
    private ConfigurableEnvironment environment;

    @Bean(name = "ulbCodeMap", autowire = Autowire.BY_NAME)
    public Map<String, String> ulbCodeMap() {
        Map<String, String> ulbCodeMap = new HashMap<>();
        environment.getPropertySources().iterator().forEachRemaining(propertySource -> {
            if (propertySource instanceof MapPropertySource)
                ((MapPropertySource) propertySource).getSource().forEach((key, value) -> {
                    if (key.startsWith("ulbcode."))
                        ulbCodeMap.put(value.toString(), substringAfter(key, "."));
                });
        });
        return ulbCodeMap;
    }

    @Bean
    @Primary
    public APIRequestEnricher clientAPIRequestEnricher() {
        return new ClientAPIRequestEnricher();
    }
}
