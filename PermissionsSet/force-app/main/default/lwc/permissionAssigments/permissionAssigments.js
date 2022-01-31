import { LightningElement, api, track, wire } from 'lwc';
import getPermissionsByUsers from '@salesforce/apex/PermissionAssigments_ctr.getPermissionsByUsers';

export default class PermissionAssigments extends LightningElement {
    
    @track permissionsSetOptions;

    @wire(getPermissionsByUsers)
    getPermissionsInfo(result){

        if (result.data) {
            this.permissionsSetOptions = result.data;
            console.log(this.permissionsSetOptions)
        }
    };
}