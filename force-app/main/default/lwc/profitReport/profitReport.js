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
		} else {
			this.percentage = undefined;
			this.error = error;
		}
	}

	get isProfit() {
		return this.percentage >= 0;
	}

}
