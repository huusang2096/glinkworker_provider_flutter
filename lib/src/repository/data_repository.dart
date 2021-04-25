import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:glinkwok_provider/locator.dart';
import 'package:glinkwok_provider/src/common/storage/app_prefs.dart';
import 'package:glinkwok_provider/src/model/base_response.dart';
import 'package:glinkwok_provider/src/model/cancel_reason_response.dart';
import 'package:glinkwok_provider/src/model/card_response.dart';
import 'package:glinkwok_provider/src/model/document_response.dart';
import 'package:glinkwok_provider/src/model/forgot_password_request.dart';
import 'package:glinkwok_provider/src/model/help_response.dart';
import 'package:glinkwok_provider/src/model/login_request.dart';
import 'package:glinkwok_provider/src/model/login_response.dart';
import 'package:glinkwok_provider/src/model/notification_response.dart';
import 'package:glinkwok_provider/src/model/profile_response.dart';
import 'package:glinkwok_provider/src/model/provider_dispute_request_model.dart';
import 'package:glinkwok_provider/src/model/register_request.dart';
import 'package:glinkwok_provider/src/model/register_response.dart';
import 'package:glinkwok_provider/src/model/ride_response.dart';
import 'package:glinkwok_provider/src/model/summary_response.dart';
import 'package:glinkwok_provider/src/model/trip_response.dart';
import 'package:glinkwok_provider/src/model/update_trip_request.dart';
import 'package:glinkwok_provider/src/model/waiting_time_response.dart';
import 'package:glinkwok_provider/src/model/wallet_transaction_response_model.dart';
import 'package:glinkwok_provider/src/screens/your_service/models/dispute_list_response_model.dart';
import 'package:glinkwok_provider/src/screens/your_service/models/provider_ongoing_trip_response_model.dart';
import 'package:glinkwok_provider/src/screens/your_service/models/provider_past_trip_detail_response_model.dart';
import 'package:glinkwok_provider/src/screens/your_service/models/provider_past_trip_response_model.dart';
import 'package:logger/logger.dart';
import 'package:simplest/simplest.dart';

import '../model/register_request.dart';
import '../model/register_response.dart';
import '../network/rest_client.dart';

@lazySingleton
class DataRepository implements RestClient {
  final logger = Logger();
  final dio = Dio();
  RestClient _client;
  final _appPref = locator<AppPref>();

  DataRepository() {
    // dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    _client = RestClient(dio);
    loadAuthHeader();
  }

  void loadAuthHeader() async {
    final _token = _appPref.token;
    log('[access_token] $_token');
    dio.options.headers["X-Requested-With"] = "XMLHttpRequest";
    dio.options.headers["Authorization"] = "Bearer ${_appPref.token}";
    dio.options.headers["Accept-Language"] = _appPref.langCode;
  }

  Future<RegisterResponse> register(RegisterRequest registerRequest) async {
    return _client.register(registerRequest);
  }

  Future<LoginResponse> login(LoginRequest request) async {
    return _client.login(request);
  }

  Future<DocumentResponse> uploadDocumentResponse(
      {Document bankPassbook, Document registration}) {
    return _client.postUploadDocuments(
      bankPassbook: File(bankPassbook?.providerdocuments?.url),
      docIdBankPassbook: bankPassbook?.providerdocuments?.documentId,
      registration: File(registration?.providerdocuments?.url),
      docIdRegistration: registration?.providerdocuments?.documentId,
    );
  }

  @override
  Future<DocumentResponse> postUploadDocuments(
      {File bankPassbook,
      String docIdBankPassbook,
      File registration,
      String docIdRegistration}) {
    return _client.postUploadDocuments(
      bankPassbook: bankPassbook,
      docIdBankPassbook: docIdBankPassbook,
      registration: registration,
      docIdRegistration: docIdRegistration,
    );
  }

  @override
  Future<DocumentResponse> getDocuments() {
    return _client.getDocuments();
  }

