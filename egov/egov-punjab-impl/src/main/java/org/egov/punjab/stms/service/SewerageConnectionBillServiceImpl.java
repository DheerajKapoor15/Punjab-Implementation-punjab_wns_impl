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
package org.egov.punjab.stms.service;

import static org.egov.wtms.utils.constants.WaterTaxConstants.DEMANDISHISTORY;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.ParameterMode;

import org.apache.log4j.Logger;
import org.egov.collection.constants.CollectionConstants;
import org.egov.collection.integration.models.BillAccountDetails;
import org.egov.commons.Installment;
import org.egov.commons.dao.InstallmentDao;
import org.egov.commons.dao.InstallmentHibDao;
import org.egov.demand.model.EgBill;
import org.egov.demand.model.EgBillDetails;
import org.egov.demand.model.EgDemand;
import org.egov.demand.model.EgDemandDetails;
import org.egov.infra.admin.master.entity.AppConfig;
import org.egov.infra.admin.master.entity.City;
import org.egov.infra.admin.master.entity.Module;
import org.egov.infra.admin.master.service.AppConfigService;
import org.egov.infra.admin.master.service.CityService;
import org.egov.infra.admin.master.service.ModuleService;
import org.egov.infra.admin.master.service.UserService;
import org.egov.infra.config.core.EnvironmentSettings;
import org.egov.infra.exception.ApplicationRuntimeException;
import org.egov.infra.reporting.engine.ReportConstants;
import org.egov.infra.reporting.engine.ReportOutput;
import org.egov.infra.reporting.engine.ReportRequest;
import org.egov.infra.reporting.engine.ReportService;
import org.egov.infra.reporting.util.ReportUtil;
import org.egov.infra.utils.DateUtils;
import org.egov.infra.utils.autonumber.AutonumberServiceBeanResolver;
import org.egov.infstr.services.PersistenceService;
import org.egov.stms.autonumber.SewerageDemandBillNumberGenerator;
import org.egov.stms.entity.SewerageBatchJobDetails;
import org.egov.stms.notice.entity.SewerageNotice;
import org.egov.stms.notice.service.SewerageNoticeService;
import org.egov.stms.service.SewerageBatchJobDetailsService;
import org.egov.stms.service.bill.SewerageConnectionBillService;
import org.egov.stms.transactions.entity.SewerageApplicationDetails;
import org.egov.stms.transactions.entity.SewerageConnectionDetail;
import org.egov.stms.transactions.entity.SewerageDemandConnection;
import org.egov.stms.transactions.service.SewerageApplicationDetailsService;
import org.egov.stms.transactions.service.SewerageConnectionSmsAndEmailService;
import org.egov.stms.transactions.service.SewerageDemandConnectionService;
import org.egov.stms.utils.SewerageTaxUtils;
import org.egov.stms.utils.constants.SewerageTaxConstants;
import org.egov.wtms.utils.constants.WaterTaxConstants;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.procedure.ProcedureCall;
import org.hibernate.procedure.ProcedureOutputs;
import org.hibernate.result.ResultSetOutput;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author roopa.h
 *
 */
@Service("sewerageConnectionBillService")
public class SewerageConnectionBillServiceImpl implements SewerageConnectionBillService {

    private static final Logger LOGGER = Logger.getLogger(SewerageConnectionBillServiceImpl.class);

    private static final String CITY_PORTAL_URL = "";

    private static final String PENALTY_PERIOD_KEY = "PANALTY_PERIOD";

    private static final String PENALTY_PERCENTAGE_KEY = "PANALTY_PERCENTAGE";

    @Autowired
    @Qualifier("persistenceService")
    private PersistenceService persistenceService;
    @Autowired
    private ReportService reportService;

    @Autowired
    private ModuleService moduleDao;

    @Autowired
    private SewerageApplicationDetailsService sewerageApplicationDetailsService;

    @Autowired
    private SewerageNoticeService sewerageNoticeService;

    @Autowired
    private InstallmentHibDao installmentHibDao;
    
    @Autowired
	private InstallmentDao installmentDao;

    @Qualifier("entityQueryService")
    private @Autowired PersistenceService entityQueryService;

    @Autowired
    private CityService cityService;

    @Autowired
    private AutonumberServiceBeanResolver beanResolver;

    @Autowired
    private AppConfigService appconfigService;
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private SewerageTaxUtils sewerageTaxUtils;

    @Autowired
    private SewerageBatchJobDetailsService sewerageBatchJobDetailsService;
    
    @Autowired
    private SewerageDemandConnectionService sewerageDemandConnectionService;
    
    @Autowired
    private SewerageConnectionSmsAndEmailService sewerageConnectionSmsAndEmailService;
    
    @Autowired
    private EnvironmentSettings environmentSettings;
    

