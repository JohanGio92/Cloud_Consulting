// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

//System.debug('<<<<Prueba10>>>>');
//for (User user: ResourceAllocation.getResources('a00Dp000001lEeHIAU')) {
//    System.debug(user.Name + ' - ' + user.Profile.Name);
//}
//
//System.debug('==============================================================');
//
//System.debug('<<<<Prueba Bernardo Artur>>>>');
//for (User user: ResourceAllocation.getResources('a00Dp000001lIIXIA2')) {
//    System.debug(user.Name + ' - ' + user.Profile.Name);
//}
//
//System.debug('==============================================================');
//
//System.debug('<<<<PruebaPrueba2>>>>');
//for (User user: ResourceAllocation.getResources('a00Dp000001lD0MIAU')) {
//    System.debug(user.Name + ' - ' + user.Profile.Name);
//}
//

Contact contact = (Contact)JSON.deserializeStrict( '{"FirstName":"Arturo","LastName":"Petrich"}', Contact.class);
System.debug(contact);

List<Contact> contacts = (List<Contact>)JSON.deserializeStrict( '[{"FirstName":"Arturo","LastName":"Petrich"},{"FirstName":"Julian","LastName":"Aquino"},{"FirstName":"Belen","LastName":"Banegas"},{"FirstName":"Johan","LastName":"Revilla"}]', List<Contact>.class);
System.debug(contacts);

ResourceProject__c resourceProject = new ResourceProject__c();
resourceProject.Rol
