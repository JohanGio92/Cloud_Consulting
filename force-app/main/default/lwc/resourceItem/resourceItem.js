import { LightningElement, api } from 'lwc';

export default class ResourceItem extends LightningElement {
  
  @api resource;
  @api resourceRol;
  @api projectRol;

  get isEqualRol() {
	console.log(`resourceRol = ${this.resourceRol}`);
	console.log(`projectRol = ${this.projectRol}`);
	console.log(this.resourceRol === this.projectRol);
	console.log("==============================");
	return this.resourceRoll === this.projectRoll;
  }

}