    private Map<String, Object> prepareReportParams(final EgBill egBill,
            final SewerageApplicationDetails sewerageApplicationDetails) {

        final Map<String, Object> reportParams = new HashMap<>();
        final City city = (City) persistenceService.find("from City");
        String sectionAct = "";
        final Map<String, String> configValues = new HashMap<>();
        AppConfig appconfigIsPwssb = appconfigService.getAppConfigByModuleNameAndKeyName("Administration", "IS_PWSSB_ULB");
        Boolean isPwssb = appconfigIsPwssb.getConfValues().get(0).getValue().equals(CollectionConstants.IS_PWSSB_ULB);
        Boolean isDwssb = Boolean.FALSE;
        if (!isPwssb) {
            AppConfig appconfigIsDwssb = appconfigService.getAppConfigByModuleNameAndKeyName("Administration", "IS_DWSSB_ULB");
            isDwssb = appconfigIsDwssb.getConfValues().get(0).getValue().equals(CollectionConstants.IS_DWSSB_ULB);  
        }
        if (isPwssb) {
            AppConfig configuration = appconfigService.getAppConfigByModuleNameAndKeyName("Administration",
                    "PWSSB_CONFIGURATION");
            if (configuration != null) {
                String[] list = configuration.getConfValues().get(0).getValue().split(",");
                for (String str : list) {
                    String[] str2 = str.split("=");
                    configValues.put(str2[0], str2[1]);
                }
                reportParams.put("boardName", configValues.get("cityName"));
                reportParams.put("CITY_LOGO_PATH", ReportUtil.pwssbLogo());
                reportParams.put("authorityName", configValues.get("designation"));
                reportParams.put("boardNameShort", ReportConstants.PWSSB);
            }
        } else if (isDwssb) {
            AppConfig configuration = appconfigService.getAppConfigByModuleNameAndKeyName("Administration",
                    "DWSSB_CONFIGURATION");
            if (configuration != null) {
                String[] list = configuration.getConfValues().get(0).getValue().split(",");
                for (String str : list) {
                    String[] str2 = str.split("=");
                    configValues.put(str2[0], str2[1]);
                }
                reportParams.put("boardName", configValues.get("cityName"));
                reportParams.put("CITY_LOGO_PATH", ReportUtil.dwssbLogo());
                reportParams.put("authorityName", configValues.get("designation"));
                reportParams.put("boardNameShort", ReportConstants.DWSSB);
            }            
        }
        
        
        if (sewerageApplicationDetails != null) {
            final SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
            EgBill billObj = null;

            BigDecimal arrearAmount = BigDecimal.ZERO;
            BigDecimal totalAmount = BigDecimal.ZERO;
            BigDecimal penalty = BigDecimal.ZERO;
            BigDecimal billAmount = BigDecimal.ZERO;
            BigDecimal advanceCollection = BigDecimal.ZERO;
            BigDecimal interest = BigDecimal.ZERO;
            BigDecimal totalnetPayable = BigDecimal.ZERO;
            BigDecimal netAmount = BigDecimal.ZERO;
            BigDecimal arrearPenalty = BigDecimal.ZERO;
            BigDecimal arrearInterest = BigDecimal.ZERO;
            BigDecimal paymentAfterDueDate = BigDecimal.ZERO;
            BigDecimal previousAdvanceColl = BigDecimal.ZERO;
            

            final EgDemand currentDemand = egBill.getEgDemand();
            Installment installment = currentDemand.getEgInstallmentMaster();
            if (egBill != null) {
                if (egBill.getEgBillType() != null && egBill.getEgBillType().getCode() != null
                        && egBill.getEgBillType().getCode().equals(SewerageTaxConstants.BILLTYPE_MANUAL))
                    billObj = egBill;
                if (billObj != null && !billObj.getEgBillDetails().isEmpty())
                    for (final EgBillDetails billdet : billObj.getEgBillDetails())
                        if (billdet != null)
                            if (billdet.getDescription() != null && billdet.getDescription().contains("Sewerage Charges")
                                    && billdet.getPurpose() != null) {
                                final String temp1[] = billdet.getDescription().split("Sewerage Charges -");
                                if (billdet.getDescription().contains("#")) {
                                    final String instDesc[] = temp1[1].split("#");
                                    if (!instDesc[0].isEmpty()
                                            && instDesc[0].trim().equals(installment.getDescription()))
                                        if (billdet.getPurpose().equals(BillAccountDetails.PURPOSE.CURRENT_AMOUNT.toString()))
                                            billAmount = billAmount.add(billdet.getCrAmount());
                                        else if (billdet.getPurpose().equals(BillAccountDetails.PURPOSE.ARREAR_AMOUNT.toString()))
                                            arrearAmount = arrearAmount.add(billdet.getCrAmount());
                                        else if (billdet.getPurpose()
                                                .equals(BillAccountDetails.PURPOSE.CURRENT_PENALTY_CHARGES.toString()))
                                            penalty = penalty.add(billdet.getCrAmount());
                                        else if (billdet.getPurpose()
                                                .equals(BillAccountDetails.PURPOSE.CURRENT_LATEPAYMENT_CHARGES.toString()))
                                            interest = interest.add(billdet.getCrAmount());
                                        else if (billdet.getPurpose()
                                                .equals(BillAccountDetails.PURPOSE.ARREAR_PENALTY_CHARGES.toString()))
                                            arrearPenalty = arrearPenalty.add(billdet.getCrAmount());
                                        else if (billdet.getPurpose()
                                                .equals(BillAccountDetails.PURPOSE.ARREAR_LATEPAYMENT_CHARGES.toString()))
                                            arrearInterest = arrearInterest.add(billdet.getCrAmount());
                                }
                            }
               
                if (currentDemand != null) {
                    Calendar previousInstallmentDate = Calendar.getInstance();
                    previousInstallmentDate.setTime(currentDemand.getEgInstallmentMaster().getFromDate());
                    previousInstallmentDate.add(Calendar.DATE, -1);
                    Installment prevInstallment = installmentHibDao.getInsatllmentByModuleForGivenDate(
                            currentDemand.getEgInstallmentMaster().getModule(), previousInstallmentDate.getTime());
                    EgDemand previousDemand = getPreviousDemand(sewerageApplicationDetails, prevInstallment).getDemand();
                    if (previousDemand != null) {
                        for (final EgDemandDetails demdetails : previousDemand.getEgDemandDetails())
                            if (demdetails != null && demdetails.getEgDemandReason() != null)
                                if (demdetails.getEgDemandReason().getEgDemandReasonMaster().getCode().equals("SEWERAGEADVANCE")
                                        && demdetails.getEgDemandReason().getEgInstallmentMaster().equals(prevInstallment))
                                    previousAdvanceColl = previousAdvanceColl.add(demdetails.getAmtCollected());
                    } else
                        previousAdvanceColl = previousAdvanceColl.add(BigDecimal.ZERO);
                }
            }

            if (sewerageApplicationDetails != null) {
                reportParams.put("sectionAct", sectionAct);
                reportParams.put("cityGrade", city.getGrade());
                reportParams.put("municipalityName",
                        city.getPreferences() != null ? city.getPreferences().getMunicipalityName() : city.getPreferences());
                // log for non-pwssb ulb
                reportParams.put("LOGO_PATH", ReportUtil.logoBasePath());
                reportParams.put("cityUrl", cityService.findAll().get(0).getName().toLowerCase() + CITY_PORTAL_URL);
/*                reportParams.put("onlineSewerageUrl", WaterTaxConstants.ONLINE_URL + city.getName().replaceAll("\\s","") + WaterTaxConstants.ONLINE_URL_ST);
*/                if (city.getName().equals("Mohali") || city.getName().equals("Pathankot"))
					reportParams.put("onlineSewerageUrl", WaterTaxConstants.ONLINE_URL
					+ city.getName().replaceAll("\\s", "") + WaterTaxConstants.ONLINE_URL_sT);
				else
				reportParams.put("onlineSewerageUrl", WaterTaxConstants.ONLINE_URL
						+ city.getName().replaceAll("\\s", "") + WaterTaxConstants.ONLINE_URL_ST);
                
                reportParams.put("districtName", city.getDistrictName());
                reportParams.put("cityName", city.getName() != null ? city.getName() : "");
                reportParams.put("cityContactNo", city.getPreferences().getMunicipalityContactNo());
                reportParams.put("assessmentNumber", sewerageApplicationDetails.getConnectionDetail() != null
                        ? sewerageApplicationDetails.getConnectionDetail().getPropertyIdentifier() : "");
                reportParams.put("locality", sewerageApplicationDetails.getConnection().getLocality() != null
                        ? sewerageApplicationDetails.getConnection().getLocality().getName() : "");
                reportParams.put("usageType", sewerageApplicationDetails.getConnectionDetail().getUsageType().getName());
                reportParams.put("stmsLedgerID", sewerageApplicationDetails.getConnectionDetail().getLedgerNumber());
                reportParams.put("stmsPlotSize", sewerageApplicationDetails.getConnectionDetail().getPlotSize());
                reportParams.put("revenueWard", sewerageApplicationDetails.getConnection().getWard() != null
                        ? sewerageApplicationDetails.getConnection().getWard().getName() : "");
                reportParams.put("revenueZone", sewerageApplicationDetails.getConnection().getZone() != null
                        ? sewerageApplicationDetails.getConnection().getZone().getName() : "");
                reportParams.put("block", sewerageApplicationDetails.getConnection().getBlock() != null
                        ? sewerageApplicationDetails.getConnection().getBlock().getName() : "");
                reportParams.put("doorNo", sewerageApplicationDetails.getConnection().getAddress().getHouseNoBldgApt() != null
                        ? sewerageApplicationDetails.getConnection().getAddress().getHouseNoBldgApt() : "");
                reportParams.put("consumerNo", sewerageApplicationDetails.getConnection().getShscNumber());
                reportParams.put("oldConsumerNo", sewerageApplicationDetails.getConnection().getOldConsumerNumber());
                reportParams.put("consumerName",
                        sewerageApplicationDetails.getConnection().getSewerageConnectionOwnerInfo().get(0).getOwner().getName());
                netAmount = netAmount.add(arrearAmount).add(billAmount).subtract(previousAdvanceColl).setScale(2,
                        BigDecimal.ROUND_HALF_UP);
                advanceCollection = previousAdvanceColl;
                reportParams.put("netAmount", netAmount);
                paymentAfterDueDate = paymentAfterDueDate.add(netAmount).add(penalty).add(interest).add(arrearPenalty)
                        .add(arrearInterest);
                
				BigDecimal currentAmount = billAmount;
				BigDecimal penaltyafterDueDate = BigDecimal.ZERO;

				
				if(currentAmount.subtract(previousAdvanceColl).compareTo(BigDecimal.ZERO) > 0)
				penaltyafterDueDate = calculatePenaltyAmountAfterDueDate(currentAmount);
                
				if (paymentAfterDueDate.compareTo(BigDecimal.ZERO) > 0)
					reportParams.put("paymentAfterDueDate",
							penaltyafterDueDate.add(paymentAfterDueDate).setScale(0, BigDecimal.ROUND_HALF_UP));
				else
					reportParams.put("paymentAfterDueDate", paymentAfterDueDate.setScale(0, BigDecimal.ROUND_HALF_UP));

                reportParams.put("description", installment.getFromDate() != null && installment.getToDate() != null
                        ? formatter.format(installment.getFromDate()) + " to " + formatter.format(installment.getToDate()) : "");
                reportParams.put("arrarAmount", arrearAmount.setScale(2, BigDecimal.ROUND_HALF_UP));
                reportParams.put("billAmount", billAmount.setScale(2, BigDecimal.ROUND_HALF_UP));
                reportParams.put("totalAmount",
                        totalAmount.add(billAmount).add(arrearAmount).setScale(2, BigDecimal.ROUND_HALF_UP));
                reportParams.put("demandBillNumber", billObj != null ? billObj.getBillNo() : "");
                reportParams.put("demandBillDate", billObj != null ? formatter.format(billObj.getIssueDate()) : "");
                reportParams.put("penalty", penalty.setScale(2, BigDecimal.ROUND_HALF_UP));
                reportParams.put("interest", interest.setScale(2, BigDecimal.ROUND_HALF_UP));
                                reportParams.put("totalnetPayable", totalnetPayable.add(netAmount).add(penalty).add(interest)
                                                .setScale(2, BigDecimal.ROUND_HALF_UP));
                reportParams.put("adjustamount", advanceCollection.setScale(2, BigDecimal.ROUND_HALF_UP));
                reportParams.put("totalWithPenaltyAndInterest",
                        penalty.add(billAmount).add(interest).setScale(2, BigDecimal.ROUND_HALF_UP));
                reportParams.put("paymentDuedate", formatter.format(getPaymentDueDate(billObj.getIssueDate(),billObj.getEgDemand().getEgInstallmentMaster().getId())));
                reportParams.put("arrearPenalty", arrearPenalty.setScale(2, BigDecimal.ROUND_HALF_UP));
                reportParams.put("arrearInterest", arrearInterest.setScale(2, BigDecimal.ROUND_HALF_UP));
                reportParams.put("netAmountPayable", totalnetPayable.add(netAmount).add(penalty).add(interest).add(arrearPenalty)
                        .add(arrearInterest).setScale(2, BigDecimal.ROUND_HALF_UP).toString());
                reportParams.put("guardianName", sewerageApplicationDetails.getConnection().getSewerageConnectionOwnerInfo()
                        .get(0).getOwner().getGuardian() != null
                                ? sewerageApplicationDetails.getConnection().getSewerageConnectionOwnerInfo().get(0).getOwner()
                                        .getGuardian()
                                : "");
                reportParams.put("streetName", sewerageApplicationDetails.getConnection().getAddress() != null 
                                ? sewerageApplicationDetails.getConnection()
                                        .getAddress().getStreetRoadLine()
                                : "");
                reportParams.put("landMark",
                        sewerageApplicationDetails.getConnection().getAddress() != null 
                                        ? sewerageApplicationDetails.getConnection().getAddress().getLandmark()
                                        : "");
                reportParams.put("mobileNumber", sewerageApplicationDetails.getConnection().getSewerageConnectionOwnerInfo()
                        .get(0).getOwner().getMobileNumber() != null
                                ? sewerageApplicationDetails.getConnection().getSewerageConnectionOwnerInfo().get(0).getOwner()
                                        .getMobileNumber()
                                : "");
                reportParams.put("address", sewerageApplicationDetails.getConnection().getAddress() != null ? sewerageApplicationDetails.getConnection().getAddress().getAreaLocalitySector():"");
				reportParams.put("natureOfConnection", sewerageApplicationDetails.getConnection().getAddress().getBuildingName() != null ? sewerageApplicationDetails.getConnection().getAddress().getBuildingName():"");
                AppConfig penaltyPercentappConfig = appconfigService.getAppConfigByModuleNameAndKeyName(
                        SewerageTaxConstants.MODULE_NAME,
                        PENALTY_PERCENTAGE_KEY);
                BigDecimal penaltyPercentage = BigDecimal.ZERO;
                if (penaltyPercentappConfig != null && penaltyPercentappConfig.getConfValues() != null
                        && !penaltyPercentappConfig.getConfValues().isEmpty()
                        && penaltyPercentappConfig.getConfValues().get(0).getValue() != null)
                    penaltyPercentage = new BigDecimal(penaltyPercentappConfig.getConfValues().get(0).getValue());
                reportParams.put("penaltyPercentage", penaltyPercentage);
            }
        }
        return reportParams;
    }

