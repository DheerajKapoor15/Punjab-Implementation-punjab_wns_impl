/*******************************************************************************
 * eGov suite of products aim to improve the internal efficiency,transparency,
 *    accountability and the service delivery of the government  organizations.
 *
 *     Copyright (C) <2015>  eGovernments Foundation
 *
 *     The updated version of eGov suite of products as by eGovernments Foundation
 *     is available at http://www.egovernments.org
 *
 *     This program is free software: you can redistribute it and/or modify
 *     it under the terms of the GNU General Public License as published by
 *     the Free Software Foundation, either version 3 of the License, or
 *     any later version.
 *
 *     This program is distributed in the hope that it will be useful,
 *     but WITHOUT ANY WARRANTY; without even the implied warranty of
 *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *     GNU General Public License for more details.
 *
 *     You should have received a copy of the GNU General Public License
 *     along with this program. If not, see http://www.gnu.org/licenses/ or
 *     http://www.gnu.org/licenses/gpl.html .
 *
 *     In addition to the terms of the GPL license to be adhered to in using this
 *     program, the following additional terms are to be complied with:
 *      1) All versions of this program, verbatim or modified must carry this
 *         Legal Notice.
 *
 *      2) Any misrepresentation of the origin of the material is prohibited. It
 *         is required that all modified versions of this material be marked in
 *         reasonable ways as different from the original version.
 *
 *      3) This license does not grant any rights to any user of the program
 *         with regards to rights under trademark law for use of the trade names
 *         or trademarks of eGovernments Foundation.
 *
 *   In case of any queries, you can reach eGovernments Foundation at contact@egovernments.org.
 ******************************************************************************/
package org.egov.punjab.wtms.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.apache.log4j.Logger;
import org.egov.infra.utils.DateUtils;
import org.egov.wtms.application.entity.WaterConnectionDetails;
import org.egov.wtms.application.service.WaterConnectionDetailsService;
import org.egov.wtms.service.applications.WaterApplicationsExeDateUpdateService;
import org.egov.wtms.utils.WaterTaxUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("waterApplicationsExeDateUpdateService")
public class WaterApplicationsUpdateExeDateServiceImpl implements WaterApplicationsExeDateUpdateService {

    private static final Logger LOGGER = Logger.getLogger(WaterApplicationsUpdateExeDateServiceImpl.class);

    @Autowired
    private WaterConnectionDetailsService waterConnectionDetailsService;

    @Autowired
    private WaterTaxUtils waterTaxUtils;

    @Override
    @Transactional
    public void bulkApplicationsExeDateUpdate() {

        List<WaterConnectionDetails> waterConnectionList;
        if (waterConnectionDetailsService != null) {
            waterConnectionList = waterConnectionDetailsService.getWaterApplicationsToUpdateExecutionDate();
            List<WaterConnectionDetails> filteredWaterConnections = updateExecutionDate(waterConnectionList);
            if (filteredWaterConnections != null && !filteredWaterConnections.isEmpty())
                waterConnectionDetailsService.updateWaterConnections(filteredWaterConnections);
        }
    }

    private List<WaterConnectionDetails> updateExecutionDate(List<WaterConnectionDetails> waterConnectionList) {
        int days = waterTaxUtils.getAppconfigValueToUpdateExecutionDate();
        List<WaterConnectionDetails> list = new ArrayList<>();
        if (waterConnectionList != null && !waterConnectionList.isEmpty())
            for (WaterConnectionDetails details : waterConnectionList) {
				int betweenDays = DateUtils.daysBetween(details.getState().getLastModifiedDate(), new Date()) + 1;
                if (days < betweenDays) {
                    details.setExecutionDate(DateUtils.addDays(details.getState().getLastModifiedDate(), days));
                    list.add(details);
                }
            }
        return list;
    }
}