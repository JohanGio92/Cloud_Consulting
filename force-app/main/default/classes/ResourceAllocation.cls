public with sharing class ResourceAllocation {

    public List<User> getResources(Id projectId) {

        Project__c project = [
          SELECT Id, Project_Start__c, Project_End__c
          FROM Project__c
          WHERE Id =: projectId
        ];

        List<User> users = [
                SELECT Name, Profile.Name, UserRole.Name, Rate_p_hour__c
                FROM User
                WHERE Profile.Name IN ('Developer', 'Architect', 'Consultant')
                AND Id IN (
                        SELECT User__c FROM ResourceProject__c
                        WHERE Start_Date__c != NULL AND End_Date__c != NULL
                        AND ( NOT ( Start_Date__c <=: Project.Project_Start__c AND End_Date__c >=: Project.Project_Start__c))
                        AND ( NOT ( Start_Date__c <=: Project.Project_End__c AND End_Date__c >=: Project.Project_End__c))
                )
        ];

        List<User> complementUsers = [
                SELECT Name, Profile.Name, UserRole.Name, Rate_p_hour__c
                FROM User
                WHERE Profile.Name IN ('Developer', 'Architect', 'Consultant')
                AND Id NOT IN (
                        SELECT User__c FROM ResourceProject__c
                )
        ];

        users.addAll(complementUsers);

        return users;
    }

    public List<ProjectItem__c> getProjectItems(Id projectId) {
        return [
            SELECT rol__c, Quantity__c
            FROM ProjectItem__c
            WHERE project__c =: projectId
        ];
    }
}