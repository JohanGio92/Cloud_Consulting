public with sharing class ResourceAllocation {

    @AuraEnabled
    public static List<User> getResources(Id projectId) {

        Project__c project = [
          SELECT Id, Project_Start__c, Project_End__c
          FROM Project__c
          WHERE Id =: projectId
        ];

        List<User> users = [
                SELECT Id, Name, Profile.Name, UserRole.Name, Rate_p_hour__c
                FROM User
                WHERE Profile.Name IN ('Developer', 'Architect', 'Consultant')
                AND Id IN (
                        SELECT User__c FROM ResourceProject__c
                        WHERE Start_Date__c != NULL AND End_Date__c != NULL
                        AND (( Start_Date__c <: project.Project_Start__c AND End_Date__c <: project.Project_Start__c)
                        OR ( Start_Date__c >: project.Project_End__c AND End_Date__c >: project.Project_End__c))
                        AND Project__c =: projectId
                )
        ];

        List<User> complementUsers = [
                SELECT Id, Name, Profile.Name, UserRole.Name, Rate_p_hour__c
                FROM User
                WHERE Profile.Name IN ('Developer', 'Architect', 'Consultant')
                AND Id NOT IN (
                        SELECT User__c FROM ResourceProject__c
                )
        ];

        users.addAll(complementUsers);

        return users;
    }

    @AuraEnabled
    public static List<ProjectItem__c> getProjectItems(Id projectId) {
        return [
            SELECT Id, rol__c, Quantity__c, Project__c, Project__r.Project_Start__c, Project__r.Project_End__c
            FROM ProjectItem__c
            WHERE project__c =: projectId
        ];
    }

    //@AuraEnabled
    //public static void createResourceProject(String jsonResourceProjects) {
    //    List<Object> objetos = (List<Object>)JSON.deserializeStrict(jsonResourceProjects ,List<Object>.class);
    //    List<ResourceProject__c> recursosSelecciondos = new List<ResourceProject__c>();

    //    if(objetos.size() > 0){
    //        for(Object objeto : objetos){
    //            system.debug('Este es su objeto:'+ objeto);
    //            Map<String,Object> json = (Map<String,Object>)objeto;
    //            ResourceProject__c recurso = new ResourceProject__c();
    //            recurso.Name = (String) json.get('Name');
    //            recurso.Start_Date__c = (Date)json.get('Start_Date__c');
    //            recurso.End_Date__c = (Date)json.get('End_Date__c');
    //            recurso.Rol__c = (String) json.get('Rol__c');
    //            recurso.Project__c = (Id) json.get('Project__c') ;
    //            recurso.Assigned_Hours__c = (Integer) json.get('Assigned_Hours__c');
    //            recurso.User__c = (Id)json.get('User__c');
    //            recursosSelecciondos.add(recurso);
    //        }
    //        system.debug('Esto es lo que entrarará:' +  recursosSelecciondos);
    //        insert recursosSelecciondos;
    //    }
    //}

    @AuraEnabled
    public static void createResourceProject(String jsonResourceProjects) {
        List<ResourceProject__c> resourceprojects = (List<ResourceProject__c>) JSON.deserializeStrict(jsonResourceProjects, List<ResourceProject__c>.class);
        Database.insert(resourceprojects);
    }

}
