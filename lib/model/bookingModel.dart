import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_3/model/packagemodel.dart';

class Booking {
  final String id;
  final String userId;
  final String userName;
  final String userEmail;
  final String userPhone;
  final PackageModel package;
  final String paymentMethod;
  final double totalAmount;
  final DateTime bookingDate;

  Booking({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.userPhone,
    required this.package,
    required this.paymentMethod,
    required this.totalAmount,
    required this.bookingDate,
  });

  factory Booking.fromJson(Map<String, dynamic> map, String id) {
    return Booking(
      id: id,
      userId: map['userId'],
      userName: map['userName'],
      userEmail: map['userEmail'],
      userPhone: map['userPhone'],
      package: PackageModel.fromJson(map['package']),
      paymentMethod: map['paymentMethod'],
      totalAmount: map['totalAmount'],
      bookingDate: (map['bookingDate'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'userEmail': userEmail,
      'userPhone': userPhone,
      'package': package.toJson(),
      'paymentMethod': paymentMethod,
      'totalAmount': totalAmount,
      'bookingDate': Timestamp.fromDate(bookingDate),
    };
  }
}
