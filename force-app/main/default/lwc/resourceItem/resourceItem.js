import { LightningElement, api } from 'lwc';

export default class ResourceItem extends LightningElement {
  
  @api resource;
  @api resourceRol;
  @api projectRol;

  get isEqualRol() {
	return this.resourceRol == this.projectRol;
  }

}
