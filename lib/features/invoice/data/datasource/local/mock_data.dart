import '../../../domain/entities/customer.dart';
import '../../../domain/entities/seller.dart';

final mockCustomers = <Customer>[
  Customer(
    id: 'customer-1',
    name: 'عميل نقدي عام',
    city: 'الرياض',
    country: 'السعودية',
    postalCode: '8727',
    vatNumber: '8727',
    commercialRegister: '3006256961000003',
    otherId: '10',
  ),
];

final mockSellers = <Seller>[
  Seller(
    id: 'seller-1',
    name: 'شركة قصر الروابي',
    city: 'الرياض',
    country: 'السعودية',
    postalCode: '8727',
    vatNumber: '8727',
    commercialRegister: '3006256961000003',
    otherId: '10',
    address: '3761 طريق الملك فهد الفرعي',
    companyName: 'شركة قصر الروابي',
  ),
];

Customer? getCustomerById(String id) {
  for (final customer in mockCustomers) {
    if (customer.id == id) return customer;
  }
  return null;
}

Seller? getSellerById(String id) {
  for (final seller in mockSellers) {
    if (seller.id == id) return seller;
  }
  return null;
} 