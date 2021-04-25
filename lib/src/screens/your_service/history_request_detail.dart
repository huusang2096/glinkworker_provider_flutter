import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:glinkwok_provider/src/common/config.dart';
import 'package:glinkwok_provider/src/model/provider_dispute_request_model.dart';
import 'package:glinkwok_provider/src/screens/your_service/cubit/past_service_cubit.dart';
import 'package:glinkwok_provider/src/widgets/app_progress_hub.dart';
import 'package:simplest/simplest.dart';

class HistoryRequestDetailScreen
    extends CubitWidget<PastServiceCubit, PastServiceState> {
  final int requestId;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  DateFormat dateFormat = DateFormat("MM-dd-yyyy");
  DateFormat timeFormat = DateFormat('hh:mm:ss');
  HistoryRequestDetailScreen(this.requestId);

  static provider(int requestId) {
    return BlocProvider<PastServiceCubit>(
      create: (_) => PastServiceCubit(),
      child: HistoryRequestDetailScreen(requestId),
    );
  }

  @override
  void listener(BuildContext context, PastServiceState state) {
    super.listener(context, state);
    if (state is DisputeSuccess) {
      _scaffoldKey.currentState.showSnackBar(new SnackBar(
          onVisible: () {
            bloc.getPastTripDetail(requestId);
          },
          duration: const Duration(seconds: 5),
          content: new Text(state.message)));
    }
  }

  @override
  void afterFirstLayout(BuildContext context) {
    bloc.getPastTripDetail(requestId);
  }

  @override
  Widget builder(BuildContext context, PastServiceState state) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          actions: [_buildActionDisputeButton(context)],
          backgroundColor: Colors.white,
          leading: IconButton(
            padding: EdgeInsets.all(0),
            icon: Icon(
              Icons.arrow_back,
              color: blackColor,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          automaticallyImplyLeading: false,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            'past_request_detail'.tr,
            style:
                heading1.copyWith(fontSize: 20.0, fontWeight: FontWeight.w500),
          ),
        ),
        body: _buildBody(context));
  }

  _buildBody(BuildContext context) {
    if (bloc.state.pastTripDetail == null) {
      return SpinKitCircle(
        color: Colors.grey,
        size: 36.0,
      );
    } else {
      return Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      height: 70,
                      width: 70,
                      child: bloc.state.pastTripDetail.user.picture == null
                          ? CircleAvatar(
                              child: Image.asset(Images.defaultAvatar))
                          : CircleAvatar(
                              child: CachedNetworkImage(
                                imageUrl: IMG_URL +
                                    bloc.state.pastTripDetail.user.picture,
                                width: 72.0,
                                height: 72.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            bloc.state.pastTripDetail.user.firstName ??
                                "" +
                                    " " +
                                    bloc.state.pastTripDetail.user.lastName ??
                                "",
                            style: body1,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        RatingBar.builder(
                          onRatingUpdate: null,
                          initialRating: (bloc
                              .state.pastTripDetail.rating.userRating
                              .toDouble()),
                          itemCount: 5,
                          itemSize: 15,
                          itemBuilder: (context, _) =>
                              Icon(Icons.star, color: Colors.amber),
                          allowHalfRating: true,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            bloc.state.pastTripDetail.startedAt == null
                                ? "-"
                                : timeFormat
                                    .format(bloc.state.pastTripDetail.startedAt)
                                    .toString(),
                            style: body1,
                          ),
                          SizedBox(height: 10),
                          Text(
                              bloc.state.pastTripDetail.finishedAt == null
                                  ? "-"
                                  : timeFormat
                                      .format(
                                          bloc.state.pastTripDetail.finishedAt)
                                      .toString(),
                              style: body1),
                          SizedBox(height: 10),
                          Text(bloc.state.pastTripDetail.bookingId,
                              style: body1)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                thickness: 2,
                height: 5,
              ),
              Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      FontAwesomeIcons.gripLinesVertical,
                      size: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        bloc.state.pastTripDetail?.sAddress,
                        style: body1,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 2,
                height: 5,
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(10),
                child: Text(
                  "pay_via".tr,
                  style: body1,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Icon(FontAwesomeIcons.moneyBill),
                      ),
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                              (bloc.state.pastTripDetail?.paymentMode ?? "-")
                                  .tr)),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(currencyFormatter
                        .format(bloc.state.pastTripDetail.payment?.cash ?? 0)),
                  )
                ],
              ),
              Divider(
                thickness: 2,
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "comment".tr,
                    style: body1,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                    padding: EdgeInsets.all(5),
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                        bloc.state.pastTripDetail?.rating?.userComment ??
                            "no_comment".tr)),
              ),
              _buildViewReceiptButton(context),
            ],
          ),
        ),
      );
    }
  }

  _buildViewReceiptButton(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => _buildViewReceipt(context));
      },
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: 50,
          decoration: BoxDecoration(
              color: redColor2, borderRadius: BorderRadius.circular(10)),
          child: Text(
            "view_receipt".tr.toUpperCase(),
            style: body1.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  _buildDisputeBottomSheet(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        if (bloc.state.disputeList == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Container(
          padding: EdgeInsets.all(10),
          height: 300,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "dispute".tr,
                  style: heading1,
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.all(5),
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        bloc.selectDispute(index);
                        setState(() {
                          bloc.state.selectedDispute = index;
                        });
                      },
                      title: Text(bloc.state.disputeList[index].disputeName),
                      leading: bloc.state.selectedDispute == index
                          ? Icon(
                              Icons.check_circle,
                              color: Colors.black,
                            )
                          : Icon(
                              Icons.check_circle,
                              color: Colors.grey,
                            ),
                    );
                  },
                  itemCount: bloc.state.disputeList.length,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        bloc.state.selectedDispute = null;
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                            color: redColor2,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "dismiss".tr,
                          style: body1.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (bloc.state.selectedDispute == null) {
                          return;
                        } else {
                          ProviderDisputeRequest request =
                              new ProviderDisputeRequest();
                          request.disputeName = bloc
                              .state
                              .disputeList[bloc.state.selectedDispute]
                              .disputeName;
                          request.providerId =
                              bloc.state.pastTripDetail.providerId;
                          request.userId = bloc.state.pastTripDetail.userId;
                          request.requestId = bloc.state.pastTripDetail.id;
                          request.disputeType = "provider";
                          request.comments =
                              bloc.state.pastTripDetail.rating.userComment;
                          Navigator.of(context).pop();
                          bloc.dispute(request);
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                            color: redColor2,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text("submit".tr,
                            style: body1.copyWith(color: Colors.white)),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _buildActionDisputeButton(BuildContext context) {
    if (bloc.state.pastTripDetail == null) {
      return SizedBox.shrink();
    } else if (bloc.state.pastTripDetail.isDispute == 0) {
      return _buildDisputePopupMenu(context);
    } else if (bloc.state.pastTripDetail.isDispute == 1) {
      return _buildDisputeStatusPopupMenu(context);
    }
  }

  _buildDisputeStatusBottomSheet(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 300,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "dispute".tr,
              style: heading1,
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              "this_trip_was_dispute_to_admin".tr,
              style: body1,
            ),
          ],
        ),
      ),
    );
  }

  _buildViewReceipt(BuildContext context) {
    return Container(
      height: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "invoice".tr,
              style: heading1,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "booking_id".tr,
                  style: body1,
                ),
                Text(bloc.state.pastTripDetail.bookingId, style: body1)
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("total".tr, style: body1),
                Text(
                    currencyFormatter
                        .format(bloc.state.pastTripDetail?.payment?.cash ?? 0),
                    style: body1)
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                    color: redColor2, borderRadius: BorderRadius.circular(10)),
                child: Text(
                  "close".tr.toUpperCase(),
                  style: body1.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildDisputeStatusPopupMenu(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        showModalBottomSheet(
          isDismissible: true,
          context: context,
          builder: (context) {
            return _buildDisputeStatusBottomSheet(context);
          },
        );
      },
      itemBuilder: (BuildContext context) {
        return {'dispute_status'.tr}.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(
              choice,
              style: body1,
            ),
          );
        }).toList();
      },
    );
  }

  _buildDisputePopupMenu(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        showModalBottomSheet(
          isDismissible: true,
          context: context,
          builder: (context) {
            return _buildDisputeBottomSheet(context);
          },
        );
      },
      itemBuilder: (BuildContext context) {
        return {'dispute'.tr}.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(
              choice,
              style: body1,
            ),
          );
        }).toList();
      },
    );
  }
}
