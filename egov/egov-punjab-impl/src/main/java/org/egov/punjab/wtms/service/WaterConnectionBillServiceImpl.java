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

import static org.egov.wtms.utils.constants.WaterTaxConstants.COLLECTION_STRING_SERVICE_CODE;
import static org.egov.wtms.utils.constants.WaterTaxConstants.DEMANDISHISTORY;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.persistence.ParameterMode;

import org.apache.log4j.Logger;
import org.egov.collection.constants.CollectionConstants;
import org.egov.collection.integration.models.BillAccountDetails;
import org.egov.commons.Installment;
import org.egov.commons.dao.FinancialYearDAO;
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
import org.egov.infra.filestore.entity.FileStoreMapper;
import org.egov.infra.filestore.service.FileStoreService;
import org.egov.infra.reporting.engine.ReportConstants;
import org.egov.infra.reporting.engine.ReportOutput;
import org.egov.infra.reporting.engine.ReportRequest;
import org.egov.infra.reporting.engine.ReportService;
import org.egov.infra.reporting.util.ReportUtil;
import org.egov.infra.utils.DateUtils;
import org.egov.infstr.services.PersistenceService;
import org.egov.punjab.stms.SewerageDemandInfo;
import org.egov.stms.transactions.entity.SewerageApplicationDetails;
import org.egov.stms.transactions.entity.SewerageConnection;
import org.egov.stms.transactions.entity.SewerageDemandConnection;
import org.egov.stms.transactions.service.SewerageApplicationDetailsService;
import org.egov.stms.transactions.service.SewerageConnectionService;
import org.egov.stms.transactions.service.SewerageConnectionSmsAndEmailService;
import org.egov.stms.transactions.service.SewerageDemandConnectionService;
import org.egov.stms.utils.constants.SewerageTaxConstants;
import org.egov.wtms.application.entity.ApplicationDocuments;
import org.egov.wtms.application.entity.MeterReadingDetails;
import org.egov.wtms.application.entity.WaterChargeBatchJobDetails;
import org.egov.wtms.application.entity.WaterConnectionDetails;
import org.egov.wtms.application.entity.WaterDemandConnection;
import org.egov.wtms.application.repository.MeterReadingDetailsRepository;
import org.egov.wtms.application.service.ConnectionDemandService;
import org.egov.wtms.application.service.SearchNoticeService;
import org.egov.wtms.application.service.WaterChargeBatchJobDetailsService;
import org.egov.wtms.application.service.WaterConnectionDetailsService;
import org.egov.wtms.application.service.WaterConnectionSmsAndEmailService;
import org.egov.wtms.application.service.WaterDemandConnectionService;
import org.egov.wtms.application.entity.WaterMeterRent;
import org.egov.wtms.application.service.WaterMeterRentService;
import org.egov.wtms.masters.entity.DocumentNames;
import org.egov.wtms.masters.entity.enums.ConnectionStatus;
import org.egov.wtms.masters.entity.enums.ConnectionType;
import org.egov.wtms.masters.repository.ApplicationDocumentsRepository;
import org.egov.wtms.masters.service.DocumentNamesService;
import org.egov.wtms.service.bill.WaterConnectionBillService;
import org.egov.wtms.utils.WaterTaxUtils;
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
@Service("waterConnectionBillService")
public class WaterConnectionBillServiceImpl implements WaterConnectionBillService {

	private static final Logger LOGGER = Logger.getLogger(WaterConnectionBillServiceImpl.class);

	private static final String CITY_PORTAL_URL = "";

	private static final String PENALTY_PERIOD_KEY = "PANALTY_PERIOD";

	private static final String PENALTY_PERCENTAGE_KEY = "PANALTY_PERCENTAGE";

	@Autowired
	@Qualifier("persistenceService")
	private PersistenceService persistenceService;
	
	@Autowired
	private SewerageApplicationDetailsService sewerageApplicationDetailsService;
	@Autowired
	private ReportService reportService;

	@Autowired
	private ModuleService moduleDao;

	@Autowired
	private WaterConnectionDetailsService waterConnectionDetailsService;
	@Autowired
	private SearchNoticeService searchNoticeService;

	@Autowired
	private ConnectionDemandService connectionDemandService;

	@Autowired
	private InstallmentHibDao installmentHibDao;

	@Autowired
	private FinancialYearDAO financialYearDAO;
	@Autowired
	private DocumentNamesService documentNamesService;

	@Qualifier("entityQueryService")
	private @Autowired PersistenceService entityQueryService;

	@Autowired
	private ApplicationDocumentsRepository applicationDocumentsRepository;

	@Autowired
	private CityService cityService;
	
	@Autowired
	private InstallmentDao installmentDao;
	
	@Autowired
	private FileStoreService fileStoreService;

	@Autowired
	private AppConfigService appconfigService;

	@Autowired
	private SewerageConnectionService sewerageConnectionService;

	@Autowired
	private WaterChargeBatchJobDetailsService waterChargeBatchJobDetailsService;

	@Autowired
	private WaterDemandConnectionService waterDemandConnectionService;
	
	@Autowired
	private WaterMeterRentService waterMeterRentService;

	@Autowired
	private SewerageDemandConnectionService sewerageDemandConnectionService;

	@Autowired
	WaterConnectionSmsAndEmailService waterConnectionSmsAndEmailService;

	@Autowired
	private MeterReadingDetailsRepository meterReadingDetailsRepository;

	@Autowired
	private ModuleService moduleService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private WaterTaxUtils waterTaxUtils;
	
    @Autowired
    private EnvironmentSettings environmentSettings;
    