  Future<ProfileResponse> getProfile() async {
    return _client.getProfile();
  }

  Future<void> logout({String userId}) async {
    return _client.logout(userId: userId);
  }

  Future<ProfileResponse> updateProfile(
      {String country_code,
      String mobile,
      String first_name,
      String last_name,
      String email,
      File avatar}) async {
    return _client.updateProfile(
      country_code: country_code,
      mobile: mobile,
      first_name: first_name,
      last_name: last_name,
      email: email,
      avatar: avatar,
    );
  }

  @override
  Future<List<ProviderPastTripResponse>> getPastTrip() {
    return _client.getPastTrip();
  }

  @override
  Future<ProviderPastTripDetailResponse> getPastTripDetail(int request_id) {
    return _client.getPastTripDetail(request_id);
  }

  @override
  Future<List<ProviderOngoingTripDetailResponse>> getUpcomingTrip() {
    return _client.getUpcomingTrip();
  }

  @override
  Future<ProviderPastTripDetailResponse> getUpcomingTripDetail(int request_id) {
    throw _client.getUpcomingTripDetail(request_id);
  }

  Future<TripResponse> getTrip({double latitude, double longitude}) {
    return _client.getTrip(latitude: latitude, longitude: longitude);
  }

  @override
  Future<TripResponse> providerAvailable(String serviceStatus) {
    return _client.providerAvailable(serviceStatus);
  }

  @override
  Future<void> acceptRequest({String dummy = "", int requestId}) {
    return _client.acceptRequest(requestId: requestId);
  }

  @override
  Future<void> rejectRequest(int requestId) {
    return _client.rejectRequest(requestId);
  }

  @override
  Future<List<DisputeListResponse>> disputeList(String disputeType) {
    return _client.disputeList(disputeType);
  }

  @override
  Future<BaseResponse> dispute(ProviderDisputeRequest request) {
    return _client.dispute(request);
  }

  Future<void> cancelRequest(int id, String reason) {
    return _client.cancelRequest(id, reason);
  }

  @override
  Future<TripResponse> updateRequest(
      {int requestId, UpdateTripRequest request}) {
    return _client.updateRequest(requestId: requestId, request: request);
  }

  @override
  Future<void> ratingRequest(
      {int requestId, int rating = 5, String comment = ''}) {
    return _client.ratingRequest(
        requestId: requestId, rating: rating, comment: comment);
  }

  @override
  Future<HelpResponse> getHelp() {
    return _client.getHelp();
  }

  @override
  Future<WalletTransactionResponse> getWalletTransaction() {
    return _client.getWalletTransaction();
  }

  Future<RideResponse> getRideTarget() {
    return _client.getRideTarget();
  }

  Future<SummaryResponse> getSummary({String data}) {
    return _client.getSummary(data: data);
  }

  @override
  Future<List<NotificationResponse>> getListNotification() {
    return _client.getListNotification();
  }

  @override
  Future<List<CardResponse>> getProviderCard() {
    return _client.getProviderCard();
  }

  @override
  Future<BaseResponse> addCard(String stripeToken) {
    return _client.addCard(stripeToken);
  }

  Future<WaitingTimeResponse> checkWaitingTime(int id) {
    return _client.checkWaitingTime(id);
  }

  @override
  Future<WaitingTimeResponse> waitingTime(int id, String status) {
    return _client.waitingTime(id, status);
  }

  @override
  Future<void> postChatItem({String sender, String userId, String message}) {
    return _client.postChatItem(
        sender: sender, userId: userId, message: message);
  }

  @override
  Future<BaseResponse> resetPassword(
      ForgotPasswordRequest forgotPasswordRequest) {
    return _client.resetPassword(forgotPasswordRequest);
  }

  @override
  Future<List<CancelReasonResponse>> getCancelReason() {
    return _client.getCancelReason();
  }
}