    private BigDecimal calculatePenaltyAmountAfterDueDate(BigDecimal billAmount) {
        BigDecimal penaltyAmount = billAmount;
        AppConfig penaltyPercentappConfig = appconfigService.getAppConfigByModuleNameAndKeyName(SewerageTaxConstants.MODULE_NAME,
                PENALTY_PERCENTAGE_KEY);
        BigDecimal percent = new BigDecimal(penaltyPercentappConfig.getConfValues().get(0).getValue());
        BigDecimal hundred = new BigDecimal(100);
        return penaltyAmount.multiply(percent).divide(hundred);
    }

    private Date getPaymentDueDate(Date billCreatedDate,Integer installmentId) {
    	Module m=moduleDao.getModuleByName("Sewerage Tax Management");
    	AppConfig penaltyappConfig = appconfigService.getAppConfigByModuleNameAndKeyName(SewerageTaxConstants.MODULE_NAME,
                PENALTY_PERIOD_KEY);
    	Installment currInstallment=installmentDao.getCurrentInstallment(m);
        Calendar cal = Calendar.getInstance();
        if(currInstallment.getId()==installmentId)
		{
		cal.setTime(currInstallment.getToDate());
		cal.add(Calendar.DATE, +Integer.parseInt(penaltyappConfig.getConfValues().get(0).getValue()));
		}
		else
		{
        cal.setTime(billCreatedDate);
        cal.add(Calendar.DATE, +Integer.parseInt(penaltyappConfig.getConfValues().get(0).getValue()));
		}
        return cal.getTime();
    }
   

