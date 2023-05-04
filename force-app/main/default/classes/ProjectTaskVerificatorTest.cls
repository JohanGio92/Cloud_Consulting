@IsTest
private class ProjectTaskVerificatorTest {

    public static Id resourceProjectId;
    public static final Integer LOOPS = 3;

    @TestSetup
    static void setup() {

    }

    @IsTest
    static void testUpdateProjectToCompleteFail() {

        Project__c project = new Project__c(
                Name = 'Project',
                Project_Start__c = Date.today(),
                Project_End__c = Date.today(),
                State__c = 'In Progress'
        );

        insert project;

        ResourceProject__c resourceProject = new ResourceProject__c(
                Name = 'ResourceProject',
                Project__c = project.Id,
                Start_Date__c = Date.today(),
                End_Date__c = Date.today(),
                User__c = UserInfo.getUserId(),
                Rol__c = 'Developer',
                Assigned_Hours__c = 12
        );
        insert resourceProject;

        resourceProjectId = resourceProject.Id;

        List<Assigment_Task__c> assigmentTasks = new List<Assigment_Task__c>();

        for (Integer index = 0; index <= LOOPS; index++) {
            Assigment_Task__c assigmentTask = new Assigment_Task__c(
                    Name = 'Task' + index,
                    Description__c = 'Description',
                    EstimatedHours__c = 100,
                    ReportedHours__c = 20,
                    ResourceProject__c = resourceProjectId,
                    Status__c = 'In Progress'
            );
            assigmentTasks.add(assigmentTask);
        }

        insert assigmentTasks;

        project.State__c = 'Completed';
        Database.SaveResult saveResult = Database.update(project, false);

        //Assert.isTrue(!saveResult.success);
        Assert.isFalse(saveResult.success);
        Assert.isTrue(saveResult.getErrors().size() > 0);
    }

    @IsTest
    static void testUpdateProjectToCompleteSuccess() {
        Project__c project = new Project__c(
                Name = 'Project',
                Project_Start__c = Date.today(),
                Project_End__c = Date.today(),
                State__c = 'In Progress'
        );

        insert project;

        ResourceProject__c resourceProject = new ResourceProject__c(
                Name = 'ResourceProject',
                Project__c = project.Id,
                Start_Date__c = Date.today(),
                End_Date__c = Date.today(),
                User__c = UserInfo.getUserId(),
                Rol__c = 'Developer',
                Assigned_Hours__c = 12
        );
        insert resourceProject;

        resourceProjectId = resourceProject.Id;

        List<Assigment_Task__c> assigmentTasks = new List<Assigment_Task__c>();

        for (Integer index = 0; index <= LOOPS; index++) {
            Assigment_Task__c assigmentTask = new Assigment_Task__c(
                    Name = 'Task' + index,
                    Description__c = 'Description',
                    EstimatedHours__c = 100,
                    ReportedHours__c = 20,
                    ResourceProject__c = resourceProjectId,
                    Status__c = 'Completed'
            );
            assigmentTasks.add(assigmentTask);
        }

        insert assigmentTasks;

        project.State__c = 'Completed';
        Database.SaveResult saveResult = Database.update(project, false);

        Assert.isTrue(saveResult.success);
        Assert.areEqual(0, saveResult.getErrors().size());
    }
}