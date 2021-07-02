import { LightningElement, wire } from 'lwc';
import callGetAccount from '@salesforce/apex/AccountRESTAPI.callGetAccount';
import ACCOUNT_NAME_FIELD from '@salesforce/schema/Account.Name';
import ESTATE_COUNT_FIELD from '@salesforce/schema/Account.External_Estate_Count__c';
import callGetShowroom from '@salesforce/apex/ShowroomRESTAPI.callGetShowroom';
import SHOWROOM_NAME_FIELD from '@salesforce/schema/Showroom__c.Name';
import callGetCar from '@salesforce/apex/CarRESTAPI.callGetCar';
import CAR_SERIAL_NUMBER_FIELD from '@salesforce/schema/Car__c.Serial_Number__c';
import CAR_UPDATE_MESSAGE from '@salesforce/messageChannel/CarUpdate__c';
import CAR_REFRESH_MESSAGE from '@salesforce/messageChannel/CarRefresh__c';
import { publish, subscribe, unsubscribe, MessageContext } from 'lightning/messageService';
const ACCOUNTS_ACTIONS = [
    { label: 'Show showrooms', name: 'show_showrooms' },
];
const ACCOUNTS_COLUMNS = [
	{ label: 'Account Name', fieldName: ACCOUNT_NAME_FIELD.fieldApiName, type: 'text' },
	{ label: 'Estate Count', fieldName: ESTATE_COUNT_FIELD.fieldApiName, type: 'number' },
	{
        type: 'action',
        typeAttributes: { rowActions: ACCOUNTS_ACTIONS },
    },
];
const SHOWROOMS_ACTIONS = [
    { label: 'Show cars', name: 'show_cars' },
];
const SHOWROOMS_COLUMNS = [
	{ label: 'Showroom Name', fieldName: SHOWROOM_NAME_FIELD.fieldApiName, type: 'text' },
	{
        type: 'action',
        typeAttributes: { rowActions: SHOWROOMS_ACTIONS },
    },
];
const CARS_ACTIONS = [
    { label: 'Show details', name: 'show_details' },
];
const CARS_COLUMNS = [
	{ label: 'Serial Number', fieldName: CAR_SERIAL_NUMBER_FIELD.fieldApiName, type: 'text' },
	{
        type: 'action',
        typeAttributes: { rowActions: CARS_ACTIONS },
    },
];
export default class AccountList extends LightningElement {
    accounts_columns = ACCOUNTS_COLUMNS;
    @wire(callGetAccount)
    accounts;
	showrooms_columns = SHOWROOMS_COLUMNS;
	searchAccountId = '';
	@wire(callGetShowroom, {accountId: '$searchAccountId'})
	showrooms;
	searchShowroomId = '';
	cars_columns = CARS_COLUMNS;
	@wire(callGetCar, {showroomId: '$searchShowroomId'})
	cars;
	@wire(MessageContext) messageContext;
	showAccounts = true;
	showShowrooms = false;
	showCars = false;

	handleBackClick(event) {
		if (this.showShowrooms) {
			this.showAccounts = true;
			this.showShowrooms = false;
		} else if (this.showCars) {
			this.showShowrooms = true;
			this.showCars = false;
		}
	}

	handleAccountRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;
        switch (actionName) {
            case 'show_showrooms':
				this.searchAccountId = row.External_ID__c;
				this.showShowrooms = true;
				this.showAccounts = false;
                break;
            default:
        }
    }

	handleShowroomRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;
        switch (actionName) {
            case 'show_cars':
				this.searchShowroomId = row.External_ID__c;
				this.showCars = true;
				this.showShowrooms = false;
                break;
            default:
        }
    }

	handleCarRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;
        switch (actionName) {
            case 'show_details':
				this.loadCar(row);
                break;
            default:
        }
    }

	loadCar(selectedCar) {
		if (selectedCar) {
			const message ={
				car: selectedCar
			}; 
			publish(this.messageContext, CAR_UPDATE_MESSAGE, message);
		}
	}

	@wire(MessageContext)
    messageContext;
    connectedCallback() {
        this.subscription = subscribe(
            this.messageContext,
            CAR_REFRESH_MESSAGE,
            (message) => {
				if(message.refresh){
					this.searchShowroomId = this.searchShowroomId;
				}
            });
    }

    disconnectedCallback() {
        unsubscribe(this.subscription);
        this.subscription = null;
    }
}