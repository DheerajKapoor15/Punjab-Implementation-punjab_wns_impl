package org.egov.punjab.stms.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.egov.infra.utils.DateUtils;
import org.egov.stms.service.SewerageApplicationsExecutionDateUpdateService;
import org.egov.stms.transactions.entity.SewerageApplicationDetails;
import org.egov.stms.transactions.service.SewerageApplicationDetailsService;
import org.egov.stms.utils.SewerageTaxUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("sewerageApplicationsExecutionDateUpdateService")
public class SewerageApplicationsExecutionDateUpdateServiceImpl implements SewerageApplicationsExecutionDateUpdateService {

    @Autowired
    private SewerageApplicationDetailsService seweargeConnectionDetailsService;

    @Autowired
    private SewerageTaxUtils seweargeTaxUtils;

    @Override
    @Transactional
    public void bulkSewerageApplicationsExecutionDateUpdate() {

        List<SewerageApplicationDetails> sewerageConnectionList = null;
        if (seweargeConnectionDetailsService != null)
            sewerageConnectionList = seweargeConnectionDetailsService.getSewerageApplicationsToUpdateExecutionDate();
        List<SewerageApplicationDetails> filteredConnections = updateExecutionDate(sewerageConnectionList);
        if (filteredConnections != null && !filteredConnections.isEmpty())
            seweargeConnectionDetailsService.updateExecutionDate(filteredConnections);
    }

    private List<SewerageApplicationDetails> updateExecutionDate(List<SewerageApplicationDetails> sewerageConnectionList) {
        int days = seweargeTaxUtils.getAppconfigValueToUpdateExecutionDate();
        List<SewerageApplicationDetails> list = new ArrayList<>();
        if (sewerageConnectionList != null && !sewerageConnectionList.isEmpty())
            for (SewerageApplicationDetails details : sewerageConnectionList) {
				int betweenDays = DateUtils.daysBetween(details.getState().getLastModifiedDate(), new Date()) + 1;
                if (days < betweenDays) {
                    details.getConnection().setExecutionDate(DateUtils.addDays(details.getLastModifiedDate(), days));
                    list.add(details);
                }
            }
        return list;
    }
}
