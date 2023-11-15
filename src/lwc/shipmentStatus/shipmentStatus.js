import { LightningElement, api, wire } from 'lwc';

import getShipmentStatus from '@salesforce/apex/ShipmentStatusController.getShipmentStatus';

import SHIPMENT_TRACKING_NUMBER_FIELD from "@salesforce/schema/Shipment__c.TrackingNumber__c";
import { getRecord } from "lightning/uiRecordApi";
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import error from "@salesforce/label/c.Error";
import somethingWentWrong from "@salesforce/label/c.PleaseContactAdmin";

export default class ShipmentStatus extends LightningElement {
    @api recordId;

    trackingNumber;
    shipmentStatus;
    isSpinnerShowed = true;
    isError = false;

    labels = { error, somethingWentWrong };

    @wire(getRecord, { recordId: "$recordId", fields: [SHIPMENT_TRACKING_NUMBER_FIELD] })
    wiredShipment({error,data}) {
        if (data) {
            this.trackingNumber = data.fields.TrackingNumber__c.value;
            this.fetchShipmentStatus();
        } else if (error) {
            console.log(error);
            this.showErrorToast(this.labels.error, this.labels.somethingWentWrong);
            this.isError = true;
        }
    }

    fetchShipmentStatus() {
        this.showSpinner();
        getShipmentStatus({ trackingNumber : this.trackingNumber })
            .then((result) => {
                this.shipmentStatus = result;
            }).catch((error) => {
                console.log(error);
                this.showErrorToast(this.labels.error, this.labels.somethingWentWrong);
                this.isError = true;
            }).finally(() => {
                this.hideSpinner();
            });
    }

    showSpinner() {
        this.isSpinnerShowed = true;
    }

    hideSpinner() {
        this.isSpinnerShowed = false;
    }

    showErrorToast(title, message) {
        this.dispatchEvent(
            new ShowToastEvent({
                title,
                message,
                variant: "error",
            }),
        );
    }
}