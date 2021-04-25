import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

export 'resources.dart';
export 'style.dart';

const kAppName = 'GlinkWork';
const String kCurrency = 'đ';
const String hostUrl = 'https://glinkwork.org/';
const String GOOGLE_BASE_URL = 'https://maps.googleapis.com/maps/api/';
const String BASE_URL = '$hostUrl';
const String FIREBASE_URL = 'https://glinkwork-261503.firebaseio.com/';
const String IMG_URL = '$hostUrl/storage/';
const String apiKey = 'AIzaSyBd9h7ErMGJ_4pSY4meQQcSBQPG-9teav4';
const String kSupportNumber = '190';

const String CLIENT_ID = '2';
const String CLIENT_SECRET = 'belaTTHPlUNjNAeSngXbeg1nLgxn47t7BXjIDEpz';

final currencyFormatter = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
final dateFormatter = DateFormat('yyyy-MM-dd');
final hourFormatter = DateFormat('h:mm a');
final fullDateFormatter = DateFormat('yyyy-MM-dd hh:mm:ss');

const int BANK_PASSBOOK_ID = 1;
const int REGISTRATION_ID = 2;

const supportedLocales = [
  Locale('en'),
  Locale('vi', 'VN'),
];
