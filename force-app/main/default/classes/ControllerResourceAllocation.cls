public with sharing class ControllerResourceAllocation {

    @AuraEnabled(Cacheable=true)
    public static List<User> getResources(Id projectId) {
        ResourceAllocation resourceAllocation = new ResourceAllocation();
        return resourceAllocation.getResources(projectId);
    }

    @AuraEnabled(Cacheable=true)
    public static List<ProjectItem__c> getProjectItems(Id projectId) {
        ResourceAllocation resourceAllocation = new ResourceAllocation();
        return resourceAllocation.getProjectItems(projectId);
    }
}