    @Override
    @Transactional
    public void generateBillForConsumercode(final String shscNumber, Integer installmentId) {
        ProcedureCall procedureCall = null;
        final SewerageApplicationDetails sewerageApplicationDetails = sewerageApplicationDetailsService
                .findByConnection_ShscNumberAndIsActive(shscNumber);

        final Module module = moduleDao.getModuleByName(SewerageTaxConstants.MODULE_NAME);
        Installment currentInstallment = installmentHibDao.findById(installmentId, Boolean.TRUE);
        Calendar cal = Calendar.getInstance();
        cal.setTime(currentInstallment.getFromDate());
        cal.add(Calendar.DATE, -1);
        Date endDate = cal.getTime();

        Installment previousInstallment = installmentHibDao.getInsatllmentByModuleAndEndDate(module, endDate, "Quarterly");
        if (sewerageApplicationDetails != null) {
            procedureCall = entityQueryService.getSession()
                    .createStoredProcedureCall("stms_bill_genaration_for_consumer_code");
            procedureCall.registerParameter("in_consumercode", String.class, ParameterMode.IN);
            procedureCall.getParameterRegistration("in_consumercode").bindValue(shscNumber);
            procedureCall.registerParameter("in_conn_id", int.class, ParameterMode.IN);
            procedureCall.getParameterRegistration("in_conn_id")
                    .bindValue(sewerageApplicationDetails.getConnection().getId().intValue());
            procedureCall.registerParameter("in_curr_inst_id", int.class, ParameterMode.IN);
            procedureCall.getParameterRegistration("in_curr_inst_id")
                    .bindValue(currentInstallment != null ? currentInstallment.getId() : currentInstallment);
            procedureCall.registerParameter("in_prev_inst_id", int.class, ParameterMode.IN);
            procedureCall.getParameterRegistration("in_prev_inst_id")
                    .bindValue(previousInstallment != null ? previousInstallment.getId() : previousInstallment);
            procedureCall.registerParameter("curr_installment_description", String.class, ParameterMode.IN);
            procedureCall.getParameterRegistration("curr_installment_description")
                    .bindValue(currentInstallment != null ? currentInstallment.getDescription() : currentInstallment);
            procedureCall.registerParameter("in_location_id", int.class, ParameterMode.IN);
            procedureCall.getParameterRegistration("in_location_id")
                    .bindValue(sewerageApplicationDetails.getConnection().getLocality() != null
                            ? sewerageApplicationDetails.getConnection().getLocality().getId().intValue() : null);
            procedureCall.registerParameter("in_appdet_id", int.class, ParameterMode.IN);
            procedureCall.getParameterRegistration("in_appdet_id")
                    .bindValue(sewerageApplicationDetails != null
                            ? sewerageApplicationDetails.getId().intValue() : null);
            procedureCall.registerParameter("batch_id", long.class, ParameterMode.IN);
            procedureCall.getParameterRegistration("batch_id").bindValue(Long.valueOf(0));
        }
        ProcedureOutputs procedureOutputs = null;
        ResultSetOutput output = null;
        if (procedureCall != null) {
            try {
                procedureOutputs = procedureCall.getOutputs();
                output = (ResultSetOutput) procedureOutputs.getCurrent();
                output.getSingleResult();
            } catch (Exception e) {
                throw e;
            }
        }
        final EgBill egbill = getBillForDownloadPdfByConsumerCode(shscNumber);
        LOGGER.debug("single hscnumber Bill Object = " + (egbill != null ? egbill.getBillNo() : null)
                + " for consumercode " + shscNumber);
        if (egbill == null)
            throw new ApplicationRuntimeException("Bill is not generated , Please check");
        InputStream billPDF = null;
        ReportRequest reportRequest = null;
        ReportOutput reportOutput;
        if (egbill != null) {
            LOGGER.debug(
                    "single hscnumber Bill Object with id= " + egbill.getId() + " for consumercode " + shscNumber);
            final Map<String, Object> reportParams = prepareReportParams(egbill, sewerageApplicationDetails);
            AppConfig appconfigIsPwssb = appconfigService.getAppConfigByModuleNameAndKeyName("Administration", "IS_PWSSB_ULB");
            Boolean isPwssb = appconfigIsPwssb.getConfValues().get(0).getValue().equals(CollectionConstants.IS_PWSSB_ULB);
            Boolean isDwssb = Boolean.FALSE;
            if (!isPwssb) {
                AppConfig appconfigIsDwssb = appconfigService.getAppConfigByModuleNameAndKeyName("Administration", "IS_DWSSB_ULB");
                isDwssb = appconfigIsDwssb.getConfValues().get(0).getValue().equals(CollectionConstants.IS_DWSSB_ULB);  
            }
            
            if (isPwssb || isDwssb)
                reportRequest = new ReportRequest("SewerageChargesDemandBillwithPwssb", egbill, reportParams);
            else
                reportRequest = new ReportRequest("SewerageChargesDemandBill", egbill, reportParams);
            reportOutput = reportService.createReport(reportRequest);
            if (reportOutput != null && reportOutput.getReportOutputData() != null)
                billPDF = new ByteArrayInputStream(reportOutput.getReportOutputData());
            final SewerageDemandBillNumberGenerator demandBillNumberGenerator = beanResolver
                    .getAutoNumberServiceFor(SewerageDemandBillNumberGenerator.class);
            demandBillNumberGenerator.generateSewerageDemandBillNumber(sewerageApplicationDetails);
            if(this.environmentSettings.getProperty("sewerage.bill.generation.sms.enabled",Boolean.class))
            sewerageConnectionSmsAndEmailService.buildSMSForSewerageBillGeneration(sewerageApplicationDetails, egbill, reportParams);
            SewerageNotice sewerageNotice = null;
            if (sewerageApplicationDetails != null) {
                sewerageNotice = sewerageNoticeService.buildDemandBillNotice(sewerageApplicationDetails, billPDF,
                        egbill.getBillNo(),egbill.getIssueDate());
                if (sewerageNotice != null) {
                    sewerageApplicationDetails.addNotice(sewerageNotice);
                    sewerageApplicationDetailsService.save(sewerageApplicationDetails);
                }
            }

        }
    }

