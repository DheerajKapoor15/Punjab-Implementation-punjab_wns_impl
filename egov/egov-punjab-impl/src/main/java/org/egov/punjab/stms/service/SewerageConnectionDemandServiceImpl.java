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
 * 	1) All versions of this program, verbatim or modified must carry this
 * 	   Legal Notice.
 *
 * 	2) Any misrepresentation of the origin of the material is prohibited. It
 * 	   is required that all modified versions of this material be marked in
 * 	   reasonable ways as different from the original version.
 *
 * 	3) This license does not grant any rights to any user of the program
 * 	   with regards to rights under trademark law for use of the trade names
 * 	   or trademarks of eGovernments Foundation.
 *
 *   In case of any queries, you can reach eGovernments Foundation at contact@egovernments.org.
 ******************************************************************************/
package org.egov.punjab.stms.service;

import java.util.List;

import javax.persistence.ParameterMode;

import org.apache.log4j.Logger;
import org.egov.infra.exception.ApplicationRuntimeException;
import org.egov.infstr.services.PersistenceService;
import org.egov.stms.entity.SewerageBatchJobDetails;
import org.egov.stms.service.SewerageBatchJobDetailsService;
import org.egov.stms.service.demand.SewerageConnectionDemandService;
import org.egov.stms.utils.constants.SewerageTaxConstants;
import org.hibernate.procedure.ProcedureCall;
import org.hibernate.procedure.ProcedureOutputs;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author venki.b
 *
 */
@Service("sewerageConnectionDemandService")
public class SewerageConnectionDemandServiceImpl implements SewerageConnectionDemandService {

    private static final Logger LOGGER = Logger.getLogger(SewerageConnectionDemandServiceImpl.class);

    @Autowired
    private SewerageBatchJobDetailsService sewerageBatchJobDetailsService;

    @Autowired
    @Qualifier("persistenceService")
    protected PersistenceService persistenceService;

    @SuppressWarnings({ "unused", "unchecked" })
    @Override
    @Transactional(timeout=1800)
    public void bulkDemandGeneration() {

        List<SewerageBatchJobDetails> jobDetails = sewerageBatchJobDetailsService
                .findActiveJobDetailsByJobType(SewerageTaxConstants.DEMAND);
        ProcedureCall procedureCall = null;
        ProcedureOutputs procedureOutputs = null;
        if (jobDetails != null) {

            for (SewerageBatchJobDetails jd : jobDetails) {

                if (LOGGER.isDebugEnabled())
                    LOGGER.debug("Starting sewerage tax bulk demand generation for " + jd.getInstallment().getDescription() + " "
                            + jd.getBatchName() + " " + jd.getBoundaryType());

                procedureCall = persistenceService.getSession()
                        .createStoredProcedureCall("stms_demand_genaration");
                procedureCall.registerParameter("batch_name", String.class, ParameterMode.IN);
                procedureCall.getParameterRegistration("batch_name").bindValue(jd.getBatchName());
                procedureCall.registerParameter("boundary_type", String.class, ParameterMode.IN);
                procedureCall.getParameterRegistration("boundary_type").bindValue(jd.getBoundaryType());
                procedureCall.registerParameter("curr_installment_description", String.class, ParameterMode.IN);
                procedureCall.getParameterRegistration("curr_installment_description")
                        .bindValue(jd.getInstallment().getDescription());
                procedureCall.registerParameter("batch_id", long.class, ParameterMode.IN);
                procedureCall.getParameterRegistration("batch_id").bindValue(jd.getId());
                if (procedureCall != null) {
                    try {
                        procedureOutputs = procedureCall.getOutputs();
                    } catch (Exception e) {
                        throw new ApplicationRuntimeException(e.getMessage());
                    }
                }

                jd.setActive(false);

                sewerageBatchJobDetailsService.update(jd);

                if (LOGGER.isDebugEnabled())
                    LOGGER.debug("Completed sewerage tax bulk demand generation for " + jd.getInstallment().getDescription() + " "
                            + jd.getBatchName() + " " + jd.getBoundaryType());
            }
        }

    }
}