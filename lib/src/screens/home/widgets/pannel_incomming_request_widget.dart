import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glinkwok_provider/src/common/config.dart';
import 'package:glinkwok_provider/src/screens/home/cubit/home_cubit.dart';
import 'package:glinkwok_provider/src/widgets/image_error_widget.dart';
import 'package:glinkwok_provider/src/widgets/placeholder_widget.dart';
import 'package:simplest/simplest.dart';

class PannelIncommingRequest extends StatelessWidget {
  final CountDownTimeServiceController c =
      Get.put(CountDownTimeServiceController());

  @override
  Widget build(BuildContext context) {
    final bloc = context.bloc<HomeCubit>();
    if (bloc.state.tripResponse.requests.length == 0) {
      return SizedBox.shrink();
    }
    final tripDetail = bloc.state.tripResponse.requests.first.detail;
    final _avatarUrl = IMG_URL + (tripDetail?.user?.picture ?? '');
    final _spaceWidget = SizedBox(
      height: 10,
    );
    // Start timer
    c.start(context);
    // Start audio

    return DisposableWidget(
      onDisposed: () => {
        c.stop(),
      },
      child: LayoutBuilder(builder: (context, contraints) {
        return Column(
          children: [
            Center(
              child: Container(
                height: 40,
                width: 80,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Center(
                  child: Obx(
                    () => Text(c.timerText.value,
                        style: body1.copyWith(color: Colors.white)),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                padding:
                    EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 10),
                child: SingleChildScrollView(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(70),
                            child: CachedNetworkImage(
                              imageUrl: _avatarUrl,
                              placeholder: (_, url) => PlacholderWidget(),
                              errorWidget: (context, url, error) =>
                                  ImageErrorWidget(),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "${tripDetail.user.firstName} ${tripDetail.user.lastName}"),
                              Row(
                                children: [
                                  Text(tripDetail.user.rating),
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    _spaceWidget,
                    Text(
                      "service_location".tr,
                      style: heading18Black,
                    ),
                    Text(
                      tripDetail.sAddress,
                      style: body1,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    _spaceWidget,
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "services".tr,
                                style: heading18Black,
                              ),
                              Text(
                                tripDetail.serviceType.name,
                                style: heading1.copyWith(
                                    fontSize: 20, color: Colors.green),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "payment_mode".tr,
                                  style: heading18Black,
                                ),
                                Text(
                                  tripDetail.paymentMode.tr,
                                  style: body1.copyWith(fontSize: 18),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    _spaceWidget,
                    Text("request_distance".tr, style: body1),
                    Text(
                      "${tripDetail.distance} Km",
                      style: body1,
                    ),
                    _spaceWidget,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: context.bloc<HomeCubit>().rejectTripRequest,
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.45,
                            height: 50,
                            child: Text(("reject").tr,
                                style: body1.copyWith(color: Colors.white)),
                            decoration: BoxDecoration(
                                color: redColor2,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        InkWell(
                          onTap: context.bloc<HomeCubit>().acceptTripRequest,
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.45,
                            height: 50,
                            child: Text(
                              "accept".tr,
                              style: body1.copyWith(color: Colors.white),
                            ),
                            decoration: BoxDecoration(
                                color: redColor2,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        )
                      ],
                    ),
                  ],
                )),
              ),
            )
          ],
        );
      }),
    );
  }
}

class CountDownTimeServiceController extends GetxController {
  var timerText = '0'.obs;
  var _second = 0;
  Timer _timer;
  AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();
  Audio audio = Audio("assets/sounds/alert_tone.mp3");

  start(BuildContext context) {
    if (_second > 0) {
      return;
    }
    _assetsAudioPlayer.open(audio);
    if (_timer == null) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        _second += 1;
        if (_second > 60) {
          context.bloc<HomeCubit>().rejectTripRequest();
        } else {
          _updateTimeText();
        }
      });
    }
  }

  _updateTimeText() {
    final dur = Duration(seconds: _second);
    timerText.value = dur.inSeconds.toString();
  }

  stop() {
    _second = 0;
    _updateTimeText();
    _assetsAudioPlayer.stop();
    _timer.cancel();
    _timer = null;
  }
}
