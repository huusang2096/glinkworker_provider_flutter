import 'package:flutter/material.dart';
import 'package:glinkwok_provider/src/common/config.dart';
import 'package:glinkwok_provider/src/screens/home/cubit/home_cubit.dart';
import 'package:simplest/simplest.dart';

class ActionHeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76,
      width: 180,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () => context.read<HomeCubit>().onSelectSOS(),
            child: Container(
              width: 60,
              height: 60,
              alignment: Alignment.center,
              child: Text(
                "SOS",
                style: TextStyle(color: Colors.white),
              ),
              decoration: BoxDecoration(
                  color: redColor2, borderRadius: BorderRadius.circular(60)),
            ),
          ),
          InkWell(
            onTap: () => context.read<HomeCubit>().onSelectCalling(),
            child: Container(
              width: 40,
              height: 40,
              child: Icon(
                Icons.phone,
                color: Colors.white,
              ),
              decoration: BoxDecoration(
                  color: redColor2, borderRadius: BorderRadius.circular(40)),
            ),
          ),
          InkWell(
            onTap: () => context.read<HomeCubit>().onSelectChat(),
            child: Container(
              width: 40,
              height: 40,
              child: Icon(
                Icons.chat,
                color: Colors.white,
              ),
              decoration: BoxDecoration(
                  color: redColor2, borderRadius: BorderRadius.circular(40)),
            ),
          ),
        ],
      ),
    );
  }
}
