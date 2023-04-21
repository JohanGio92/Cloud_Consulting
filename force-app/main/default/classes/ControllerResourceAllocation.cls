public with sharing class ControllerResourceAllocation {

    @AuraEnabled(Cacheable=true)
    public static List<User> getResources(Id projectId) {
        System.debug('getResources' + projectId);
        ResourceAllocation resourceAllocation = new ResourceAllocation();
        return resourceAllocation.getResources(projectId);
    }

    @AuraEnabled(Cacheable=true)
    public static List<ProjectItem__c> getProjectItems(Id projectId) {
        System.debug('getProjectItems' + projectId);
        ResourceAllocation resourceAllocation = new ResourceAllocation();
        return resourceAllocation.getProjectItems(projectId);
    }
}