    public EgBill getBillForDownloadPdfByConsumerCode(final String shscNumber) {
        EgBill egBill = null;
        final String query = " select distinct bill From EgBill bill,EgBillType billtype,SewerageConnection sewConn,SewerageApplicationDetails sewAppDet,SewerageConnectionDetail sewConDet, EgwStatus status,SewerageDemandConnection sewDemConn, EgDemand demd"
                + " where billtype.id=bill.egBillType and billtype.code='MANUAL'and bill.consumerId = sewConn.shscNumber and sewConn.shscNumber =:shscNumber and sewConn.id=sewAppDet.connection.id and demd.id=bill.egDemand"
                + " and  bill.is_Cancelled='N' and bill.serviceCode='STAX' and status.moduletype='SEWERAGETAXAPPLICATION' and sewConn.status='ACTIVE' and sewAppDet.status.id=status.id and status.code='SANCTIONED'"
                + " and sewConDet.id=sewAppDet.connectionDetail.id and sewAppDet.id=sewDemConn.applicationDetails.id and sewDemConn.demand.id=demd.id order by bill.id desc";
        final Query hibquery = persistenceService.getSession().createQuery(query.toString()).setString("shscNumber",
                shscNumber);
        final List<EgBill> egBilltemp = hibquery.list();
        if (!egBilltemp.isEmpty())
            egBill = egBilltemp.get(0);
        LOGGER.debug(
                "query to get Bill for single consumernumber" + query.toString() + " for S.H.S.C No= " + shscNumber);
        return egBill;
    }

