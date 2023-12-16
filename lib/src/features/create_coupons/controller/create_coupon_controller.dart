// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/shared/response_widgets/toast.dart';

import '../repository/coupon_repo.dart';

final createCouponDataProvider = StateProvider<CreateCoupon>((ref) {
  return const CreateCoupon(code: '', title: '', id: '');
});

final hasCouponProvider =
    Provider.autoDispose.family<bool, String?>((ref, username) {
  final services = ref.watch(userCouponsProvider(username)).valueOrNull ?? [];
  return services.isNotEmpty;
});

final userCouponsProvider = AsyncNotifierProvider.family
    .autoDispose<CouponNotifier, List<CreateCoupon>, String?>(
        CouponNotifier.new);

class CouponNotifier
    extends AutoDisposeFamilyAsyncNotifier<List<CreateCoupon>, String?> {
  // bool _isSingleSelection = true;
  final _repository = CouponRepository.instance;
  @override
  Future<List<CreateCoupon>> build(username) async {
    final response = await _repository.getUserCoupons(username: username);

    return response.fold((left) {
      print('Failed fetching coupoons');
      return [];
    }, (right) {
      final dList = right.map((e) => CreateCoupon.fromMap(e));
      // return right;
      return dList.toList();
    });
  }

  Future<bool> createCoupon({
    required String code,
    required String title,
    String? expiryDate,
    int? useLimit,
  }) async {
    // final data = ref.read(createCouponDataProvider);
    final response = await _repository.createCoupon(
        code: code, title: title, expiryDate: expiryDate, useLimit: useLimit);

    return response.fold((left) {
      VWidgetShowResponse.showToast(ResponseEnum.sucesss,
          message: 'Failed to create coupon');
      print(left.message);
      return false;
    }, (right) {
      final success = (right['message'] ?? '').contains('success');
      if (success) {
        // VWidgetShowResponse.showToast(ResponseEnum.sucesss,
        //     message: 'Coupon created successfully');

        final currentState = state.valueOrNull ?? [];
        currentState.add(CreateCoupon(code: code, title: title, id: ''));
        state = AsyncData(currentState);
      }
      return success;
    });
  }

  //Update coupons
  Future<bool> updateCoupon({
    String? code,
    String? title,
    String? expiryDate,
    int? useLimit,
    required String couponId,
  }) async {
    // final data = ref.read(createCouponDataProvider);
    final response = await _repository.updateCoupon(
        code: code,
        title: title,
        couponId: int.parse(couponId),
        expiryDate: expiryDate,
        useLimit: useLimit);

    return response.fold((left) {
      VWidgetShowResponse.showToast(ResponseEnum.sucesss,
          message: 'Failed to update coupon');
      return false;
    }, (right) async {
      final success = (right['message'] ?? '').contains('success');
      if (success) {
        // VWidgetShowResponse.showToast(ResponseEnum.sucesss,
        //     message: 'Coupon updated successfully');

        final currentState = state.valueOrNull ?? [];
        currentState.add(CreateCoupon(
          code: code!,
          title: title!,
          id: couponId,
        ));
        state = AsyncData(currentState);
      }
      return success;
    });
  }

  Future<bool> deleteCoupon(String couponId) async {
    // final data = ref.read(createCouponDataProvider);
    final response =
        await _repository.deleteCoupon(couponId: int.parse(couponId));

    return response.fold((left) {
      VWidgetShowResponse.showToast(ResponseEnum.sucesss,
          message: 'Failed to delete coupon');
      return false;
    }, (right) {
      // VWidgetShowResponse.showToast(ResponseEnum.sucesss,
      //     message: 'Coupon deleted successfully');

      final currentState = state.valueOrNull ?? [];
      currentState.removeWhere((coupon) => coupon.id == couponId);
      state = AsyncData(currentState);

      return true;
    });
  }

  // Future<dynamic> getCoupons(String username) async {
  //   final _repository = CouponRepository.instance;
  //   // final data = ref.read(createCouponDataProvider);
  //   final response = await _repository.getUserCoupons(username: username);

  //   return response.fold((left) {
  //     VWidgetShowResponse.showToast(ResponseEnum.sucesss,
  //         message: 'Failed to create job');
  //     return false;
  //   }, (right) {
  //     final success = right['code'].toString().isNotEmpty;
  //     print("$success ###############################---- ${right['code']}");
  //     if (success) {
  //       VWidgetShowResponse.showToast(ResponseEnum.sucesss,
  //           message: 'Coupon retrived successfully');
  //     }
  //     return right;
  //   });
  // }
}

// Duration get dateDuration => endTime - startTime;

//Generated

@immutable
class CreateCoupon {
  // final DateTime date;
  // final Duration startTime;
  // final Duration endTime;
  // final bool isFullDay;

  final String code;
  final String title;
  final String id;

  // Duration get dateDuration => endTime - startTime;

//Generated
  const CreateCoupon({
    required this.code,
    required this.title,
    required this.id,
  });

  CreateCoupon copyWith(
      {required String code, required String title, required String id}) {
    return CreateCoupon(
        code: code ?? this.code, title: title ?? this.title, id: id);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      // 'date': '${date.year}-${date.month}-${date.day}',
      'code': code,
      'title': title,
      'id': id,

      // 'isFullDay': isFullDay,
    };
  }

  factory CreateCoupon.fromMap(Map<String, dynamic> map) {
    try {
      dynamic code = map['code'] as String;
      // start = int.parse(start);
      dynamic title = map['title'] as String;
      dynamic id = map['id'] as String;
      //end = int.parse(end);

      return CreateCoupon(
        code: code,
        title: title,
        id: id,
      );
    } catch (e, st) {
      print('$e \n $st');
      rethrow;
    }
  }

  String toJson() => json.encode(toMap());

  // factory JobDeliveryDate.fromJson(String source) =>
  //     JobDeliveryDate.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CreateCoupon(code: $code, title: $title,)';
  }

  @override
  bool operator ==(covariant CreateCoupon other) {
    if (identical(this, other)) return true;

    return other.code == code && other.title == title;
  }

  @override
  int get hashCode {
    return code.hashCode ^ title.hashCode;
  }
}
