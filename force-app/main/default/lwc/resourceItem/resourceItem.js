import {LightningElement, api, track} from 'lwc';

export default class ResourceItem extends LightningElement {

	@api resource;
	@api projectItem;
	@api resourceRol;
	@api projectRol;

	disabledStartDate;
	disabledEndDate;
	valueCheckbox;
	@track valueStartDate;
	valueEndDate;
	
	@api resourceProject;

	constructor() {
		super();
		this.disabledStartDate = true;
		this.disabledEndDate = true;
		this.valueStartDate = '';
		this.valueEndDate = '';
		this.valueCheckbox = false;
		this.resourceProject = {};
	}

	get isEqualRol() {
		return this.resourceRol == this.projectRol;
	}

	handleChangeCheckbox(event) {
		this.valueCheckbox = event.target.checked;
		console.log(event.target.checked);
		this.disabledStartDate = !this.disabledStartDate;
		this.disabledEndDate = !this.disabledEndDate;
	}

	isValidStartDate(_valueStartDate) {
		const projectStartDate = this.projectItem.Project__r.Project_Start__c;
		const projectEndDate = this.projectItem.Project__r.Project_End__c;
		return projectStartDate <= _valueStartDate && _valueStartDate <= projectEndDate;
	}

	handleChangeStartDate(event) {

		const _valueStartDate = event.target.value;
		this.valueStartDate = _valueStartDate;

		//if (this.isValidStartDate(_valueStartDate)) {
		//  console.log('pase por el if ' + this.isValidStartDate(_valueStartDate));
		//  this.valueStartDate = _valueStartDate;
		//  console.log(this.valueStartDate);
		//} else {
		//  console.log('pase por el else ' + this.isValidStartDate(_valueStartDate));
		//  this.valueStartDate = this.projectItem.Project__r.Project_Start__c;
		//  console.log('_valueStartDate: ' + _valueStartDate);
		//  console.log('this.valueStartDate:' + this.valueStartDate);
		//}
	}

	handleChangeEndDate(event) {
		const _valueEndDate = event.target.value;
		event.target.setCustomValidity("");

		if (this.valueStartDate <= _valueEndDate) {
			this.valueEndDate = _valueEndDate;
		} else {
			event.target.setCustomValidity("the end date must be greater than equal to start date");
			event.target.reportValidity();
		}
	}
	
	@api
	validationItem() {
		if (this.valueCheckbox) {
			if (this.valueStartDate && this.valueEndDate) {
				this.resourceProject.name = this.resource.Name;
				this.resourceProject.startDate = this.valueStartDate;
				this.resourceProject.endDate = this.valueEndDate;
				this.resourceProject.rate = this.resource.Rate_p_hour__c;
				this.resourceProject.rol = this.resource.Rol__c;
				this.resourceProject.projectId = this.projectItem.Project__c;
				this.resourceProject.userId = this.resource.Id;
				//this.resourceProject.assignedHours = '';
			}
		}
	}

}