    @Transactional(timeout=1800)
    public void printDemandBill(final EgBill egBill,boolean isSmsEnabled) {
        ReportRequest reportRequest = null;
        final SewerageApplicationDetails sewerageApplicationDetails = sewerageApplicationDetailsService
                .findByConnection_ShscNumberAndIsActive(egBill.getConsumerId());
        InputStream billPDF = null;
        ReportOutput reportOutput;
        /*final EgBill egbill = getBillForDownloadPdfByConsumerCode(consumerCode);*/
        if (egBill != null) {
            LOGGER.debug(
                    "single hscnumber Bill Object with id= " + egBill.getId() + " for consumercode " + egBill.getConsumerId());
            final Map<String, Object> reportParams = prepareReportParams(egBill, sewerageApplicationDetails);
            AppConfig appconfigIsPwssb = appconfigService.getAppConfigByModuleNameAndKeyName("Administration", "IS_PWSSB_ULB");
            Boolean isPwssb = appconfigIsPwssb.getConfValues().get(0).getValue().equals(CollectionConstants.IS_PWSSB_ULB);
            Boolean isDwssb = Boolean.FALSE;
            if (!isPwssb) {
                AppConfig appconfigIsDwssb = appconfigService.getAppConfigByModuleNameAndKeyName("Administration", "IS_DWSSB_ULB");
                isDwssb = appconfigIsDwssb.getConfValues().get(0).getValue().equals(CollectionConstants.IS_DWSSB_ULB);  
            }
            if (isPwssb || isDwssb)
                reportRequest = new ReportRequest("SewerageChargesDemandBillwithPwssb", egBill, reportParams);
            else
                reportRequest = new ReportRequest("SewerageChargesDemandBill", egBill, reportParams);
            reportOutput = reportService.createReport(reportRequest);
			if (reportOutput != null && reportOutput.getReportOutputData() != null)
				billPDF = new ByteArrayInputStream(reportOutput.getReportOutputData());
			final SewerageDemandBillNumberGenerator demandBillNumberGenerator = beanResolver
					.getAutoNumberServiceFor(SewerageDemandBillNumberGenerator.class);
			demandBillNumberGenerator.generateSewerageDemandBillNumber(sewerageApplicationDetails);
			if(isSmsEnabled)
			sewerageConnectionSmsAndEmailService.buildSMSForSewerageBillGeneration(sewerageApplicationDetails,
						egBill, reportParams);
			SewerageNotice sewerageNotice = null;
			if (sewerageApplicationDetails != null) {
				sewerageNotice = sewerageNoticeService.buildDemandBillNotice(sewerageApplicationDetails, billPDF,
						egBill.getBillNo(),egBill.getIssueDate());
				if (sewerageNotice != null) {
					sewerageApplicationDetails.addNotice(sewerageNotice);
					sewerageApplicationDetailsService.save(sewerageApplicationDetails);
				}
			}

        }
    }

