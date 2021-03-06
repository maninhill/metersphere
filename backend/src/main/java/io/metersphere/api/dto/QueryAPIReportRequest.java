package io.metersphere.api.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class QueryAPIReportRequest {

    private String id;
    private String projectId;
    private String name;
    private String workspaceId;
    private boolean recent = false;
    
}
