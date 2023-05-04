@IsTest
private class AssignedTaskTest {

    @TestSetup
   static void setup() {

    }

    @IsTest
    static void testGetResourceProjects() {

    }

    @IsTest
    static void testUpdateReportedHours() {

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

        Assigment_Task__c assigmentTask = new Assigment_Task__c(
                Name = 'Task1',
                Description__c = 'Description',
                EstimatedHours__c = 100,
                ReportedHours__c = 20,
                ResourceProject__c = resourceProject.Id
        );
        insert assigmentTask;

        assigmentTask.ReportedHours__c = 40;
        String jsonAssigmentTask = JSON.serialize(assigmentTask);
        AssignedTask assignedTask = new AssignedTask();
        assignedTask.updateReportedHours(jsonAssigmentTask);

        Assigment_Task__c assigmentTaskExpected = [
                SELECT Name, Description__c, EstimatedHours__c, ReportedHours__c
                FROM Assigment_Task__c
                WHERE Id =: assigmentTask.Id
        ];

        Assert.areEqual(assigmentTaskExpected.Name, 'Task1');
        Assert.areEqual(assigmentTaskExpected.Description__c, 'Description');
        Assert.areEqual(assigmentTaskExpected.EstimatedHours__c, 100);
        Assert.areEqual(assigmentTaskExpected.ReportedHours__c, 40);
    }
}