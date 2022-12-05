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

import static org.egov.wtms.utils.constants.WaterTaxConstants.APPLICATION_STATUS_VERIFIED;
import static org.egov.wtms.utils.constants.WaterTaxConstants.MODULETYPE;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.egov.eis.entity.Assignment;
import org.egov.eis.service.AssignmentService;
import org.egov.eis.service.DesignationService;
import org.egov.infra.admin.master.entity.User;
import org.egov.infra.admin.master.service.DepartmentService;
import org.egov.infra.security.utils.SecurityUtils;
import org.egov.infra.utils.DateUtils;
import org.egov.wtms.application.entity.WaterTitleTransfer;
import org.egov.wtms.application.entity.WaterConnectionDetails;
import org.egov.wtms.application.service.WaterTitleTransferService;
import org.egov.wtms.application.service.WaterConnectionDetailsService;
import org.egov.wtms.service.applications.WaterApplicationsForwardService;
import org.egov.wtms.utils.WaterTaxUtils;
import org.egov.wtms.utils.constants.WaterTaxConstants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("waterApplicationsForwardService")
public class WaterApplicationsForwardServiceImpl implements WaterApplicationsForwardService {

    private static final Logger LOGGER = Logger.getLogger(WaterConnectionBillServiceImpl.class);

    @Autowired
    private WaterConnectionDetailsService waterConnectionDetailsService;
    
    @Autowired
    private WaterTitleTransferService titleTransferWaterConnectionDetailsService;

    @Autowired
    private AssignmentService assignmentService;

    @Autowired
    private DepartmentService departmentService;

    @Autowired
    private DesignationService designationService;

    @Autowired
    private WaterTaxUtils waterTaxUtils;

    @Autowired
    private SecurityUtils securityUtils;

    @Override
    @Transactional
    public void bulkWaterApplicationsForward() {

        List<WaterConnectionDetails> waterConnectionList = null;
        List<WaterTitleTransfer> titletransferwaterConnectionList = null;

        if (waterConnectionDetailsService != null)
            waterConnectionList = waterConnectionDetailsService
                    .getWaterApplicationsToForwardToXen(waterTaxUtils.getWaterTaxApproveDepartmentName(),
                            WaterTaxConstants.DESIG_NAME_JUNIOR_ENGINEER);
        
        if (titleTransferWaterConnectionDetailsService != null)
        	titletransferwaterConnectionList = titleTransferWaterConnectionDetailsService
                    .getWaterApplicationsToForwardToXen(waterTaxUtils.getWaterTaxApproveDepartmentName(),
                            WaterTaxConstants.DESIG_NAME_JUNIOR_ENGINEER);
        
        List<WaterConnectionDetails> filterConnectionList = null;
        filterConnectionList = filterApplicationsBySlaDays(waterConnectionList);

        List<WaterTitleTransfer> titletransferfilterConnectionList = null;
        titletransferfilterConnectionList = filterApplicationsBySlaDaystitletransfer(titletransferwaterConnectionList);
        
        long depId = departmentService.getDepartmentByName(waterTaxUtils.getWaterTaxApproveDepartmentName()).getId();
        long desId = designationService.getDesignationByName(waterTaxUtils.getWaterTaxApproveDesignationName()).getId();
        final User user = securityUtils.getCurrentUser();
        List<Assignment> assignment = assignmentService.getAllPositionsByDepartmentAndDesignationForGivenRange(depId, desId,
                new Date());
        if (filterConnectionList != null && !filterConnectionList.isEmpty())
            for (int i = 0; i < filterConnectionList.size(); i++) {
                WaterConnectionDetails waterDetails = filterConnectionList.get(i);

                waterDetails.setStatus(waterTaxUtils.getStatusByCodeAndModuleType(
                        APPLICATION_STATUS_VERIFIED, MODULETYPE));

                waterDetails.transition().progressWithStateCopy()
                        .withSenderName(user.getUsername() + "::" + user.getName())
                        .withComments("This application is auto escalated by system")
                        .withStateValue("Verified").withDateInfo(new Date()).withOwner(assignment.get(0).getPosition())
                        .withNextAction("Approval pending")
                        .withNatureOfTask(WaterTaxConstants.NEW_APPLICATION_NATURE_OF_TASK);
            }
        
        if (titletransferfilterConnectionList != null && !titletransferfilterConnectionList.isEmpty())
            for (int i = 0; i < titletransferfilterConnectionList.size(); i++) {
            	WaterTitleTransfer waterDetails = titletransferfilterConnectionList.get(i);

                waterDetails.setStatus(waterTaxUtils.getStatusByCodeAndModuleType(
                        APPLICATION_STATUS_VERIFIED, MODULETYPE));

                waterDetails.transition().progressWithStateCopy()
                        .withSenderName(user.getUsername() + "::" + user.getName())
                        .withComments("This application is auto escalated by system")
                        .withStateValue("Verified").withDateInfo(new Date()).withOwner(assignment.get(0).getPosition())
                        .withNextAction("Approval pending")
                        .withNatureOfTask(WaterTaxConstants.TITLE_TRANSFER_NATURE_OF_TASK);
            }
    }

    private List<WaterConnectionDetails> filterApplicationsBySlaDays(List<WaterConnectionDetails> waterConnectionList) {
        List<WaterConnectionDetails> list = new ArrayList<>();
        int days = waterTaxUtils.getAppconfigValueForApplicationsHasToForward();
        for (WaterConnectionDetails details : waterConnectionList) {
			int betweenDays = DateUtils.daysBetween(details.getState().getLastModifiedDate(), new Date()) + 1;
            if (days < betweenDays)
                list.add(details);
        }
        return list;
    }
    
    private List<WaterTitleTransfer> filterApplicationsBySlaDaystitletransfer(List<WaterTitleTransfer> titletransferwaterConnectionList) {
        List<WaterTitleTransfer> list = new ArrayList<>();
        int days = waterTaxUtils.getAppconfigValueForApplicationsHasToForward();
        for (WaterTitleTransfer details : titletransferwaterConnectionList) {
			int betweenDays = DateUtils.daysBetween(details.getState().getLastModifiedDate(), new Date()) + 1;
            if (days < betweenDays)
                list.add(details);
        }
        return list;
    }
}