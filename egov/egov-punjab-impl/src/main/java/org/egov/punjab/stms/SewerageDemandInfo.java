/*
 *    eGov  SmartCity eGovernance suite aims to improve the internal efficiency,transparency,
 *    accountability and the service delivery of the government  organizations.
 *
 *     Copyright (C) 2017  eGovernments Foundation
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
 *
 *         1) All versions of this program, verbatim or modified must carry this
 *            Legal Notice.
 *            Further, all user interfaces, including but not limited to citizen facing interfaces,
 *            Urban Local Bodies interfaces, dashboards, mobile applications, of the program and any
 *            derived works should carry eGovernments Foundation logo on the top right corner.
 *
 *            For the logo, please refer http://egovernments.org/html/logo/egov_logo.png.
 *            For any further queries on attribution, including queries on brand guidelines,
 *            please contact contact@egovernments.org
 *
 *         2) Any misrepresentation of the origin of the material is prohibited. It
 *            is required that all modified versions of this material be marked in
 *            reasonable ways as different from the original version.
 *
 *         3) This license does not grant any rights to any user of the program
 *            with regards to rights under trademark law for use of the trade names
 *            or trademarks of eGovernments Foundation.
 *
 *   In case of any queries, you can reach eGovernments Foundation at contact@egovernments.org.
 *
 */

package org.egov.punjab.stms;

import java.math.BigDecimal;

public class SewerageDemandInfo {
    BigDecimal arrearAmount = BigDecimal.ZERO;
    BigDecimal totalAmount = BigDecimal.ZERO;
    BigDecimal penalty = BigDecimal.ZERO;
    BigDecimal billAmount = BigDecimal.ZERO;
    BigDecimal demandcollected = BigDecimal.ZERO;
    BigDecimal interest = BigDecimal.ZERO;
    BigDecimal arrearPenalty = BigDecimal.ZERO;
    BigDecimal arrearInterest = BigDecimal.ZERO;
    BigDecimal stmsArrearPenalty = BigDecimal.ZERO;
    BigDecimal stmsArrearInterest = BigDecimal.ZERO;
    BigDecimal advance;
   
	String sewerageOldConsumerNumber;
    String sewerageConsumerNumber;
    String sewerageUsageType;

    public String getSewerageUsageType() {
		return sewerageUsageType;
	}

	public void setSewerageUsageType(String sewerageUsageType) {
		this.sewerageUsageType = sewerageUsageType;
	}

	public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public BigDecimal getArrearPenalty() {
        return arrearPenalty;
    }

    public void setArrearPenalty(BigDecimal arrearPenalty) {
        this.arrearPenalty = arrearPenalty;
    }

    public BigDecimal getArrearInterest() {
        return arrearInterest;
    }

    public void setArrearInterest(BigDecimal arrearInterest) {
        this.arrearInterest = arrearInterest;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public BigDecimal getArrearAmount() {
        return arrearAmount;
    }

    public void setArrearAmount(BigDecimal arrearAmount) {
        this.arrearAmount = arrearAmount;
    }

    public BigDecimal getStmsArrearPenalty() {
        return stmsArrearPenalty;
    }

    public void setStmsArrearPenalty(BigDecimal stmsArrearPenalty) {
        this.stmsArrearPenalty = stmsArrearPenalty;
    }

    public BigDecimal getStmsArrearInterest() {
        return stmsArrearInterest;
    }

    public void setStmsArrearInterest(BigDecimal stmsArrearInterest) {
        this.stmsArrearInterest = stmsArrearInterest;
    }

    public BigDecimal getPenalty() {
        return penalty;
    }

    public void setPenalty(BigDecimal penalty) {
        this.penalty = penalty;
    }

    public BigDecimal getBillAmount() {
        return billAmount;
    }

    public void setBillAmount(BigDecimal billAmount) {
        this.billAmount = billAmount;
    }

    public BigDecimal getDemandcollected() {
        return demandcollected;
    }

    public void setDemandcollected(BigDecimal demandcollected) {
        this.demandcollected = demandcollected;
    }

    public BigDecimal getInterest() {
        return interest;
    }

    public void setInterest(BigDecimal interest) {
        this.interest = interest;
    }

    public String getSewerageOldConsumerNumber() {
        return sewerageOldConsumerNumber;
    }

    public void setSewerageOldConsumerNumber(String sewerageOldConsumerNumber) {
        this.sewerageOldConsumerNumber = sewerageOldConsumerNumber;
    }

    public String getSewerageConsumerNumber() {
        return sewerageConsumerNumber;
    }

    public void setSewerageConsumerNumber(String sewerageConsumerNumber) {
        this.sewerageConsumerNumber = sewerageConsumerNumber;
    }
    
    public BigDecimal getAdvance() {
        return advance;
    }

    public void setAdvance(BigDecimal advance) {
        this.advance = advance;
    }

}
