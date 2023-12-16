const String createCustomerUrl = 'https://api.stripe.com/v1/customers';
String getCustomerUrl(String email) => 'https://api.stripe.com/v1/customers/search?query=email:"$email"';
const String createPaymentMethodUrl = 'https://api.stripe.com/v1/payment_methods';
String retrievePaymentMethodUrl(String id) => 'https://api.stripe.com/v1/customers/$id/payment_methods?type=card';
String attachPaymentMethodUrl(String id) => 'https://api.stripe.com/v1/payment_methods/$id/attach';
String detachPaymentMethodUrl(String id) => 'https://api.stripe.com/v1/payment_methods/$id/detach';