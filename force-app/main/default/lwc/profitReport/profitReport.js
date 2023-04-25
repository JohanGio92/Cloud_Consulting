import { LightningElement, api, wire, track } from 'lwc';
import getProject from "@salesforce/apex/ProfitReport.getProject";

export default class ProfitReport extends LightningElement {
	
	@api recordId;
	@track percentage;

	@wire(getProject, { projectId: '$recordId' })
	_getProject({data, error}) {
		if (data) {
			this.percentage = data.Win_or_Lose__c;
			this.error = undefined;
			console.log('data: ' + data);
		} else {
			this.percentage = undefined;
			this.error = error;
			console.log('error: ' + error);
		}
	}

	get isProfit() {
		return this.percentage >= 0;
	}


	//constructor() {
	//	super();
	//	this.percentage = this.project.Win_or_Lose__c;
	//}

    //handlePercentageChange(event) {
    //    this.percentage = event.target.value;
    //}
}
