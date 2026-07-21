import 'package:flutter_riverpod/flutter_riverpod.dart';

class Booking {
  final String id;
  final String title;
  final DateTime date;
  final String location;
  final String type; // 'Wellness', 'Activity', 'Rental'

  Booking({
    required this.id,
    required this.title,
    required this.date,
    required this.location,
    required this.type,
  });
}

class BookingsNotifier extends Notifier<List<Booking>> {
  @override
  List<Booking> build() => [];

  void addBooking(Booking booking) {
    state = [...state, booking];
  }

  void cancelBooking(String id) {
    state = state.where((b) => b.id != id).toList();
  }
}

final bookingsProvider = NotifierProvider<BookingsNotifier, List<Booking>>(() {
  return BookingsNotifier();
});
