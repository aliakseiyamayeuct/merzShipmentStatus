@IsTest
private class ShipmentCalloutServiceTest {
    @IsTest
    private static void fetchShipmentStatusTest() {
        Test.setMock(HttpCalloutMock.class, new MockShippingStatusService());

        Test.startTest();
        String response = ShipmentCalloutService.fetchShipmentStatus('123');
        Test.stopTest();

        Assert.areEqual('Shipped On Time', response, 'Wrong response from MockShippingStatusService');
    }
}