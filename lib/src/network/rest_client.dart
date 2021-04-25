import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:glinkwok_provider/src/common/config.dart';
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
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: BASE_URL)
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  @POST("api/provider/register")
  @FormUrlEncoded()
  Future<RegisterResponse> register(@Body() RegisterRequest registerRequest);

  @POST('/api/provider/oauth/token')
  @FormUrlEncoded()
  Future<LoginResponse> login(@Body() LoginRequest request);

  @MultiPart()
  @POST("api/provider/profile/documents/store")
  Future<DocumentResponse> postUploadDocuments({
    @Part(value: "document[0]") File bankPassbook,
    @Part(value: "id[0]") String docIdBankPassbook,
    @Part(value: "document[1]") File registration,
    @Part(value: "id[1]") String docIdRegistration,
  });

  @GET("api/provider/profile/documents")
  Future<DocumentResponse> getDocuments();

  @GET("api/provider/target")
  Future<RideResponse> getRideTarget();

  @GET("api/provider/notifications/provider")
  Future<List<NotificationResponse>> getListNotification();

  @POST("api/provider/logout")
  @FormUrlEncoded()
  Future<void> logout({
    @Field("id") String userId,
  });

  @GET("api/provider/profile")
  Future<ProfileResponse> getProfile();

  @POST("api/provider/profile")
  @MultiPart()
  Future<ProfileResponse> updateProfile(
      {@Part() String country_code,
      @Part() String mobile,
      @Part() String last_name,
      @Part() String first_name,
      @Part() String email,
      @Part() File avatar});

  @GET("api/provider/requests/history")
  Future<List<ProviderPastTripResponse>> getPastTrip();

  @GET("api/provider/requests/history/details")
  Future<ProviderPastTripDetailResponse> getPastTripDetail(
      @Query("request_id") int request_id);
  @GET("api/provider/requests/upcoming")
  Future<List<ProviderOngoingTripDetailResponse>> getUpcomingTrip();

  @GET("api/provider/requests/upcoming/details")
  Future<ProviderPastTripDetailResponse> getUpcomingTripDetail(
      @Query("request_id") int request_id);

  @GET("api/provider/trip")
  Future<TripResponse> getTrip(
      {@Query('latitude') double latitude,
      @Query('longitude') double longitude});

  @POST("api/provider/profile/available")
  Future<TripResponse> providerAvailable(
      @Field('service_status') String serviceStatus);

  @DELETE('api/provider/trip/{request_id}')
  Future<void> rejectRequest(@Path('request_id') int requestId);

  @POST('api/provider/trip/{request_id}')
  @FormUrlEncoded()
  Future<void> acceptRequest(
      {@Field("dummy") String dummy = "",
      @required @Path('request_id') int requestId});

  @POST("api/provider/dispute-list")
  @FormUrlEncoded()
  Future<List<DisputeListResponse>> disputeList(
      @Field('dispute_type') String disputType);

  @POST("api/provider/dispute")
  @FormUrlEncoded()
  Future<BaseResponse> dispute(@Body() ProviderDisputeRequest request);

  @POST('api/provider/cancel')
  @FormUrlEncoded()
  Future<void> cancelRequest(
      @Field("id") int id, @Field('cancel_reason') String reason);

  @POST('api/provider/waiting')
  @FormUrlEncoded()
  Future<WaitingTimeResponse> waitingTime(
      @Field("id") int id, @Field("status") String status);

  @POST('api/provider/waiting')
  @FormUrlEncoded()
  Future<WaitingTimeResponse> checkWaitingTime(@Field("id") int id);

  @POST('api/provider/trip/{request_id}')
  Future<TripResponse> updateRequest(
      {@required @Path("request_id") int requestId,
      @Body() UpdateTripRequest request});

  @POST('api/provider/trip/{request_id}/rate')
  @FormUrlEncoded()
  Future<void> ratingRequest({
    @required @Path("request_id") int requestId,
    @Field('rating') int rating,
    @Field('comment') String comment,
  });

  @GET("api/provider/help")
  Future<HelpResponse> getHelp();

  @POST("api/provider/summary")
  @FormUrlEncoded()
  Future<SummaryResponse> getSummary({@Field("data") String data});

  @GET('api/provider/wallettransaction')
  Future<WalletTransactionResponse> getWalletTransaction();

  @GET('api/provider/providercard')
  Future<List<CardResponse>> getProviderCard();

  @POST('api/provider/providercard')
  Future<BaseResponse> addCard(@Field('stripe_token') String stripeToken);

  @POST("api/provider/chat")
  @FormUrlEncoded()
  Future<void> postChatItem(
      {@Field('sender') String sender,
      @Field('user_id') String userId,
      @Field('message') String message});

  @POST("api/provider/reset-pass-with-otp-token")
  @FormUrlEncoded()
  Future<BaseResponse> resetPassword(
      @Body() ForgotPasswordRequest forgotPasswordRequest);

  @GET("api/provider/reasons")
  Future<List<CancelReasonResponse>> getCancelReason();
}
