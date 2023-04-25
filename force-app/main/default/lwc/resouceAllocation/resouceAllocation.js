import { LightningElement, wire, api } from 'lwc';
import getResources from '@salesforce/apex/ControllerResourceAllocation.getResources';
import getProjectItems from '@salesforce/apex/ControllerResourceAllocation.getProjectItems'
import createResourceProjects from '@salesforce/apex/ControllerResourceAllocation.createResourceProjects'
import { refreshApex } from '@salesforce/apex'

export default class ResouceAllocation extends LightningElement {
	
	@api
	recordId;
	resources;
	projectItems;

	@wire(getResources, { projectId: '$recordId' })
	_getResources({data, error}) {
		if (data) {
			this.resources = data;
			this.error = undefined;
		} else {
			this.error = error;
			this.resources = undefined;
		}
	}
	
	@wire(getProjectItems, { projectId: '$recordId' })
	_getProjectItems({data, error}) {
		if (data) {
			this.projectItems = data;
			this.error = undefined;
		} else {
			this.error = error;
			this.projectItems = undefined;
		}
	}

	handleClick(event) {
		event.preventDefault();
		const resourceItems = this.template.querySelectorAll('c-resource-item')
		const resourceProject = [];
		
		resourceItems.forEach( resourceItem => {
			resourceItem.validationItem();
			if (Object.keys(resourceItem.resourceProject).length != 0) {
				resourceProject.push(resourceItem.resourceProject);
			}
		});

		const _jsonResourceProjects = JSON.stringify(resourceProject);
		console.log(_jsonResourceProjects);

		createResourceProjects({jsonResourceProjects: _jsonResourceProjects})
		.then( () => { 
			refreshApex(this.resources);
			refreshApex(this.projectItems);
		})
		.catch((error) => console.log(error));
	}
}