	private Map<String, Object> prepareReportParams(final EgBill egBill,
			final WaterConnectionDetails waterConnectionDetails, final String billType) {

		final Map<String, Object> reportParams = new HashMap<>();
	        final Map<String, String> configValues = new HashMap<>();

		Map<String, Object> sewerageReportParams = new HashMap<>();
		final City city = (City) persistenceService.find("from City");
		String sectionAct = "";
		
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

		if (waterConnectionDetails != null) {
			final SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
			EgBill billObj = null;

			BigDecimal arrearAmount = BigDecimal.ZERO;
			BigDecimal totalAmount = BigDecimal.ZERO;
			BigDecimal billAmountMeterRent=BigDecimal.ZERO;
			BigDecimal penalty = BigDecimal.ZERO;
			BigDecimal billAmount = BigDecimal.ZERO;
			BigDecimal previousAdvanceColl = BigDecimal.ZERO;
			BigDecimal interest = BigDecimal.ZERO;
			BigDecimal stmsPaymentAfterDueDate = BigDecimal.ZERO;
			BigDecimal stmsTotalNetPayable = BigDecimal.ZERO;
			BigDecimal totalnetPayable = BigDecimal.ZERO;
			BigDecimal netAmount = BigDecimal.ZERO;
			BigDecimal arrearPenalty = BigDecimal.ZERO;
			BigDecimal arrearInterest = BigDecimal.ZERO;
			BigDecimal arrearTotal = BigDecimal.ZERO;
			BigDecimal breakdownPenalty = BigDecimal.ZERO;
			BigDecimal arrearBreakdownPenalty = BigDecimal.ZERO;
			BigDecimal paymentAfterDueDate = BigDecimal.ZERO;
			BigDecimal adjustmentAmount = BigDecimal.ZERO;
			BigDecimal sewerageBillAmount = BigDecimal.ZERO;
			BigDecimal sewerageAdvance = BigDecimal.ZERO;
			BigDecimal meterRentAmount = BigDecimal.ZERO;
			BigDecimal meterRentArrears = BigDecimal.ZERO;
			if (billType.equals(WaterTaxConstants.BILLTYPE_INTEGRATED)) {
				SewerageDemandInfo sewerageDemandInfo = prepareSewerageDemandInfo(waterConnectionDetails, egBill,
						billType);
				sewerageBillAmount = sewerageDemandInfo.getBillAmount();
				sewerageAdvance = sewerageDemandInfo.getAdvance();
				sewerageReportParams = prepareSewargeReportParams(sewerageDemandInfo);

				stmsTotalNetPayable = stmsTotalNetPayable.add(sewerageDemandInfo.getBillAmount())
						.subtract(sewerageDemandInfo.getDemandcollected()).add(sewerageDemandInfo.getPenalty())
						.add(sewerageDemandInfo.getInterest()).add(sewerageDemandInfo.getArrearAmount())
						.add(sewerageDemandInfo.getStmsArrearPenalty()).add(sewerageDemandInfo.getStmsArrearInterest())
						.subtract(sewerageAdvance).setScale(0, BigDecimal.ROUND_HALF_UP);

				stmsPaymentAfterDueDate = calculatePenaltyAfterDueDate(sewerageDemandInfo.getBillAmount())
						.add(sewerageDemandInfo.getPenalty()).add(sewerageDemandInfo.getArrearAmount())
						.add(sewerageDemandInfo.getInterest()).subtract(sewerageDemandInfo.getDemandcollected())
						.add(sewerageDemandInfo.getStmsArrearPenalty()).add(sewerageDemandInfo.getStmsArrearInterest())
						.subtract(sewerageAdvance).setScale(0, BigDecimal.ROUND_HALF_UP);

				reportParams.putAll(sewerageReportParams);
			}
			final EgDemand currentDemand = egBill.getEgDemand();
			Installment installment = currentDemand.getEgInstallmentMaster();
			if (egBill != null) {
				if (egBill.getEgBillType() != null && egBill.getEgBillType().getCode() != null
						&& egBill.getEgBillType().getCode().equals(billType))
					billObj = egBill;
				if (billObj != null && !billObj.getEgBillDetails().isEmpty())
					for (final EgBillDetails billdet : billObj.getEgBillDetails())
						if (billdet != null)
							if (billdet.getDescription() != null && billdet.getDescription().contains("Water Charges")
									&& billdet.getPurpose() != null) {
								if(billdet.getCrAmount() == null)
									billdet.setCrAmount(BigDecimal.ZERO);
								final String temp1[] = billdet.getDescription().split("Water Charges -");
								if (billdet.getDescription().contains("#")) {
									final String instDesc[] = temp1[1].split("#");
									if (!instDesc[0].isEmpty()
											&& instDesc[0].trim().equals(installment.getDescription()))
										if (billdet.getPurpose()
												.equals(BillAccountDetails.PURPOSE.CURRENT_AMOUNT.toString()))
											billAmount = billAmount.add(billdet.getCrAmount());
										else if (billdet.getPurpose()
												.equals(BillAccountDetails.PURPOSE.ARREAR_AMOUNT.toString()))
											arrearAmount = arrearAmount.add(billdet.getCrAmount());
										else if (billdet.getPurpose()
												.equals(BillAccountDetails.PURPOSE.CURRENT_PENALTY_CHARGES.toString()))
											penalty = penalty.add(billdet.getCrAmount());
										else if (billdet.getPurpose().equals(
												BillAccountDetails.PURPOSE.CURRENT_LATEPAYMENT_CHARGES.toString()))
											interest = interest.add(billdet.getCrAmount());
										else if (billdet.getPurpose()
												.equals(BillAccountDetails.PURPOSE.ARREAR_PENALTY_CHARGES.toString()))
											arrearPenalty = arrearPenalty.add(billdet.getCrAmount());
										else if (billdet.getPurpose().equals(
												BillAccountDetails.PURPOSE.ARREAR_LATEPAYMENT_CHARGES.toString()))
											arrearInterest = arrearInterest.add(billdet.getCrAmount());
										else if (billdet.getPurpose().equals(
                                                                                                BillAccountDetails.PURPOSE.CURRENT_BREAKDOWN_PENALTY_CHARGES.toString()))
										        breakdownPenalty = breakdownPenalty.add(billdet.getCrAmount());
                                                                                else if (billdet.getPurpose().equals(
                                                                                        BillAccountDetails.PURPOSE.ARREAR_BREAKDOWN_PENALTY_CHARGES.toString()))
                                                                                        arrearBreakdownPenalty = arrearBreakdownPenalty.add(billdet.getCrAmount());
                                                                                else if (billdet.getPurpose()
                                                                            			.equals(BillAccountDetails.PURPOSE.METERRENT.toString()))
                                                                            			meterRentAmount = meterRentAmount.add(billdet.getCrAmount());
                                                                            			else if (billdet.getPurpose()
                                                                            			.equals(BillAccountDetails.PURPOSE.METERRENTARREARS.toString()))
                                                                            			meterRentArrears = meterRentArrears.add(billdet.getCrAmount());

								}
							}

				if (currentDemand != null) {
					Calendar previousInstallmentDate = Calendar.getInstance();
					previousInstallmentDate.setTime(currentDemand.getEgInstallmentMaster().getFromDate());
					previousInstallmentDate.add(Calendar.DATE, -1);

					Installment prevInstallment = installmentHibDao.getInsatllmentByModuleForGivenDate(
							currentDemand.getEgInstallmentMaster().getModule(), previousInstallmentDate.getTime());
					EgDemand previousDemand = getPreviousDemand(waterConnectionDetails, prevInstallment).getDemand();
					if (previousDemand != null) {
						for (final EgDemandDetails demdetails : previousDemand.getEgDemandDetails())
							if (demdetails != null && demdetails.getEgDemandReason() != null)
								if (demdetails.getEgDemandReason().getEgDemandReasonMaster().getCode()
										.equals("WTADVANCE")
										&& demdetails.getEgDemandReason().getEgInstallmentMaster()
												.equals(prevInstallment))
									previousAdvanceColl = previousAdvanceColl.add(demdetails.getAmtCollected());
					} else
						previousAdvanceColl = previousAdvanceColl.add(BigDecimal.ZERO);
				}
			}

			if (waterConnectionDetails != null) {

				reportParams.put("sectionAct", sectionAct);
				reportParams.put("cityGrade", city.getGrade());
				// logo for non-pwssb ulb
				reportParams.put("LOGO_PATH", ReportUtil.logoBasePath());
				reportParams.put("municipalityName", city.getPreferences() != null
						? city.getPreferences().getMunicipalityName() : city.getPreferences());
				reportParams.put("cityName", city.getName() != null ? city.getName() : "");
				reportParams.put("cityContactNo",city.getPreferences().getMunicipalityContactNo());
				reportParams.put("cityUrl", cityService.findAll().get(0).getName().toLowerCase() + CITY_PORTAL_URL);
				reportParams.put("onlineWaterUrl", WaterTaxConstants.ONLINE_URL + city.getName().replaceAll("\\s", "")
						+ WaterTaxConstants.ONLINE_URL_WT);
				if (city.getName().equals("Mohali") || city.getName().equals("Pathankot"))
					reportParams.put("onlineSewerageUrl", WaterTaxConstants.ONLINE_URL
					+ city.getName().replaceAll("\\s", "") + WaterTaxConstants.ONLINE_URL_sT);
				else
				reportParams.put("onlineSewerageUrl", WaterTaxConstants.ONLINE_URL
						+ city.getName().replaceAll("\\s", "") + WaterTaxConstants.ONLINE_URL_ST);
				reportParams.put("districtName", city.getDistrictName());
				reportParams.put("assessmentNumber",
						waterConnectionDetails.getConnection().getPropertyIdentifier() != null
								? waterConnectionDetails.getConnection().getPropertyIdentifier() : "");
				reportParams.put("ledgerNumber", waterConnectionDetails.getLedgerNumber());
				reportParams.put("plotSize", waterConnectionDetails.getPlotSize());
				reportParams.put("locality", waterConnectionDetails.getConnection().getLocality() != null
						? waterConnectionDetails.getConnection().getLocality().getName() : "");
				reportParams.put("usageType", waterConnectionDetails.getUsageType().getName());
				reportParams.put("revenueWard", waterConnectionDetails.getConnection().getWard() != null
						? waterConnectionDetails.getConnection().getWard().getName() : "");
				reportParams.put("revenueZone", waterConnectionDetails.getConnection().getZone() != null
						? waterConnectionDetails.getConnection().getZone().getName() : "");
				reportParams.put("block", waterConnectionDetails.getConnection().getBlock() != null
						? waterConnectionDetails.getConnection().getBlock().getName() : "");
				reportParams.put("doorNo",
						waterConnectionDetails.getConnection().getAddress().getHouseNoBldgApt() != null
								? waterConnectionDetails.getConnection().getAddress().getHouseNoBldgApt() : "");
				reportParams.put("consumerNo", waterConnectionDetails.getConnection().getConsumerCode());
				reportParams.put("oldConsumerNo", waterConnectionDetails.getConnection().getOldConsumerNumber());
				reportParams.put("consumerName", waterConnectionDetails.getConnection().getWaterConnectionOwnerInfo()
						.get(0).getOwner().getName());
				reportParams.put("description",
						installment.getFromDate() != null && installment.getToDate() != null
								? formatter.format(installment.getFromDate()) + " to "
										+ formatter.format(installment.getToDate())
								: "");

				reportParams.put("breakdownPenalty", breakdownPenalty.setScale(2, BigDecimal.ROUND_HALF_UP));
	                        reportParams.put("arrearBreakdownPenalty", arrearBreakdownPenalty.setScale(2, BigDecimal.ROUND_HALF_UP));
	                    	reportParams.put("meterRentAmount", meterRentAmount.setScale(2, BigDecimal.ROUND_HALF_UP));
	            			reportParams.put("meterRentArrears", meterRentArrears.setScale(2, BigDecimal.ROUND_HALF_UP));
				reportParams.put("billAmount", billAmount.setScale(2, BigDecimal.ROUND_HALF_UP));
				reportParams.put("totalAmount",
						totalAmount.add(billAmount).add(arrearAmount).setScale(2, BigDecimal.ROUND_HALF_UP));
				reportParams.put("billAmountMeterRent", billAmountMeterRent.add(meterRentAmount).add(meterRentArrears).setScale(2,
						BigDecimal.ROUND_HALF_UP));
				reportParams.put("demandBillNumber", billObj != null ? billObj.getBillNo() : "");
				reportParams.put("demandBillDate", billObj != null ? formatter.format(billObj.getIssueDate()) : "");
				reportParams.put("penalty", penalty.setScale(2, BigDecimal.ROUND_HALF_UP));
				reportParams.put("interest", interest.setScale(2, BigDecimal.ROUND_HALF_UP));
				netAmount = netAmount.add(arrearAmount).add(billAmount).subtract(previousAdvanceColl).setScale(2,
						BigDecimal.ROUND_HALF_UP);
				adjustmentAmount = previousAdvanceColl;
				reportParams.put("netAmount", netAmount);
				reportParams.put("totalnetPayable", totalnetPayable.add(netAmount).add(penalty).add(interest)
						.add(breakdownPenalty).add(meterRentAmount).setScale(2, BigDecimal.ROUND_HALF_UP));

				paymentAfterDueDate = paymentAfterDueDate.add(netAmount).add(penalty).add(interest).add(arrearInterest)
						.add(arrearPenalty).add(breakdownPenalty).add(arrearBreakdownPenalty).add(meterRentAmount)
						.add(meterRentArrears);

				BigDecimal WaterChargesAmount = billAmount.add(meterRentAmount);
				BigDecimal billBalance = BigDecimal.ZERO;
				billBalance = WaterChargesAmount.subtract(previousAdvanceColl);
				

				if (billBalance.compareTo(BigDecimal.ZERO) > 0) {
					reportParams.put("wtmsPaymentAfterDueDate",
							calculatePenaltyAfterDueDateForWater(billAmount.add(meterRentAmount)).add(paymentAfterDueDate).setScale(0,BigDecimal.ROUND_HALF_UP));
					
				} else {
					reportParams.put("wtmsPaymentAfterDueDate", paymentAfterDueDate.setScale(0, BigDecimal.ROUND_HALF_UP));
				}

				reportParams.put("adjustamount", adjustmentAmount.setScale(2, BigDecimal.ROUND_HALF_UP));
				reportParams.put("totalWithPenaltyAndInterest",
						penalty.add(interest).add(billAmount).add(breakdownPenalty).add(meterRentAmount).setScale(2, BigDecimal.ROUND_HALF_UP));
				reportParams.put("waterPaymentDuedate", formatter.format(getWaterPaymentDueDate(billObj.getIssueDate(),billObj.getEgDemand().getEgInstallmentMaster().getId())));
				reportParams.put("seweragePaymentDuedate",formatter.format(getSeweragePaymentDueDate(billObj.getIssueDate(),billObj.getEgDemand().getEgInstallmentMaster().getId())));
				
				AppConfig penaltyPercentappConfig = appconfigService
						.getAppConfigByModuleNameAndKeyName(WaterTaxConstants.MODULE_NAME, PENALTY_PERCENTAGE_KEY);
				BigDecimal penaltyPercentage = BigDecimal.ZERO;
				if (penaltyPercentappConfig != null && penaltyPercentappConfig.getConfValues() != null
						&& !penaltyPercentappConfig.getConfValues().isEmpty()
						&& penaltyPercentappConfig.getConfValues().get(0).getValue() != null)
					penaltyPercentage = new BigDecimal(penaltyPercentappConfig.getConfValues().get(0).getValue());
				reportParams.put("penaltyPercentage", penaltyPercentage);
				AppConfig seweragePenaltyPercentappConfig = appconfigService
						.getAppConfigByModuleNameAndKeyName(WaterTaxConstants.SEWERAGE_MODULE_NAME, PENALTY_PERCENTAGE_KEY);
				BigDecimal seweragePenaltyPercentage = BigDecimal.ZERO;
				if (seweragePenaltyPercentappConfig != null && seweragePenaltyPercentappConfig.getConfValues() != null
						&& !seweragePenaltyPercentappConfig.getConfValues().isEmpty()
						&& seweragePenaltyPercentappConfig.getConfValues().get(0).getValue() != null)
					seweragePenaltyPercentage = new BigDecimal(seweragePenaltyPercentappConfig.getConfValues().get(0).getValue());
				reportParams.put("seweragePenaltyPercentage", seweragePenaltyPercentage);
			    reportParams.put("arrearAmount", arrearAmount.setScale(2, BigDecimal.ROUND_HALF_UP));
				reportParams.put("arrearPenalty", arrearPenalty.setScale(2, BigDecimal.ROUND_HALF_UP));
				reportParams.put("arrearInterest", arrearInterest.setScale(2, BigDecimal.ROUND_HALF_UP));
				reportParams.put("arrearTotal", arrearTotal.add(arrearAmount).add(arrearPenalty).add(arrearInterest)
						.setScale(2, BigDecimal.ROUND_HALF_UP));
				BigDecimal waterNetAmount = BigDecimal.ZERO;
                                reportParams.put("waterNetAmount",
                                        waterNetAmount.add(netAmount).add(penalty).add(interest).add(breakdownPenalty)
                                                .add(arrearPenalty.setScale(2, BigDecimal.ROUND_HALF_UP))
                                                .add(arrearInterest.setScale(2, BigDecimal.ROUND_HALF_UP))
                                                .add(arrearBreakdownPenalty.setScale(2, BigDecimal.ROUND_HALF_UP)));
				reportParams.put("sewerageNetAmount", stmsTotalNetPayable);
				
				reportParams.put("guardianName",
						waterConnectionDetails.getConnection().getWaterConnectionOwnerInfo().get(0).getOwner()
								.getGuardian() != null
										? waterConnectionDetails.getConnection().getWaterConnectionOwnerInfo().get(0)
												.getOwner().getGuardian()
										: "");
				reportParams.put("streetName",
						waterConnectionDetails.getConnection().getAddress().getStreetRoadLine() != null
										? waterConnectionDetails.getConnection().getAddress().getStreetRoadLine()
										: "");
				reportParams.put("landMark",
						waterConnectionDetails.getConnection().getAddress().getLandmark() != null
										? waterConnectionDetails.getConnection().getAddress().getLandmark()
										: "");
				reportParams.put("mobileNumber",
						waterConnectionDetails.getConnection().getWaterConnectionOwnerInfo().get(0).getOwner()
								.getMobileNumber() != null
										? waterConnectionDetails.getConnection().getWaterConnectionOwnerInfo().get(0)
												.getOwner().getMobileNumber()
										: "");
				reportParams.put("address", waterConnectionDetails.getConnection().getAddress().getAreaLocalitySector());
				reportParams.put("natureOfConnection", waterConnectionDetails.getConnection().getAddress().getBuildingName() != null ? waterConnectionDetails.getConnection().getAddress().getBuildingName():"");
				reportParams.put("netAmountPayable", totalnetPayable.add(netAmount).add(penalty).add(interest)
						.add(arrearPenalty).add(arrearInterest).setScale(2, BigDecimal.ROUND_HALF_UP));
			}
		}
		return reportParams;
	}

