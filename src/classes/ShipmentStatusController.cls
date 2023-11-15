public with sharing class ShipmentStatusController {
    @AuraEnabled
    public static String getShipmentStatus(String trackingNumber) {
        String shipmentStatus;
        try {
            shipmentStatus = ShipmentCalloutService.fetchShipmentStatus(trackingNumber);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        return shipmentStatus;
    }
}