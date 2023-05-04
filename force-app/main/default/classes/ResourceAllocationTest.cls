@isTest
public class ResourceAllocationTest {
    private static Project__c projectTest;
    
    @TestSetup
    public static void setupInit(){
        //SELECT Id, Name, Profile.Name, UserRole.Name, Rate_p_hour__c
        //     FROM User
        //     WHERE Profile.Name IN ('Developer', 'Architect', 'Consultant')
        
        List<User> users= new List<User>();
        
        
        for(Integer i=1; i <=9; i++){
            User userTest = new User();
            userTest.FirstName = 'UserFirst ' + i; 
            userTest.LastName = 'User ' + i;       
            if(i<= 3){
                userTest.UserRole.Name = 'Architect';
                userTest.Rate_p_hour__c = 30;
                userTest.Profile.Name = 'Architect';
            } else if( 4 <= i && i <=6){            
                userTest.UserRole.Name = 'Developer';
                userTest.Rate_p_hour__c = 20;
                userTest.Profile.Name = 'Developer';
            } else {
                userTest.UserRole.Name = 'Consultant';
                userTest.Rate_p_hour__c = 15;
                userTest.Profile.Name = 'Consultant';
            } 
            users.add(userTest);
        }
        
        insert users;
        // Database.insert(users);
        
        
        projectTest = new Project__c();
        
        projectTest.Project_Start__c = Date.newInstance(2023, 4, 27);
        projectTest.Project_End__c = Date.newInstance(2023, 5, 7);
        projectTest.QuantityHourArchitect__c = 50;
        projectTest.QuantityHourDeveloper__c = 30;
        projectTest.QuantityHourConsult__c = 35;
        
        insert projectTest;
        
        
        List<ProjectItem__c> projectItems = new List<ProjectItem__c>();
        projectItems.add(new ProjectItem__c(Rol__c = 'Developer', Quantity__c = 150, Project__c = projectTest.Id));
        projectItems.add(new ProjectItem__c(Rol__c = 'Architect', Quantity__c = 100, Project__c = projectTest.Id));
        projectItems.add(new ProjectItem__c(Rol__c = 'Consultant', Quantity__c = 120, Project__c = projectTest.Id));
        
        insert projectItems;
        
        List<ResourceProject__c> resourceProjectsTest = new List<ResourceProject__c>();
        
        resourceProjectsTest.add(new ResourceProject__c(Rol__c='Developer', 
                                                        Project__c = projectTest.Id,
                                                        User__c = users[5].Id,
                                                        Assigned_Hours__c = 30,
                                                        Name ='Developer',
                                                        Start_Date__c = projectTest.Project_Start__c,
                                                        End_Date__c =  projectTest.Project_End__c));
         resourceProjectsTest.add(new ResourceProject__c(Rol__c='Architect',
                                                        Project__c = projectTest.Id,
                                                        User__c = users[1].Id,
                                                        Assigned_Hours__c = 40,
                                                        Name ='Architect',
                                                        Start_Date__c = projectTest.Project_Start__c,
                                                        End_Date__c =  projectTest.Project_End__c));
         resourceProjectsTest.add(new ResourceProject__c(Rol__c='Consultant',
                                                        Project__c = projectTest.Id,
                                                        User__c = users[8].Id,
                                                        Assigned_Hours__c = 20,
                                                        Name ='Consultant',
                                                        Start_Date__c = projectTest.Project_Start__c,
                                                        End_Date__c =  projectTest.Project_End__c));
        insert resourceProjectsTest;
        
               
        
    }
      
    
    @isTest static void testGetResources(){
        
        
         Test.startTest();
        ResourceAllocation.getResources(projectTest.Id);
        Test.stopTest();
    //  System.assertEquals( );
        
    }
    
    
    @isTest static void testGetProjectItems(){
         Test.startTest();
        ResourceAllocation.getProjectItems(projectTest.Id);
        Test.stopTest();
    }
    
    
    
}