package org.egov.punjab.stms.service;

import static org.egov.stms.utils.constants.SewerageTaxConstants.MODULETYPE;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.egov.eis.entity.Assignment;
import org.egov.eis.service.AssignmentService;
import org.egov.eis.service.DesignationService;
import org.egov.infra.admin.master.entity.User;
import org.egov.infra.admin.master.service.DepartmentService;
import org.egov.infra.security.utils.SecurityUtils;
import org.egov.infra.utils.DateUtils;
import org.egov.stms.service.SewerageConnAppForwardService;
import org.egov.stms.transactions.entity.SewerageApplicationDetails;
import org.egov.stms.transactions.service.SewerageApplicationDetailsService;
import org.egov.stms.utils.SewerageTaxUtils;
import org.egov.stms.utils.constants.SewerageTaxConstants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("sewerageConnAppForwardService")
public class SewerageConnAppForwardServiceImpl implements SewerageConnAppForwardService {

    @Autowired
    private SewerageApplicationDetailsService seweargeConnectionDetailsService;

    @Autowired
    private AssignmentService assignmentService;

    @Autowired
    private DepartmentService departmentService;

    @Autowired
    private DesignationService designationService;

    @Autowired
    private SewerageTaxUtils sewerageTaxUtils;

    @Autowired
    private SecurityUtils securityUtils;

    @Override
    @Transactional
    public void bulkSewerageApplicationsForward() {

        List<SewerageApplicationDetails> sewerageConnectionList = null;
        if (seweargeConnectionDetailsService != null)
            sewerageConnectionList = seweargeConnectionDetailsService
                    .getSeweargeApplicationsToForwardToSdn(sewerageTaxUtils.getSewerageTaxApproveDepartmentName(),
                            SewerageTaxConstants.DESIG_NAME_JUNIOR_ENGINEER);
        List<SewerageApplicationDetails> filterConnectionList = null;
        filterConnectionList = filterApplicationsBySlaDays(sewerageConnectionList);
        long depId = departmentService.getDepartmentByName(sewerageTaxUtils.getSewerageTaxApproveDepartmentName()).getId();
        long desId = designationService.getDesignationByName(sewerageTaxUtils.getSewerageTaxApproveDesignationName()).getId();
        List<Assignment> assignment = assignmentService.getAllPositionsByDepartmentAndDesignationForGivenRange(depId, desId,
                new Date());
        if (filterConnectionList != null && !filterConnectionList.isEmpty())
            for (int i = 0; i < filterConnectionList.size(); i++) {
                SewerageApplicationDetails sewerageDetails = filterConnectionList.get(i);
                final User user = securityUtils.getCurrentUser();
                
                sewerageDetails.setStatus(sewerageTaxUtils.getStatusByCodeAndModuleType(
                        SewerageTaxConstants.APPLICATION_STATUS_VERIFIED, MODULETYPE));
                
                sewerageDetails.transition().progressWithStateCopy()
                        .withSenderName(user.getUsername() + "::" + user.getName())
                        .withComments("This application is auto escalated by system")
                        .withStateValue("Verified").withDateInfo(new Date()).withOwner(assignment.get(0).getPosition())
                        .withNextAction("Approval pending")
                        .withNatureOfTask(SewerageTaxConstants.NEW_APPLICATION_NATURE_OF_TASK);
            }
    }

    private List<SewerageApplicationDetails> filterApplicationsBySlaDays(
            List<SewerageApplicationDetails> sewerageConnectionList) {
        List<SewerageApplicationDetails> list = new ArrayList<>();
        int days = sewerageTaxUtils.getAppconfigValueForApplicationsHasToForward();
        for (SewerageApplicationDetails details : sewerageConnectionList) {
			int betweenDays = DateUtils.daysBetween(details.getState().getLastModifiedDate(), new Date()) + 1;
            if (days < betweenDays)
                list.add(details);
        }
        return list;
    }
}
