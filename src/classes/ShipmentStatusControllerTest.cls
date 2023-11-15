@IsTest
private class ShipmentStatusControllerTest {
    @IsTest
    private static void getShipmentStatusTest() {
        Test.setMock(HttpCalloutMock.class, new MockShippingStatusService());

        Test.startTest();
        String response = ShipmentStatusController.getShipmentStatus('123');
        Test.stopTest();

        Assert.areEqual('Shipped On Time', response, 'Wrong response from MockShippingStatusService');
    }
}