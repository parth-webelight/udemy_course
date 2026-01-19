import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../color.dart';

class CustomLoaderDialog extends StatelessWidget {
  const CustomLoaderDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 6.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LoadingAnimationWidget.fallingDot(
              color: AppColor.lightBlack,
              size: 12.w,
            ),
            SizedBox(height: 2.h),
            Text(
              'Wait a moment...',
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.w600,
                color: AppColor.lightBlack,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
