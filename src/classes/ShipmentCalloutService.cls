public with sharing class ShipmentCalloutService {
    @TestVisible
    private final static String STATUS_PATH = '/mockShipmentStatus';
    @TestVisible
    private final static String TRACKING_NUMBER_ARG = '?trackingNumber=';

    public static String fetchShipmentStatus(String trackingNumber) {
        HttpRequest request = new HttpRequest();

        String endpoint = 'callout:Shipments' + STATUS_PATH;
        if (!String.isBlank(trackingNumber)) {
            endpoint += TRACKING_NUMBER_ARG + trackingNumber;
        }
        request.setEndpoint(endpoint);
        request.setMethod('GET');

        Http http = new Http();
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            return response.getBody();
        } else {
            return 'HTTP Error: ' + response.getStatusCode() + ' ' + response.getStatus();
        }
    }
}