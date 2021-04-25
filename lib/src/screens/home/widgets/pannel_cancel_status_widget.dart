import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glinkwok_provider/src/common/config.dart';
import 'package:glinkwok_provider/src/model/cancel_reason_response.dart';
import 'package:glinkwok_provider/src/screens/home/cubit/home_cubit.dart';
import 'package:simplest/simplest.dart';

class PannelCancelStatusWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PannelCancelStatusWidget();
}

class _PannelCancelStatusWidget extends State<PannelCancelStatusWidget> {
  final _formKey = new GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final List<CancelReasonResponse> cancelReason =
        context.watch<HomeCubit>().state.cancelReason;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListView.builder(
                padding: EdgeInsets.all(5),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: cancelReason.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      context.read<HomeCubit>().selectCancelReason(index);
                    },
                    title: Text(
                      "${cancelReason[index].reason}",
                      style: body1,
                    ),
                    leading:
                        context.read<HomeCubit>().state.selectedCancelReason ==
                                index
                            ? Icon(
                                Icons.check_circle,
                                color: Colors.black,
                              )
                            : Icon(
                                Icons.check_circle,
                                color: Colors.grey,
                              ),
                  );
                }),
/*
            Form(
              key: _formKey,
              child: TextFormField(
                enabled:
                    context.watch<HomeCubit>().state.selectedCancelReason == 3
                        ? true
                        : false,
                controller: controller,
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return 'cancellation_reason_must_not_be_blank_and_at_least_characters'
                        .tr;
                  }
                  if (value.length > 255) {
                    return 'cancellation_reason_must_not_be_blank_and_at_least_characters'
                        .tr;
                  }
                  return null;
                },
                autocorrect: false,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'write_your_reason'.tr,
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14.0),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide:
                          BorderSide(color: Colors.black.withOpacity(0.8))),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.redAccent)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide:
                          BorderSide(color: Colors.grey.withOpacity(0.6))),
                ),
              ),
            ),
*/
            Divider(),
            context.watch<HomeCubit>().state.isShowLoading
                ? SpinKitCircle(
                    color: primaryColor,
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        buildRaisedButton(
                            onPress: () => Navigator.of(context).pop(),
                            text: 'dismiss'.tr,
                            colorButton: Colors.black,
                            colorText: Colors.white),
                        buildRaisedButton(
                            text: 'submit'.tr,
                            onPress: () {
                              int index = context
                                  .read<HomeCubit>()
                                  .state
                                  .selectedCancelReason;
                              context
                                  .read<HomeCubit>()
                                  .cancelTrip(cancelReason[index].reason);
                            }),
                      ])
          ],
        ),
      ),
    );
  }

  buildRaisedButton(
      {String text, Function onPress, Color colorButton, Color colorText}) {
    TextStyle textStyle = body1.copyWith(color: Colors.white);
    if (colorButton == null) {
      colorButton = Color(0xffF34E3F);
    }
    if (colorText != null) {
      textStyle.copyWith(color: colorText);
    }
    return InkWell(
        onTap: onPress,
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.45,
          height: 50,
          child: Text(text.tr, style: body1.copyWith(color: Colors.white)),
          decoration: BoxDecoration(
              color: colorButton, borderRadius: BorderRadius.circular(10)),
        ));
  }
}
