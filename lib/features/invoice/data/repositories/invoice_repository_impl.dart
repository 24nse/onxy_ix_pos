import '../../../order/data/repositories/cart_repository_impl.dart';
import '../../../order/domain/entities/cart_item.dart';
import '../../domain/entities/invoice.dart';
import '../../domain/entities/invoice_item.dart';
import '../../domain/repositories/invoice_repository.dart';

class InvoiceRepositoryImpl implements InvoiceRepository {
  final CartRepositoryImpl cartRepository;

  InvoiceRepositoryImpl({required this.cartRepository});

  @override
  Future<Invoice> getInvoice(String id) async {
    List<CartItem> cartItems = cartRepository.getCartItems();
    List<InvoiceItem> invoiceItems = [];
    int number = 1;
    for (var cartItem in cartItems) {
      invoiceItems.add(
        InvoiceItem(
          number: number++,
          name: cartItem.product.name,
          unit: 'وحدة', 
          quantity: cartItem.quantity,
          freeQuantity: 0,
          price: cartItem.product.price,
          vatPercent: cartItem.taxPercent,
          vatValue: cartItem.taxAmount,
          total: cartItem.total,
        ),
      );
    }
    return Invoice(
      id: id,
      date: DateTime.now(),
      dueDate: DateTime.now().add(Duration(days: 7)),
      paymentMethod: 'نقدي',
      customerId: 'customer-1',
      sellerId: 'seller-1',
      items: invoiceItems,
      subtotal: invoiceItems.fold(0, (sum, item) => sum + (item.price * item.quantity)),
      discount: 0.0,
      totalVat: invoiceItems.fold(0, (sum, item) => sum + item.vatValue),
      totalExempt: 0.0,
      totalWithVat: invoiceItems.fold(0, (sum, item) => sum + item.total),
      amountInWords: 'مائة وخمسة ريال سعودي فقط لا غير',
    );
  }
} 