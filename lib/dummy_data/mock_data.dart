import '../models/product.dart';

class MockData {
  static const List<Product> products = [
    Product(
      id: '1',
      title: 'Organic Lavender Oil',
      description: 'Premium organic lavender essential oil for relaxation.',
      price: 45.0,
      imageUrl: 'https://images.unsplash.com/photo-1596462502278-27bfdc403348?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
      category: 'Wellness',
    ),
    Product(
      id: '2',
      title: 'Himalayan Bath Salts',
      description: 'Detoxifying bath salts sourced from the Himalayas.',
      price: 35.0,
      imageUrl: 'https://images.unsplash.com/photo-1608248543803-ba4f8c70ae0b?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
      category: 'Spa',
    ),
    Product(
      id: '3',
      title: 'Silk Sleep Mask',
      description: '100% pure mulberry silk sleep mask for deep rest.',
      price: 60.0,
      imageUrl: 'https://images.unsplash.com/photo-1582213782179-e0d53f98f2ca?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
      category: 'Sleep',
    ),
  ];
}