	private BigDecimal calculatePenaltyAfterDueDateForWater(BigDecimal billAmount) {
		BigDecimal penaltyAmount = billAmount;
		AppConfig penaltyPercentappConfig = appconfigService
				.getAppConfigByModuleNameAndKeyName(WaterTaxConstants.MODULE_NAME, PENALTY_PERCENTAGE_KEY);
		BigDecimal percent = new BigDecimal(penaltyPercentappConfig.getConfValues().get(0).getValue());
		BigDecimal hundred = new BigDecimal(100);
		return penaltyAmount.multiply(percent).divide(hundred);
	}
	
	private BigDecimal calculatePenaltyAfterDueDate(BigDecimal billAmount) {
		BigDecimal penaltyAmount = billAmount;
		AppConfig penaltyPercentappConfig = appconfigService
				.getAppConfigByModuleNameAndKeyName(WaterTaxConstants.SEWERAGE_MODULE_NAME, PENALTY_PERCENTAGE_KEY);
		BigDecimal percent = new BigDecimal(penaltyPercentappConfig.getConfValues().get(0).getValue());
		BigDecimal hundred = new BigDecimal(100);
		return penaltyAmount.multiply(percent).divide(hundred);
	}



	
	private Date getWaterPaymentDueDate(Date billCreatedDate,Integer installmentId) {
		
		Module m=moduleDao.getModuleByName("Water Tax Management");
		AppConfig penaltyappConfig = appconfigService.getAppConfigByModuleNameAndKeyName(WaterTaxConstants.MODULE_NAME,
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

	private Date getSeweragePaymentDueDate(Date billCreatedDate,Integer installmentId) {
		Module m=moduleDao.getModuleByName("Water Tax Management");
		AppConfig penaltyappConfig = appconfigService.getAppConfigByModuleNameAndKeyName(WaterTaxConstants.MODULE_NAME,
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
	
	@Transactional(timeout=1800)
	private void printDemandBill(final EgBill egBill,final Boolean isSmsEnabled) {
		ReportRequest reportRequest = null;
		final WaterConnectionDetails waterConnectionDetails = waterConnectionDetailsService
				.findByConsumerCodeAndConnectionStatus(egBill.getConsumerId(), ConnectionStatus.ACTIVE);
		InputStream billPDF = null;
		ReportOutput reportOutput;
		if (egBill != null) {
			LOGGER.debug("Bill Object with id= " + egBill.getId() + " for consumercode " + egBill.getConsumerId());
	                AppConfig appconfigIsPwssb = appconfigService.getAppConfigByModuleNameAndKeyName("Administration", "IS_PWSSB_ULB");
	                Boolean isPwssb = appconfigIsPwssb.getConfValues().get(0).getValue().equals(CollectionConstants.IS_PWSSB_ULB);
	                Boolean isDwssb = Boolean.FALSE;
	                if (!isPwssb) {
	                    AppConfig appconfigIsDwssb = appconfigService.getAppConfigByModuleNameAndKeyName("Administration", "IS_DWSSB_ULB");
	                    isDwssb = appconfigIsDwssb.getConfValues().get(0).getValue().equals(CollectionConstants.IS_DWSSB_ULB);  
	                }
			
			if (waterConnectionDetails.getConnectionType().getCode().equals("NON_METERED"))
				reportRequest = prepareReportRequestForNonMetred(egBill, waterConnectionDetails, reportRequest,
				        isPwssb, isDwssb,isSmsEnabled);

			if (waterConnectionDetails.getConnectionType().getCode().equals("METERED"))
				reportRequest = prepareReportRequestForMetered(egBill, waterConnectionDetails, reportRequest,
				        isPwssb, isDwssb,isSmsEnabled);

			reportOutput = reportService.createReport(reportRequest);
			if (reportOutput != null && reportOutput.getReportOutputData() != null)
				billPDF = new ByteArrayInputStream(reportOutput.getReportOutputData());

			if (waterConnectionDetails != null)
				saveApplicationDocWithFileStore(egBill, waterConnectionDetails, billPDF);
		}
	}

	private ReportRequest prepareReportRequestForMetered(EgBill egBill, WaterConnectionDetails waterConnectionDetails,
			ReportRequest reportRequest, Boolean isPwssb, Boolean isDwssb,Boolean isSmsEnabled) {
		if (egBill.getEgBillType().getCode().equals(WaterTaxConstants.BILLTYPE_MANUAL)) {
			final Map<String, Object> reportParams = prepareReportParams(egBill, waterConnectionDetails,
					WaterTaxConstants.BILLTYPE_MANUAL);
			addMeterDetails(reportParams, waterConnectionDetails);
			if (isPwssb || isDwssb)
				reportRequest = new ReportRequest("waterMeteredDemandBillwithpwssb", egBill, reportParams);
			else
				reportRequest = new ReportRequest("waterMeteredDemandBill", egBill, reportParams);

			if(isSmsEnabled)
			waterConnectionSmsAndEmailService.buildSMSForBill(waterConnectionDetails, egBill.getEgBillType().getCode(),
					(String) reportParams.get("waterPaymentDuedate"),
					(String) reportParams.get("seweragePaymentDuedate"), reportParams.get("waterNetAmount").toString(),
					reportParams.get("sewerageNetAmount").toString(),
					egBill.getEgDemand().getEgInstallmentMaster().getDescription(),
					(String) reportParams.get("onlineWaterUrl"), (String) reportParams.get("sewerageConsumerNo"),
					(String) reportParams.get("onlineSewerageUrl"));

		} else {
			final Map<String, Object> reportParams = prepareReportParams(egBill, waterConnectionDetails,
					WaterTaxConstants.BILLTYPE_INTEGRATED);
			addMeterDetails(reportParams, waterConnectionDetails);
			if (isPwssb || isDwssb)
				reportRequest = new ReportRequest("integrated_water_metered_sewerage_demand_bill_with_pwssb", egBill,
						reportParams);
			else
				reportRequest = new ReportRequest("integrated_water_metered_sewerage_demand_bill", egBill,
						reportParams);
			
			if(isSmsEnabled)
			waterConnectionSmsAndEmailService.buildSMSForBill(waterConnectionDetails, egBill.getEgBillType().getCode(),
					(String) reportParams.get("waterPaymentDuedate"),
					(String) reportParams.get("seweragePaymentDuedate"), reportParams.get("waterNetAmount").toString(),
					reportParams.get("sewerageNetAmount").toString(),
					egBill.getEgDemand().getEgInstallmentMaster().getDescription(),
					(String) reportParams.get("onlineWaterUrl"), (String) reportParams.get("sewerageConsumerNo"),
					(String) reportParams.get("onlineSewerageUrl"));

		}
		return reportRequest;
	}

	private ReportRequest prepareReportRequestForNonMetred(EgBill egBill, WaterConnectionDetails waterConnectionDetails,
			ReportRequest reportRequest, Boolean isPwssb, Boolean isDwssb, Boolean isSmsEnabled) {
		if (egBill.getEgBillType().getCode().equals(WaterTaxConstants.BILLTYPE_MANUAL)) {
			final Map<String, Object> reportParams = prepareReportParams(egBill, waterConnectionDetails,
					WaterTaxConstants.BILLTYPE_MANUAL);
			if (isPwssb || isDwssb)
				reportRequest = new ReportRequest("waterChargesDemandBillwithpwssb", egBill, reportParams);
			else
				reportRequest = new ReportRequest("waterChargesDemandBill", egBill, reportParams);
           
			if(isSmsEnabled)
			waterConnectionSmsAndEmailService.buildSMSForBill(waterConnectionDetails, egBill.getEgBillType().getCode(),
					(String) reportParams.get("waterPaymentDuedate"),
					(String) reportParams.get("seweragePaymentDuedate"), reportParams.get("waterNetAmount").toString(),
					reportParams.get("sewerageNetAmount").toString(),
					egBill.getEgDemand().getEgInstallmentMaster().getDescription(),
					(String) reportParams.get("onlineWaterUrl"), (String) reportParams.get("sewerageConsumerNo"),
					(String) reportParams.get("onlineSewerageUrl"));

		} else {
			final Map<String, Object> reportParams = prepareReportParams(egBill, waterConnectionDetails,
					WaterTaxConstants.BILLTYPE_INTEGRATED);
			if (isPwssb || isDwssb)
				reportRequest = new ReportRequest("integrated_water_sewerage_demand_bill_with_pwssb", egBill,
						reportParams);
			else
				reportRequest = new ReportRequest("integrated_water_sewerage_demand_bill", egBill, reportParams);
			
			if(isSmsEnabled)
			waterConnectionSmsAndEmailService.buildSMSForBill(waterConnectionDetails, egBill.getEgBillType().getCode(),
					(String) reportParams.get("waterPaymentDuedate"),
					(String) reportParams.get("seweragePaymentDuedate"), reportParams.get("waterNetAmount").toString(),
					reportParams.get("sewerageNetAmount").toString(),
					egBill.getEgDemand().getEgInstallmentMaster().getDescription(),
					(String) reportParams.get("onlineWaterUrl"), (String) reportParams.get("sewerageConsumerNo"),
					(String) reportParams.get("onlineSewerageUrl"));

		}
		return reportRequest;
	}

	private void addMeterDetails(Map<String, Object> reportParams, WaterConnectionDetails waterConnectionDetails) {
		final SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		reportParams.put("meterStatus", !waterConnectionDetails.getMeterConnection().isEmpty()
				? waterConnectionDetails.getMeterConnection().get(0).getMeterStatus() : "");
		reportParams.put("unitsConsumed", !waterConnectionDetails.getMeterConnection().isEmpty()
				? waterConnectionDetails.getMeterConnection().get(0).getUnitsConsumed() : "");
		List<MeterReadingDetails> previousMeterReadingConnectionDetails = getPreviousMeterReadingDetails(
				waterConnectionDetails);
		if (previousMeterReadingConnectionDetails != null && !previousMeterReadingConnectionDetails.isEmpty()) {
			reportParams.put("lastReadingDate",
					(previousMeterReadingConnectionDetails.get(0).getCurrentReadingDate() != null)
							? formatter.format(previousMeterReadingConnectionDetails.get(0).getCurrentReadingDate())
							: "");
			reportParams.put("lastReading", previousMeterReadingConnectionDetails.get(0).getCurrentReading() != null
					? previousMeterReadingConnectionDetails.get(0).getCurrentReading() : "");
		} else {
			reportParams.put("lastReadingDate", "");
			reportParams.put("lastReading", "");
		}
		if (!waterConnectionDetails.getMeterConnection().isEmpty()) {
			reportParams
					.put("currentReadingDate",
							waterConnectionDetails.getMeterConnection().get(0).getCurrentReadingDate() != null
									? formatter.format(
											waterConnectionDetails.getMeterConnection().get(0).getCurrentReadingDate())
									: "");
			reportParams.put("currentReading",
					waterConnectionDetails.getMeterConnection().get(0).getCurrentReading() != null
							? waterConnectionDetails.getMeterConnection().get(0).getCurrentReading() : "");

		} else {
			reportParams.put("currentReadingDate", "");
			reportParams.put("currentReading", "");
		}
	}

	private List<MeterReadingDetails> getPreviousMeterReadingDetails(
			final WaterConnectionDetails waterConnectionDetails) {
		Installment currentInstallment = !waterConnectionDetails.getMeterConnection().isEmpty()
				? (waterConnectionDetails.getMeterConnection().get(0).getInstallment() != null
						? waterConnectionDetails.getMeterConnection().get(0).getInstallment() : null)
				: null;
		List<MeterReadingDetails> previousMeterReadingConnectionDetails = new ArrayList<>();
		if (currentInstallment == null)
			return previousMeterReadingConnectionDetails;
		final Module module = moduleDao.getModuleByName(WaterTaxConstants.MODULE_NAME);
		List<Long> connectionDetailIds = new ArrayList<>();
		connectionDetailIds.add(waterConnectionDetails.getId());
		Calendar cal = Calendar.getInstance();
		cal.setTime(currentInstallment.getFromDate());
		cal.add(Calendar.DATE, -1);
		Date endDate = cal.getTime();
		Installment previousInstallment = installmentHibDao.getInsatllmentByModuleAndEndDate(module, endDate,
				WaterTaxConstants.QUARTERLY);
		previousMeterReadingConnectionDetails = meterReadingDetailsRepository
				.getByInstallmentAndWaterConnectionDetailIds(previousInstallment.getId(), connectionDetailIds);
		return previousMeterReadingConnectionDetails;
	}

	@SuppressWarnings("unused")
	private Query getBillForConsumerCode(final String consumercode, final Date finDate) {
		final StringBuilder queryStringtemp = new StringBuilder();

		queryStringtemp
				.append("select distinct bill From EgBill bill,EgBillType billtype,EgDemand demand,WaterConnection conn,"
						+ " WaterConnectionDetails connDet,EgwStatus status,WaterDemandConnection conndem "
						+ " where billtype.id=bill.egBillType and billtype.code='MANUAL' and bill.consumerId = conn.consumerCode "
						+ " and conn.id=connDet.connection and connDet.id=conndem.waterConnectionDetails "
						+ " and demand.id=conndem.demand and demand.id=bill.egDemand and bill.consumerId = :consumercode "
						+ " and bill.createDate >= :financialyearstartdate and bill.serviceCode='WT' "
						+ " and bill.is_Cancelled='N' and connDet.connectionType.code in ('NON_METERED','METERED') "
						+ " and connDet.connectionStatus='ACTIVE' and connDet.status=status.id "
						+ " and status.moduletype = :moduletype and status.code = :statuscode ")
				.append(" and not exists (select ad from ApplicationDocuments ad where ad.documentNumber=bill.billNo)")
				.append(" order by bill.id desc ");
		final Query query = persistenceService.getSession().createQuery(queryStringtemp.toString())
				.setString("moduletype", WaterTaxConstants.MODULETYPE).setString("consumercode", consumercode)
				.setDate("financialyearstartdate", finDate)
				.setString("statuscode", WaterTaxConstants.APPLICATION_STATUS_SANCTIONED);
		LOGGER.debug("query to get Single Bill Object for Consumercode=" + query.toString());
		return query;
	}

	@Transactional
	public void saveApplicationDocWithFileStore(final EgBill egBill,
			final WaterConnectionDetails waterConnectionDetails, final InputStream fileStream) {
		final ApplicationDocuments appDocuments = new ApplicationDocuments();
		final Set<FileStoreMapper> filestoreSet = new HashSet<>();
		appDocuments.setDocumentNumber(egBill.getBillNo());
		appDocuments.setDocumentDate(egBill.getIssueDate());
		String documentName;
		if (egBill.getEgBillType().getCode().equals(WaterTaxConstants.BILLTYPE_MANUAL))
			documentName = WaterTaxConstants.DOCUMENTNAMEFORBILL;
		else
			documentName = WaterTaxConstants.DOCUMENTNAMEFOR_INTEGRATEDBILL;

		final DocumentNames docNmae = documentNamesService.findByApplicationTypeAndDocumentName("NEWCONNECTION",
				documentName);
		if (docNmae != null) {
			appDocuments.setDocumentNames(docNmae);
			appDocuments.setCreatedDate(new Date());
			appDocuments.setWaterConnectionDetails(waterConnectionDetails);
			final String fileName = appDocuments.getDocumentNumber() + WaterTaxConstants.PDFEXTENTION;
			final FileStoreMapper fileStore = fileStoreService.store(fileStream, fileName,
					WaterTaxConstants.APPLICATIONPDFNAME, WaterTaxConstants.FILESTORE_MODULECODE);
			filestoreSet.add(fileStore);
			appDocuments.setSupportDocs(filestoreSet);
			applicationDocumentsRepository.save(appDocuments);
		}
	}

	@Override
	@Transactional(timeout=1800)
	public void bulkBillGeneration(final Integer modulo, final Integer billsCount) {

		LOGGER.info("Entered into executeJob" + modulo + " with given billsCount " + billsCount);

		final Long jobStartTime = System.currentTimeMillis();
		final Query query = getQuery(modulo, billsCount);
		int noOfBillsGenerated = 0;
		final List<EgBill> consumerNumberBillList = query.list();
		final List<String> consumerNumbers = new ArrayList<>();
		for (final EgBill bill : consumerNumberBillList)
			consumerNumbers.add(bill.getConsumerId());
		LOGGER.info("executeJob" + modulo + " - got " + consumerNumbers + " consumer numbers for bill generation");
		Long timeTaken = System.currentTimeMillis() - jobStartTime;
		LOGGER.info("executeJob" + modulo + " took " + timeTaken / 1000
				+ " secs for consumer list selection - consumer numbers = " + consumerNumberBillList.size());
		LOGGER.info("executeJob" + modulo + " - Generating bills.....");
		Boolean isSmsEnabled = this.environmentSettings.getProperty("water.bill.generation.sms.enabled",Boolean.class);
		for (final EgBill bill : consumerNumberBillList)
			try {

				printDemandBill(bill,isSmsEnabled);
				noOfBillsGenerated++;

			} catch (final Exception e) {
				LOGGER.error(" Error while generating  bill via BulkWaterConnBillGenerationJob Job " + modulo.toString()
						+ bill.getConsumerId(), e);

			}

		timeTaken = jobStartTime - System.currentTimeMillis();
		LOGGER.info("Exiting from executeJob" + modulo + "executeJob" + modulo + " - " + noOfBillsGenerated + "/"
				+ consumerNumberBillList.size() + " Bill(s) generated in " + timeTaken / 1000 + " (secs)");
		LOGGER.debug("Exiting from executeJob" + modulo);
	}

	private Query getQuery(final Integer modulo, final Integer billsCount) {
		final StringBuilder queryString = new StringBuilder();
		queryString
				.append("select bill From EgBill bill,EgBillType billtype,EgDemand demand,WaterConnection conn,"
						+ " WaterConnectionDetails connDet,EgwStatus status,WaterDemandConnection conndem"
						+ " where billtype.id=bill.egBillType and billtype.code in ('MANUAL','INTEGRATED') and bill.consumerId = conn.consumerCode "
						+ " and conn.id=connDet.connection "
						+ " and connDet.id=conndem.waterConnectionDetails and demand.id=conndem.demand and demand.id=bill.egDemand "
						+ " and bill.is_Cancelled='N' and connDet.connectionType.code in ('NON_METERED','METERED') "
						+ " and connDet.connectionStatus='ACTIVE' and connDet.status=status.id and status.moduletype = :moduletype "
						+ " and status.code = :statuscode and bill.module.name = :moduleName ")
				.append(" and not exists (select ad from ApplicationDocuments ad where ad.documentNumber=bill.billNo)")
				.append(" and MOD(conn.id, ").append(WaterTaxConstants.QUARTZ_BULKBILL_JOBS).append(") = :modulo ");
		final Query query = persistenceService.getSession().createQuery(queryString.toString())
				.setInteger("modulo", modulo).setString("moduletype", WaterTaxConstants.MODULETYPE)
				.setString("statuscode", WaterTaxConstants.APPLICATION_STATUS_SANCTIONED)
				.setString("moduleName", WaterTaxConstants.MODULE_NAME);
		query.setMaxResults(billsCount);
		LOGGER.debug("query to get All consumernumbers where Bill is generated" + query.toString());
		return query;
	}

	@Override
	@Transactional
	public void generateBillForConsumercode(final String consumerCode, Integer installmentId, final String billType) {
		ProcedureCall procedureCall = null;
		final WaterConnectionDetails waterConnectionDetails = waterConnectionDetailsService
				.findByConsumerCodeAndConnectionStatus(consumerCode, ConnectionStatus.ACTIVE);
		final Module module = moduleDao.getModuleByName(WaterTaxConstants.MODULE_NAME);
		Installment currentInstallment = installmentHibDao.findById(installmentId, Boolean.TRUE);
		Calendar cal = Calendar.getInstance();
		cal.setTime(currentInstallment.getFromDate());
		cal.add(Calendar.DATE, -1);
		Date endDate = cal.getTime();

		Installment previousInstallment = installmentHibDao.getInsatllmentByModuleAndEndDate(module, endDate,
				"Quarterly");
		if (waterConnectionDetails != null) {
			procedureCall = entityQueryService.getSession()
					.createStoredProcedureCall("wtms_bill_genaration_for_consumer_code");
			procedureCall.registerParameter("in_consumercode", String.class, ParameterMode.IN);
			procedureCall.getParameterRegistration("in_consumercode").bindValue(consumerCode);
			procedureCall.registerParameter("in_conn_id", int.class, ParameterMode.IN);
			procedureCall.getParameterRegistration("in_conn_id")
					.bindValue(waterConnectionDetails.getConnection().getId().intValue());
			procedureCall.registerParameter("in_conn_det_id", int.class, ParameterMode.IN);
			procedureCall.getParameterRegistration("in_conn_det_id").bindValue(waterConnectionDetails != null
					? waterConnectionDetails.getId().intValue() : waterConnectionDetails);
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
					.bindValue(waterConnectionDetails.getConnection().getLocality() != null
							? waterConnectionDetails.getConnection().getLocality().getId().intValue() : null);
			procedureCall.registerParameter("in_bill_type", String.class, ParameterMode.IN);
			procedureCall.getParameterRegistration("in_bill_type").bindValue(billType);
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
		final EgBill egBill = getBillForDownloadPdfByConsumerCode(consumerCode, billType);
		LOGGER.debug("single hscnumber Bill Object = " + (egBill != null ? egBill.getBillNo() : null)
				+ " for consumercode " + consumerCode);
		if (egBill == null)
			throw new ApplicationRuntimeException("err.no.demand.bill.generated");
		InputStream billPDF = null;
		ReportRequest reportRequest = null;
		ReportOutput reportOutput;
		if (waterConnectionDetails != null)
			if (egBill != null) {
				LOGGER.debug("single hscnumber Bill Object with id= " + egBill.getId() + " for consumercode "
						+ consumerCode);
		                AppConfig appconfigIsPwssb = appconfigService.getAppConfigByModuleNameAndKeyName("Administration", "IS_PWSSB_ULB");
		                Boolean isPwssb = appconfigIsPwssb.getConfValues().get(0).getValue().equals(CollectionConstants.IS_PWSSB_ULB);
		                Boolean isDwssb = Boolean.FALSE;
		                if (!isPwssb) {
		                    AppConfig appconfigIsDwssb = appconfigService.getAppConfigByModuleNameAndKeyName("Administration", "IS_DWSSB_ULB");
		                    isDwssb = appconfigIsDwssb.getConfValues().get(0).getValue().equals(CollectionConstants.IS_DWSSB_ULB);  
		                }
				final Map<String, Object> reportParams = prepareReportParams(egBill, waterConnectionDetails, billType);
				if (waterConnectionDetails.getConnectionType().getCode()
						.equals(ConnectionType.NON_METERED.toString())) {
					if (billType.equals(WaterTaxConstants.BILLTYPE_MANUAL))
						if (isPwssb || isDwssb)
							reportRequest = new ReportRequest("waterChargesDemandBillwithpwssb", egBill, reportParams);
						else
							reportRequest = new ReportRequest("waterChargesDemandBill", egBill, reportParams);

					else if (isPwssb || isDwssb)
						reportRequest = new ReportRequest("integrated_water_sewerage_demand_bill_with_pwssb", egBill,
								reportParams);
					else
						reportRequest = new ReportRequest("integrated_water_sewerage_demand_bill", egBill,
								reportParams);
				} else if (waterConnectionDetails.getConnectionType().getCode()
						.equals(ConnectionType.METERED.toString())) {
					addMeterDetails(reportParams, waterConnectionDetails);
					if (billType.equals(WaterTaxConstants.BILLTYPE_MANUAL))
						if (isPwssb || isDwssb)
							reportRequest = new ReportRequest("waterMeteredDemandBillwithpwssb", egBill, reportParams);
						else
							reportRequest = new ReportRequest("waterMeteredDemandBill", egBill, reportParams);
					else if (isPwssb || isDwssb)
						reportRequest = new ReportRequest("integrated_water_metered_sewerage_demand_bill_with_pwssb",
								egBill, reportParams);
					else
						reportRequest = new ReportRequest("integrated_water_metered_sewerage_demand_bill", egBill,
								reportParams);
					reportParams.put("currentMeterReadingDate",
							waterConnectionDetails.getMeterConnection().get(0).getCurrentReadingDate());
				}
				reportOutput = reportService.createReport(reportRequest);
				if (reportOutput != null && reportOutput.getReportOutputData() != null)
					billPDF = new ByteArrayInputStream(reportOutput.getReportOutputData());
				String documentName = billType.equals(WaterTaxConstants.BILLTYPE_MANUAL)
						? WaterTaxConstants.DOCUMENTNAMEFORBILL : WaterTaxConstants.DOCUMENTNAMEFOR_INTEGRATEDBILL;
				final List<Long> fileStoreIdList = searchNoticeService.getDocuments(egBill.getBillNo(), consumerCode,
						documentName);
				if (fileStoreIdList.isEmpty())
					saveApplicationDocWithFileStore(egBill, waterConnectionDetails, billPDF);
               if(this.environmentSettings.getProperty("water.bill.generation.sms.enabled",Boolean.class))
				waterConnectionSmsAndEmailService.buildSMSForBill(waterConnectionDetails,
						egBill.getEgBillType().getCode(), (String) reportParams.get("waterPaymentDuedate"),
						(String) reportParams.get("seweragePaymentDuedate"),
						reportParams.get("waterNetAmount").toString(), reportParams.get("sewerageNetAmount").toString(),
						egBill.getEgDemand().getEgInstallmentMaster().getDescription(),
						(String) reportParams.get("onlineWaterUrl"), (String) reportParams.get("sewerageConsumerNo"),
						(String) reportParams.get("onlineSewerageUrl"));
			}
	}

	public EgBill getBillForDownloadPdfByConsumerCode(final String consumerCode, final String billType) {
		EgBill egBill = null;
		final String query = " select distinct bill From EgBill bill,EgBillType billtype,WaterConnection conn,WaterConnectionDetails connDet,EgwStatus status,WaterDemandConnection conndem  , EgDemand demd "
				+ "where billtype.id=bill.egBillType and billtype.code =:billType and bill.consumerId = conn.consumerCode and conn.id=connDet.connection and connDet.id=conndem.waterConnectionDetails "
				+ " and demd.id=bill.egDemand and demd.id=conndem.demand "
				+ " and demd.isHistory = 'N' and  bill.is_Cancelled='N' and bill.serviceCode='WT' "
				+ " and connDet.connectionStatus='ACTIVE' and connDet.status=status.id and status.moduletype='WATERTAXAPPLICATION' "
				+ " and status.code='SANCTIONED' and conn.consumerCode =:consumerCode order by bill.id desc";
		final Query hibquery = persistenceService.getSession().createQuery(query.toString())
				.setString("consumerCode", consumerCode).setString("billType", billType);
		final List<EgBill> egBilltemp = hibquery.list();
		if (!egBilltemp.isEmpty())
			egBill = egBilltemp.get(0);
		LOGGER.debug("query to get " + billType + " Bill for single consumernumber" + query.toString()
				+ " for consumer No= " + consumerCode);
		return egBill;
	}

	private SewerageDemandInfo prepareSewerageDemandInfo(final WaterConnectionDetails waterConnectionDetails,
			final EgBill egBill, final String billType) {
		EgBill billObj = null;
		BigDecimal arrarAmount = BigDecimal.ZERO;
		BigDecimal totalAmount = BigDecimal.ZERO;
		BigDecimal penalty = BigDecimal.ZERO;
		BigDecimal billAmount = BigDecimal.ZERO;
		BigDecimal interest = BigDecimal.ZERO;
		BigDecimal arrearPenalty = BigDecimal.ZERO;
		BigDecimal arrearInterest = BigDecimal.ZERO;
		BigDecimal previousAdvanceColl = BigDecimal.ZERO;

		SewerageDemandInfo sewerageDemandInfo = new SewerageDemandInfo();
		if (waterConnectionDetails.getConnection().getSewerageIdentifier() != null) {
			SewerageConnection sewerageConnection = sewerageConnectionService
					.findByOldConsumerNumber(waterConnectionDetails.getConnection().getSewerageIdentifier());
			if (sewerageConnection == null) {
			    sewerageConnection = sewerageConnectionService.findByShscNumberWithStatus(waterConnectionDetails.getConnection().getSewerageIdentifier());
			}
			if (sewerageConnection != null) {
				sewerageDemandInfo
						.setSewerageOldConsumerNumber(sewerageConnection.getOldConsumerNumber());
				sewerageDemandInfo.setSewerageConsumerNumber(sewerageConnection.getShscNumber());

				SewerageApplicationDetails sewerageApplicationDetails=sewerageConnection.getApplicationDetails().get(0);

				sewerageDemandInfo.setSewerageUsageType(sewerageApplicationDetails.getConnectionDetail().getUsageType().getName());
				final EgDemand currentDemand = egBill.getEgDemand();
				Installment installment = currentDemand.getEgInstallmentMaster();
				if (egBill != null) {
					if (egBill.getEgBillType() != null && egBill.getEgBillType().getCode() != null
							&& egBill.getEgBillType().getCode().equals(billType))
						billObj = egBill;
					if (billObj != null && !billObj.getEgBillDetails().isEmpty())
						for (final EgBillDetails billdet : billObj.getEgBillDetails())
							if (billdet != null)
								if (billdet.getDescription() != null
										&& billdet.getDescription().contains("Sewerage Charges")
										&& billdet.getPurpose() != null) {
									final String temp1[] = billdet.getDescription().split("Sewerage Charges -");
									if (billdet.getDescription().contains("#")) {
										final String instDesc[] = temp1[1].split("#");
										if (!instDesc[0].isEmpty()
												&& instDesc[0].trim().equals(installment.getDescription()))
											if (billdet.getPurpose()
													.equals(BillAccountDetails.PURPOSE.CURRENT_AMOUNT.toString()))
												billAmount = billAmount.add(billdet.getCrAmount());
											else if (billdet.getPurpose()
													.equals(BillAccountDetails.PURPOSE.ARREAR_AMOUNT.toString()))
												arrarAmount = arrarAmount.add(billdet.getCrAmount());
											else if (billdet.getPurpose().equals(
													BillAccountDetails.PURPOSE.CURRENT_PENALTY_CHARGES.toString()))
												penalty = penalty.add(billdet.getCrAmount());
											else if (billdet.getPurpose().equals(
													BillAccountDetails.PURPOSE.CURRENT_LATEPAYMENT_CHARGES.toString()))
												interest = interest.add(billdet.getCrAmount());
											else if (billdet.getPurpose().equals(
													BillAccountDetails.PURPOSE.ARREAR_PENALTY_CHARGES.toString()))
												arrearPenalty = arrearPenalty.add(billdet.getCrAmount());
											else if (billdet.getPurpose().equals(
													BillAccountDetails.PURPOSE.ARREAR_LATEPAYMENT_CHARGES.toString()))
												arrearInterest = arrearInterest.add(billdet.getCrAmount());

									}
								}

					if (currentDemand != null) {
						Calendar previousInstallmentDate = Calendar.getInstance();
						previousInstallmentDate.setTime(currentDemand.getEgInstallmentMaster().getFromDate());
						previousInstallmentDate.add(Calendar.DATE, -1);
						final Module module = moduleService.getModuleByName(SewerageTaxConstants.MODULE_NAME);
						Installment prevInstallment = installmentHibDao.getInsatllmentByModuleForGivenDate(module,
								previousInstallmentDate.getTime());
						EgDemand previousDemand = getPreviousDemandSewerage(
								sewerageConnection.getApplicationDetails().get(0), prevInstallment).getDemand();
						if (previousDemand != null) {
							for (final EgDemandDetails demdetails : previousDemand.getEgDemandDetails())
								if (demdetails != null && demdetails.getEgDemandReason() != null)
									if (demdetails.getEgDemandReason().getEgDemandReasonMaster().getCode()
											.equals("SEWERAGEADVANCE")
											&& demdetails.getEgDemandReason().getEgInstallmentMaster()
													.equals(prevInstallment))
										previousAdvanceColl = previousAdvanceColl.add(demdetails.getAmtCollected());
						} else
							previousAdvanceColl = previousAdvanceColl.add(BigDecimal.ZERO);
					}

				}

			}
		}
		totalAmount = arrarAmount.add(billAmount);
		sewerageDemandInfo.setArrearAmount(arrarAmount);
		sewerageDemandInfo.setBillAmount(billAmount);
		sewerageDemandInfo.setPenalty(penalty);
		sewerageDemandInfo.setInterest(interest);
		sewerageDemandInfo.setTotalAmount(totalAmount);
		sewerageDemandInfo.setStmsArrearPenalty(arrearPenalty);
		sewerageDemandInfo.setStmsArrearInterest(arrearInterest);
		sewerageDemandInfo.setAdvance(previousAdvanceColl);
		return sewerageDemandInfo;
	}

	private Map<String, Object> prepareSewargeReportParams(SewerageDemandInfo sewerageDemandInfo) {
		final Map<String, Object> sewerageReportParams = new HashMap<>();
		BigDecimal billBalance = BigDecimal.ZERO;
		BigDecimal penalty = BigDecimal.ZERO;
		sewerageReportParams.put("stmsArrearAmount",
				sewerageDemandInfo.getArrearAmount().setScale(2, BigDecimal.ROUND_HALF_UP));
		sewerageReportParams.put("stmsBillAmount",
				sewerageDemandInfo.getBillAmount().setScale(2, BigDecimal.ROUND_HALF_UP));
		sewerageReportParams.put("stmsTotalAmount",
				sewerageDemandInfo.getTotalAmount().setScale(2, BigDecimal.ROUND_HALF_UP));
		sewerageReportParams.put("stmsPenalty", sewerageDemandInfo.getPenalty().setScale(2, BigDecimal.ROUND_HALF_UP));
		sewerageReportParams.put("stmsInterest",
				sewerageDemandInfo.getInterest().setScale(2, BigDecimal.ROUND_HALF_UP));
		sewerageReportParams
				.put("stmsTotalnetPayable",
						sewerageDemandInfo.getBillAmount().subtract(sewerageDemandInfo.getDemandcollected())
								.add(sewerageDemandInfo.getPenalty())
								.add(sewerageDemandInfo.getInterest()
										.add(sewerageDemandInfo.getArrearAmount().setScale(2,
												BigDecimal.ROUND_HALF_UP)))
								.subtract(sewerageDemandInfo.getAdvance()).setScale(2, BigDecimal.ROUND_HALF_UP));
		sewerageReportParams.put("stmsAdjustamount",
				sewerageDemandInfo.getAdvance().setScale(2, BigDecimal.ROUND_HALF_UP));
		sewerageReportParams.put("stmsTotalWithPenaltyAndInterest",
				sewerageDemandInfo.getBillAmount().add(sewerageDemandInfo.getPenalty())
						.add(sewerageDemandInfo.getInterest()).setScale(2, BigDecimal.ROUND_HALF_UP));
		billBalance = sewerageDemandInfo.getBillAmount().subtract(sewerageDemandInfo.getAdvance());
		
		if(billBalance.compareTo(BigDecimal.ZERO)>0)
			penalty = calculatePenaltyAfterDueDate(sewerageDemandInfo.getBillAmount());
		sewerageReportParams.put("stmsPaymentAfterDueDate",
				penalty.add(sewerageDemandInfo.getPenalty()).add(sewerageDemandInfo.getInterest())
						.add(sewerageDemandInfo.getStmsArrearPenalty()).add(sewerageDemandInfo.getStmsArrearInterest())
						.add(sewerageDemandInfo.getArrearAmount()).add(sewerageDemandInfo.getBillAmount())
						.subtract(sewerageDemandInfo.getAdvance()).setScale(0, BigDecimal.ROUND_HALF_EVEN));

		sewerageReportParams.put("stmsNetAmount",
				sewerageDemandInfo.getTotalAmount().subtract(sewerageDemandInfo.getDemandcollected())
						.subtract(sewerageDemandInfo.getAdvance()).setScale(2, BigDecimal.ROUND_HALF_UP));
		sewerageReportParams.put("sewerageOldConsumerNo", sewerageDemandInfo.getSewerageOldConsumerNumber());
		sewerageReportParams.put("sewerageConsumerNo", sewerageDemandInfo.getSewerageConsumerNumber());
		sewerageReportParams.put("sewerageUsageType", sewerageDemandInfo.getSewerageUsageType());
		sewerageReportParams.put("stmsArrearPenalty",
				sewerageDemandInfo.getStmsArrearPenalty().setScale(2, BigDecimal.ROUND_HALF_UP));
		sewerageReportParams.put("stmsArrearInterest",
				sewerageDemandInfo.getStmsArrearInterest().setScale(2, BigDecimal.ROUND_HALF_UP));
		return sewerageReportParams;
	}

	// TODO Auto-generated method stub
	@SuppressWarnings({ "unused", "unchecked" })
	@Override
	@Transactional(timeout=1800)
	public void bulkWaterBillGeneration() {

		List<WaterChargeBatchJobDetails> jobDetails = waterChargeBatchJobDetailsService
				.findActiveJobDetailsByJobType(WaterTaxConstants.BILL);
		ProcedureCall procedureCall = null;
		ProcedureOutputs procedureOutputs = null;
		if (jobDetails != null) {

			for (WaterChargeBatchJobDetails jd : jobDetails) {

				if (LOGGER.isDebugEnabled())
					LOGGER.debug("Starting water tax bulk bill generation for " + jd.getInstallment().getDescription()
							+ " " + jd.getBatchName() + " " + jd.getBoundaryType());

				procedureCall = persistenceService.getSession().createStoredProcedureCall("wtms_bill_genaration");
				procedureCall.registerParameter("connection_type", long.class, ParameterMode.IN);
				procedureCall.getParameterRegistration("connection_type").bindValue(jd.getConnectionType().getId());
				procedureCall.registerParameter("batch_name", String.class, ParameterMode.IN);
				procedureCall.getParameterRegistration("batch_name").bindValue(jd.getBatchName());
				procedureCall.registerParameter("boundary_type", String.class, ParameterMode.IN);
				procedureCall.getParameterRegistration("boundary_type").bindValue(jd.getBoundaryType());
				procedureCall.registerParameter("curr_installment_description", String.class, ParameterMode.IN);
				procedureCall.getParameterRegistration("curr_installment_description")
						.bindValue(jd.getInstallment().getDescription());
				procedureCall.registerParameter("batch_id", long.class, ParameterMode.IN);
				procedureCall.getParameterRegistration("batch_id").bindValue(jd.getId());
				procedureCall.registerParameter("bill_type", String.class, ParameterMode.IN);
				procedureCall.getParameterRegistration("bill_type").bindValue(jd.getBillType());
				if (procedureCall != null) {
					try {
						procedureOutputs = procedureCall.getOutputs();
					} catch (Exception e) {
						throw new ApplicationRuntimeException(e.getMessage());
					}
				}

				jd.setActive(false);

				waterChargeBatchJobDetailsService.update(jd);

				if (LOGGER.isDebugEnabled())
					LOGGER.debug("Completed water tax bulk bill generation for " + jd.getInstallment().getDescription()
							+ " " + jd.getBatchName() + " " + jd.getBoundaryType());
			}
		}

	}

	private WaterDemandConnection getPreviousDemand(final WaterConnectionDetails waterConnectionDetails,
			Installment installment) {
/*
	    WaterDemandConnection waterdemandConnection = new WaterDemandConnection();
		final List<WaterDemandConnection> waterDemandConnectionList = waterDemandConnectionService
				.findByWaterConnectionDetails(waterConnectionDetails);
		for (final WaterDemandConnection waterDemandConnection : waterDemandConnectionList)
			if (waterDemandConnection.getDemand().getEgInstallmentMaster().equals(installment)) {
				waterdemandConnection = waterDemandConnection;
				break;
			}
*/ 
	        WaterDemandConnection waterdemandConnection = new WaterDemandConnection();
	        final List<WaterDemandConnection> waterDemandConnectionList = waterDemandConnectionService
                              .findLatestWaterDemandForInstallment(waterConnectionDetails, installment);
	        if (waterDemandConnectionList!= null &&  !waterDemandConnectionList.isEmpty())
	            waterdemandConnection = waterDemandConnectionList.get(0);
		return waterdemandConnection;
	}

	private SewerageDemandConnection getPreviousDemandSewerage(
			final SewerageApplicationDetails sewerageConnectionDetails, Installment installment) {
/*		SewerageDemandConnection sewerageDemandConnection = new SewerageDemandConnection();
		final List<SewerageDemandConnection> sewerageDemandConnectionList = sewerageDemandConnectionService
				.findByApplicationDetails(sewerageConnectionDetails);
		for (final SewerageDemandConnection sewerageDemandConnection1 : sewerageDemandConnectionList)
			if (sewerageDemandConnection1.getDemand().getEgInstallmentMaster() != null
					&& sewerageDemandConnection1.getDemand().getEgInstallmentMaster().getId() == installment.getId()) {
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
	public void buildBulkWaterDueSMS() {
		List<Object> list = new ArrayList<>();
		if(this.environmentSettings.getProperty("water.bill.oneday.due.sms.enabled",Boolean.class))
		list.addAll(getDueBillListNeedToPayInDays(1));
		
		if(this.environmentSettings.getProperty("water.bill.fivedays.due.sms.enabled",Boolean.class))
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
			String onlineWaterPayUrl = WaterTaxConstants.ONLINE_URL + city.getName().replaceAll("\\s", "")
					+ WaterTaxConstants.ONLINE_URL_WT;
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
					waterConnectionSmsAndEmailService.buildSmsForDueRemainder(formatter.format(billDueDate),
							billAmount.longValue(), consumerNumber, mobileNumber, ownerName, onlineWaterPayUrl);
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
						+ "connection.totalAmount as \"billTotalAmount\" from (select conn.consumercode as consumerNo,u.name as ownerName,u.mobilenumber as mobileNumber,bill.last_date as billLastDueDate, "
						+ "bill.total_amount as totalAmount from egwtr_connection conn,egwtr_connectiondetails conndetails,egwtr_connection_owner_info oinfo, eg_user u,eg_bill bill "
						+ "where bill.is_cancelled=:isCancelled and bill.id_bill_type !=(select id from eg_bill_type where code = 'AUTO') and bill.service_code=:serviceCode and bill.consumer_id=conn.consumerCode and conn.id=conndetails.connection and conn.id=oinfo.connection and oinfo.owner=u.id "
						+ "and conndetails.connectionstatus = 'ACTIVE' and bill.last_date between to_date(:fromDate,'dd/MM/yyyy') and to_date(:toDate,'dd/MM/yyyy')) connection "
						+ ", (select conn.consumercode as consumerNo from egwtr_connection conn,egwtr_connectiondetails conndetails,egwtr_demand_connection dc, eg_demand d, eg_demand_details dd where "
						+ "conn.id=conndetails.connection and dc.connectiondetails=conndetails.connection and d.id = dc.demand and d.is_history='N' "
						+ "and dd.id_demand = d.id group by conn.consumercode having sum(dd.amount - dd.amt_collected) > 0 ) totaldue where totaldue.consumerNo=connection.consumerNo ");
		final SQLQuery query = (SQLQuery) persistenceService.getSession().createSQLQuery(queryString.toString())
				.setString("isCancelled", DEMANDISHISTORY).setString("serviceCode", COLLECTION_STRING_SERVICE_CODE)
				.setString("fromDate", fromDate).setString("toDate", toDate);
		LOGGER.debug("query to get Bill Objects to send bill due sms =" + query.toString());
		final List<Object> dueBillList = query.list();

		return dueBillList;
	}
}