    @Override
    @Transactional(timeout=1800)
    public void bulkBillGeneration(final Integer modulo, final Integer billsCount) {
        
        LOGGER.debug("Entered into executeJob" + modulo);
        
        final Long jobStartTime = System.currentTimeMillis();
        final Query query = getQuery(modulo, billsCount);
        int noOfBillsGenerated = 0;
        final List<EgBill> consumerNumberBillList = query.list();
        final List<String> consumerNumbers = new ArrayList<>();
        for(final EgBill bill : consumerNumberBillList)
            consumerNumbers.add(bill.getConsumerId());
        LOGGER.info("executeJob" + modulo + " - got " + consumerNumbers + " consumer numbers for bill generation");
        Long timeTaken = System.currentTimeMillis() - jobStartTime;
        LOGGER.info("executeJob" + modulo + " took " + timeTaken / 1000
                + " secs for consumer list selection - consumer numbers = " + consumerNumberBillList.size());
        LOGGER.info("executeJob" + modulo + " - Generating bills.....");
        Boolean isSmsEnabled = this.environmentSettings.getProperty("sewerage.bill.generation.sms.enabled",Boolean.class);
        for (final EgBill bill : consumerNumberBillList)
            try {

                printDemandBill(bill,isSmsEnabled);
                noOfBillsGenerated++;

            } catch (final Exception e) {
                LOGGER.error(" Error while generating  bill via BulkSewerageConnBillGenerationJob Job " + modulo.toString()
                        + bill.getConsumerId(), e);

            }

        timeTaken = jobStartTime - System.currentTimeMillis();
        LOGGER.info("Exiting from executeJob" + modulo + "executeJob" + modulo + " - " + noOfBillsGenerated + "/"
                + consumerNumberBillList.size() + " Bill(s) generated in " + timeTaken / 1000 + " (secs)");
        LOGGER.debug("Exiting from executeJob" + modulo);
    }

