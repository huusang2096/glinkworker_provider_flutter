import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glinkwok_provider/src/common/config.dart';
import 'package:glinkwok_provider/src/screens/home/cubit/home_cubit.dart';
import 'package:glinkwok_provider/src/screens/home/widgets/actions_header_widget.dart';
import 'package:glinkwok_provider/src/widgets/image_error_widget.dart';
import 'package:glinkwok_provider/src/widgets/placeholder_widget.dart';
import 'package:simplest/simplest.dart';

class PannelStartService extends StatelessWidget {
  final PannelStartServiceController c =
      Get.put(PannelStartServiceController());

  @override
  Widget build(BuildContext context) {
    final bloc = context.bloc<HomeCubit>();
    final _user = bloc.state.tripResponse.requests.first.detail.user;
    final _avatarUrl = IMG_URL + (_user.picture ?? '');
    int time = bloc.state.waitingTimeResponse == null
        ? 0
        : bloc.state.waitingTimeResponse.waitingTime;
    c.start(time);
    return DisposableWidget(
        onDisposed: () => c.stop(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ActionHeaderWidget(),
            Expanded(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 70,
                                height: 70,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(70),
                                  child: CachedNetworkImage(
                                    imageUrl: _avatarUrl,
                                    placeholder: (context, url) =>
                                        PlacholderWidget(),
                                    errorWidget: (context, url, error) =>
                                        ImageErrorWidget(),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        '${_user.firstName} ${_user.lastName}'),
                                    Row(
                                      children: [
                                        Text(_user.rating),
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
                        ),
                        Container(
                          width: 1,
                          height: 60,
                          color: Colors.black,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Obx(() => Text(
                                  c.timerText.value,
                                  style: body1.copyWith(fontSize: 25),
                                )),
                          ),
                        )
                      ],
                    ),
                    InkWell(
                      onTap: () => bloc.serviceDone(),
                      child: Container(
                        height: 50,
                        margin: const EdgeInsets.symmetric(horizontal: 26),
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: redColor2,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text("service_done".tr,
                            style: body1.copyWith(color: Colors.white)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

class PannelStartServiceController extends GetxController {
  var timerText = '00:00:00'.obs;
  var _second = 0;
  Timer _timer;
  start(int time) {
    if (_second > 0) {
      return;
    }
    if (time > 0) {
      _second = time;
    }
    if (_timer == null) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        _second += 1;
        _updateTimeText();
      });
    }
  }

  _updateTimeText() {
    final dur = Duration(seconds: _second);
    timerText.value = dur.format();
  }

  stop() {
    _second = 0;
    _updateTimeText();
    _timer.cancel();
    _timer = null;
    print("STOPTIMER-------------------------------------");
  }
}

extension on Duration {
  String format() => '$this'.split('.')[0].padLeft(8, '0');
}
