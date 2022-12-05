package org.egov.punjab.api.service;

import static org.apache.commons.lang3.StringUtils.isBlank;
import static org.apache.commons.lang3.StringUtils.isNotBlank;
import static org.egov.infra.config.core.ApplicationThreadLocals.getCityCode;
import static org.egov.infra.config.core.ApplicationThreadLocals.setCityCode;
import static org.egov.infra.config.core.ApplicationThreadLocals.setDomainName;
import static org.egov.infra.config.core.ApplicationThreadLocals.setTenantID;
import static org.egov.infra.config.core.ApplicationThreadLocals.setDomainURL;
import static org.egov.infra.config.core.ApplicationThreadLocals.setCityName;
import static org.egov.infra.config.core.ApplicationThreadLocals.setMunicipalityName;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.IOUtils;
import org.egov.infra.admin.master.entity.City;
import org.egov.infra.admin.master.service.CityService;
import org.egov.infra.exception.ApplicationRuntimeException;
import org.egov.infra.exception.UlbNotFoundException;
import org.egov.infra.rest.support.APIRequestEnricher;
import org.egov.punjab.api.support.MultiReadRequestWrapper;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

import com.google.common.base.Charsets;

public class ClientAPIRequestEnricher implements APIRequestEnricher {
    private static final Logger LOG = LoggerFactory.getLogger(ClientAPIRequestEnricher.class);

    private static final String SOURCE = "source";
    private static final String ULB_CODE = "ulbCode";
    private static final String REST_API_ULB_CODE_NOT_FOUND = "RESTAPI.001";

    @Autowired
    private CityService cityService;

    @Autowired
    @Qualifier("ulbCodeMap")
    private Map<String, String> ulbCodeMap;

    @Override
    public ServletRequest enrich(ServletRequest request) {
        MultiReadRequestWrapper multiReadRequestWrapper = new MultiReadRequestWrapper((HttpServletRequest) request);
        String ulbCode = validateAndExtractULBCode(multiReadRequestWrapper);
        if (isNotBlank(ulbCode)) {
            boolean diffDestination = !ulbCode.equals(getCityCode());
            if (LOG.isInfoEnabled())
                LOG.info("Requested ULB Code :- reached : {}, destination : {}. Altering tenant info : {}",
                        getCityCode(), ulbCode, diffDestination);
            if (diffDestination) {
                String tenantId = ulbCodeMap.get(ulbCode);
                setTenantID(tenantId);
                City city = cityService.getCityByCode(ulbCode);
                if (city == null) {
                    throw new UlbNotFoundException(REST_API_ULB_CODE_NOT_FOUND);
                }
                setDomainName(city.getDomainURL());
                setDomainURL("https://" +city.getDomainURL());
                setCityCode(ulbCode);
                setCityName(city.getName());
                setMunicipalityName(city.getPreferences() != null ? city.getPreferences().getMunicipalityName() : city.getName());
            }
        } else {
            throw new UlbNotFoundException(REST_API_ULB_CODE_NOT_FOUND);
        }
            
        
            
        return multiReadRequestWrapper;
    }

    private String validateAndExtractULBCode(MultiReadRequestWrapper request) {

        String ulbCode = request.getParameter(ULB_CODE);
        try {
            return isBlank(ulbCode) ? new JSONObject(IOUtils.toString(request.getInputStream(), Charsets.UTF_8))
                    .get(ULB_CODE).toString() : ulbCode;
        } catch (IOException ex) {
            throw new ApplicationRuntimeException(REST_API_ULB_CODE_NOT_FOUND);
        }
    }
}