    @Override
    @Transactional(timeout=1800)
    public void bulkBillGeneration() {

        List<SewerageBatchJobDetails> jobDetails = sewerageBatchJobDetailsService
                .findActiveJobDetailsByJobType(SewerageTaxConstants.BILL);
        ProcedureCall procedureCall = null;
        ProcedureOutputs procedureOutputs = null;
        if (jobDetails != null) {

            for (SewerageBatchJobDetails jd : jobDetails) {

                if (LOGGER.isDebugEnabled())
                    LOGGER.debug("Starting sewerage tax bulk bill generation for " + jd.getInstallment().getDescription() + " "
                            + jd.getBatchName() + " " + jd.getBoundaryType());

                procedureCall = persistenceService.getSession()
                        .createStoredProcedureCall("stms_bill_genaration");
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

    private Query getQuery(final Integer modulo, final Integer billsCount) {
        final StringBuilder queryString = new StringBuilder();
        queryString
                .append("select bill From EgBill bill,EgBillType billtype,EgDemand demand,SewerageConnection sewConn,SewerageConnectionDetail sewConDet,"
                        + " SewerageApplicationDetails sewAppDet,EgwStatus status,SewerageDemandConnection sewDemConn"
                        + " where billtype.id=bill.egBillType and billtype.code in ('MANUAL') and bill.consumerId = sewConn.shscNumber "
                        + " and sewConn.id=sewAppDet.connection.id and sewConDet.id=sewAppDet.connectionDetail.id "
                        + " and sewAppDet.id=sewDemConn.applicationDetails.id and demand.id=sewDemConn.demand and demand.id=bill.egDemand "
                        + " and bill.is_Cancelled='N'"
                        + " and sewConn.status='ACTIVE' and sewAppDet.status.id=status.id and status.moduletype = :moduletype "
                        + " and status.code = :statuscode")
                .append(" and not exists (select ad from SewerageNotice ad where ad.noticeNo=bill.billNo)")
                .append(" and MOD(sewConn.id, ").append(SewerageTaxConstants.QUARTZ_BULKBILL_JOBS).append(") = :modulo ");
        final Query query = persistenceService.getSession().createQuery(queryString.toString())
                .setInteger("modulo", modulo).setString("moduletype", SewerageTaxConstants.MODULETYPE)
                .setString("statuscode", SewerageTaxConstants.APPLICATION_STATUS_SANCTIONED);
        query.setMaxResults(billsCount);
        LOGGER.debug("query to get All consumernumbers where Bill is generated" + query.toString());
        return query;
    }
    
    private SewerageDemandConnection getPreviousDemand(final SewerageApplicationDetails sewerageConnectionDetails,
            Installment installment) {
/*        SewerageDemandConnection sewerageDemandConnection = new SewerageDemandConnection();

        final List<SewerageDemandConnection> sewerageDemandConnectionList = sewerageDemandConnectionService
                .findByApplicationDetails(sewerageConnectionDetails);
        for (final SewerageDemandConnection sewerageDemandConnection1 : sewerageDemandConnectionList)
            if (sewerageDemandConnection1.getDemand().getEgInstallmentMaster().equals(installment)) {
                sewerageDemandConnection = sewerageDemandConnection1;
                break;
            }
*/      
        SewerageDemandConnection sewerageDemandConnection = new SewerageDemandConnection();
        final List<SewerageDemandConnection> sewerageDemandConnectionList = sewerageDemandConnectionService
            .findLatestSewerageDemandForInstallment(sewerageConnectionDetails, installment);
        if (sewerageDemandConnectionList!= null && !sewerageDemandConnectionList.isEmpty())
            sewerageDemandConnection = sewerageDemandConnectionList.get(0);
        return sewerageDemandConnection;
    }

	@Override
	@Transactional
	public void buildBulkSewerageDueSMS() {
		List<Object> list = new ArrayList<>();
		if(this.environmentSettings.getProperty("sewerage.bill.oneday.due.sms.enabled",Boolean.class))
		list.addAll(getDueBillListNeedToPayInDays(1));
		if(this.environmentSettings.getProperty("sewerage.bill.fivedays.due.sms.enabled",Boolean.class))
		list.addAll(getDueBillListNeedToPayInDays(5));
		final SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		String mobileNumber = null;
		String ownerName = null;
		String consumerNumber = null;
		Double billAmount = null;
		Object[] billObject = null;
		Date billDueDate = null;
		if (!list.isEmpty()) {
			final City city = (City) persistenceService.find("from City");
			String onlineSeweragePayUrl = WaterTaxConstants.ONLINE_URL + city.getName().replaceAll("\\s", "")
					+ WaterTaxConstants.ONLINE_URL_ST;
			for (Object object : list) {
				billObject = (Object[]) object;
				mobileNumber = (String) billObject[0];
				ownerName = (String) billObject[1];
				billDueDate = (Date) billObject[2];
				consumerNumber = (String) billObject[3];
				billAmount = (Double) billObject[4];
				if(billAmount == null)
					billAmount = Double.valueOf(0);
				if (mobileNumber != null && !mobileNumber.isEmpty())
					sewerageConnectionSmsAndEmailService.buildSmsForDueRemainder(formatter.format(billDueDate),
							billAmount.longValue(), consumerNumber, mobileNumber, ownerName, onlineSeweragePayUrl);
			}
		}
	}

	private List<Object> getDueBillListNeedToPayInDays(int days) {
		final SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(new Date());
		calendar.add(Calendar.DATE, days);
		String fromDate = formatter.format(DateUtils.startOfDay(calendar.getTime()));

		Calendar c = Calendar.getInstance();
		c.setTime(new Date());
		c.add(Calendar.DATE, days + 1);
		String toDate = formatter.format(DateUtils.startOfDay(c.getTime()));
		final StringBuilder queryString = new StringBuilder();

		queryString
				.append("select connection.mobileNumber as \"mobileNumber\", connection.ownerName as \"ownerName\",connection.billLastDueDate as \"billLastDuedate\",connection.consumerNo as \"consumerNo\","
						+ "connection.totalAmount as \"billTotalAmount\" from (select conn.shsc_number as consumerNo,u.name as ownerName,u.mobilenumber as mobileNumber,bill.last_date as billLastDueDate, "
						+ "bill.total_amount as totalAmount from egswtax_connection conn,egswtax_connectiondetail conndetails, egswtax_connection_owner_info oinfo,egswtax_applicationdetails appDet,eg_user u,eg_bill bill "
						+ "where bill.is_cancelled=:isCancelled and bill.id_bill_type !=(select id from eg_bill_type where code = 'AUTO') and bill.service_code=:serviceCode and bill.consumer_id=conn.shsc_number and conn.id=appDet.connection and conndetails.id=appDet.connectiondetail and "
						+ "conn.id=oinfo.connection and oinfo.owner=u.id and conn.status = 'ACTIVE' and bill.last_date between to_date(:fromDate,'dd/MM/yyyy') and to_date(:toDate,'dd/MM/yyyy')) connection "
						+ ", (select conn.shsc_number as consumerNo from egswtax_connection conn, egswtax_connectiondetail conndetails,egswtax_applicationdetails appDet,egswtax_demand_connection dc, eg_demand d, eg_demand_details dd where "
						+ "conn.id=appDet.connection and conndetails.id=appDet.connectiondetail and dc.applicationdetail=appDet.id and d.id = dc.demand and d.is_history='N' "
						+ "and dd.id_demand = d.id group by conn.shsc_number having sum(dd.amount - dd.amt_collected) > 0 ) totaldue where totaldue.consumerNo=connection.consumerNo ");

		final SQLQuery query = (SQLQuery) persistenceService.getSession().createSQLQuery(queryString.toString())
				.setString("isCancelled", DEMANDISHISTORY).setString("serviceCode", "STAX")
				.setString("fromDate", fromDate).setString("toDate", toDate);
		LOGGER.debug("query to get sewerage Bill Objects to send bill due sms =" + query.toString());

		final List<Object> dueBillList = query.list();

		return dueBillList;
	}

}