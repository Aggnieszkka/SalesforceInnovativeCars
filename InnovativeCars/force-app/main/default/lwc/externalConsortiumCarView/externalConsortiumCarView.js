import { LightningElement, wire } from 'lwc';
import { publish, subscribe, unsubscribe, MessageContext } from 'lightning/messageService';
import CAR_UPDATE_MESSAGE from '@salesforce/messageChannel/CarUpdate__c';
import CAR_REFRESH_MESSAGE from '@salesforce/messageChannel/CarRefresh__c';
import patchCar from '@salesforce/apex/CarRESTAPI.callPatchCar';
export default class externalConsortiumCarView extends LightningElement {
    car = null;
    interested = false;
    cardTitle = '';
    subscription = null;
    @wire(MessageContext)
    messageContext;
    connectedCallback() {
        this.subscription = subscribe(
            this.messageContext,
            CAR_UPDATE_MESSAGE,
            (message) => {
                this.handleCarUpdate(message);
            });
    }

    disconnectedCallback() {
        unsubscribe(this.subscription);
        this.subscription = null;
    }

    handleCarUpdate(message) {
        this.car = message.car; 
        this.cardTitle = 'Car - ' + message.car.Serial_Number__c;
        this.interested =  this.car.Is_Another_Consortium_Interested__c;
    }

    handleInterestClick(event) {
       this.handlePatch(this.car.External_ID__c);
    }

    handlePatch(carId) {
        patchCar({ carId: carId })
        .then((result) => {
            this.interested = result;
            const message = {
				refresh: true
			};
			publish(this.messageContext, CAR_REFRESH_MESSAGE, message);
        })
        .catch((error) => {
            alert('error: ' + error);
        });
    }
}