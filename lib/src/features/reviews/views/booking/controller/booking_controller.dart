import 'dart:developer' as dev;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/booking_data.dart';
import '../repository/booking_repo.dart';

final createBookingProvider =
    FutureProvider.family.autoDispose<String?, BookingData>((ref, data) async {
  final repo = BookingRepository.instance;
  final res = await repo.createBooking(bookingData: data.toMap());
  return res.fold((left) {
    dev.log('Error creating booking ${left.message}');
    return null;
  }, (right) {
    dev.log('Success creating booking ${right}');
    return right['booking']['id'];
  });
  // return res;
});

final createPaymentProvider = FutureProvider.family
    .autoDispose<Map<String, dynamic>, String>((ref, id) async {
  dev.log('>>>>Creating payment ID: $id<<<<<<');
  final repo = BookingRepository.instance;
  final _id = int.tryParse(id);
  if (_id == null) return {};
  final res = await repo.createPayment(bookingId: _id);
  return res.fold((left) {
    dev.log('Error creating payment ${left.message}');
    return {};
  }, (right) {
    dev.log('Success stripe payment ${right}');
    return right;
  });
  // return res;
});
