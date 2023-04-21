import { LightningElement, wire } from 'lwc';
import getResources from '@salesforce/apex/ControllerResourceAllocation.getResources';
import getProjectItems from '@salesforce/apex/ControllerResourceAllocation.getProjectItems'

export default class ResouceAllocation extends LightningElement {

	projectId;
	resources
	projectItems

	@wire(getResources, { projectId: 'a00Dp000001lIIXIA2' })
	_getResources({data, error}) {
		if (data) {
			console.log('has data getResources: ' + data);
			this.resources = data;
			this.error = undefined;
		} else {
			console.log('has error getResources: ' + error);
			this.error = error;
			this.resources = undefined;
		}
	}
	
	@wire(getProjectItems, { projectId: 'a00Dp000001lIIXIA2' })
	_getProjectItems({data, error}) {
		if (data) {
			console.log('has data getProjectItems: ' + data);
			this.projectItems = data;
			this.error = undefined;
		} else {
			console.log('has data getProjectItems: ' + data);
			this.error = error;
			this.projectItems = undefined;
		}
	}
}
