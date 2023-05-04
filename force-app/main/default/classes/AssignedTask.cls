public with sharing class AssignedTask {

    public List<ResourceProject__c> getResourceProjects() {
        //return [
        //        SELECT Id, Project__r.Name, (
        //                SELECT Id, Name, Status__c, EstimatedHours__c, ReportedHours__c
        //                FROM Assigment_Tasks__r
        //        )
        //        FROM ResourceProject__c
        //        WHERE User__c =: UserInfo.getUserId()
        //            AND Id IN ( SELECT ResourceProject__c FROM Assigment_Task__c )
        //];
        return [
                SELECT Id, Project__r.Name, (
                        SELECT Id, Name, Status__c, EstimatedHours__c, ReportedHours__c
                        FROM Assigment_Tasks__r
                )
                FROM ResourceProject__c
                WHERE Id IN ( SELECT ResourceProject__c FROM Assigment_Task__c )
        ];
    }

    public void updateReportedHours(String jsonAssigmentTask) {
        Assigment_Task__c assigmentTask = (Assigment_Task__c) JSON.deserializeStrict(jsonAssigmentTask, Assigment_Task__c.class);
        Database.update(assigmentTask);
    }

    public void updateTaskToProgress(String jsonAssigmentTask) {
        this.updateReportedHours(jsonAssigmentTask);
    }
}