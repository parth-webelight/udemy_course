// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:riverpod_demo/features/auth/controller/register_controller.dart';
import 'package:riverpod_demo/routes.dart';
import '../../../color.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("RE-BUILD");
    return Scaffold(
      backgroundColor: AppColor.lightWhite,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: buildLoginForm(context),
        ),
      ),
    );
  }
}

Widget buildLoginForm(BuildContext context){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 12.h),

      Text(
        "Register",
        style: TextStyle(
          fontSize: 26.sp,
          color: AppColor.lightBlack,
          fontWeight: FontWeight.bold,
        ),
      ),

      SizedBox(height: 5.h),

      Text(
        "Your Name",
        style: TextStyle(
          fontSize: 16.sp,
          color: AppColor.lightBlack,
          fontWeight: FontWeight.w600,
        ),
      ),

      SizedBox(height: 1.h),

      Consumer(
        builder: (context, ref, _) {
          final state = ref.watch(registerProvider);
          return TextField(
            onChanged: (val) {
              ref.read(registerProvider.notifier).updateUserName(val);
            },
            cursorColor: AppColor.lightBlack,
            enabled: state.isEnable,
            decoration: InputDecoration(
              errorText: state.usernameError,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 4.w,
                vertical: 2.h,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(color: AppColor.lightGrey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(
                  color: AppColor.lightBlack,
                  width: 1.5,
                ),
              ),
              hintText: "Enter your name",
              hintStyle: TextStyle(color: Colors.grey.shade500),
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Icon(Icons.person, color: Colors.grey.shade600),
            ),
          );
        },
      ),

      SizedBox(height: 2.h),

      Text(
        "Email",
        style: TextStyle(
          fontSize: 16.sp,
          color: AppColor.lightBlack,
          fontWeight: FontWeight.w600,
        ),
      ),

      SizedBox(height: 1.h),

      Consumer(
        builder: (context, ref, _) {
          final state = ref.watch(registerProvider);
          return TextField(
            onChanged: (val) {
              ref.read(registerProvider.notifier).updateEmail(val);
            },
            cursorColor: AppColor.lightBlack,
            keyboardType: TextInputType.emailAddress,
            enabled: state.isEnable,
            decoration: InputDecoration(
              errorText: state.emailError,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 4.w,
                vertical: 2.h,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(color: AppColor.lightGrey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(
                  color: AppColor.lightBlack,
                  width: 1.5,
                ),
              ),
              hintText: "Enter your email",
              hintStyle: TextStyle(color: Colors.grey.shade500),
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Icon(
                Icons.email_outlined,
                color: Colors.grey.shade600,
              ),
            ),
          );
        },
      ),

      SizedBox(height: 2.h),

      Text(
        "Password",
        style: TextStyle(
          fontSize: 16.sp,
          color: AppColor.lightBlack,
          fontWeight: FontWeight.w600,
        ),
      ),

      SizedBox(height: 1.h),

      Consumer(
        builder: (context, ref, _) {
          final state = ref.watch(registerProvider);
          return TextField(
            onChanged: (val) {
              ref.read(registerProvider.notifier).updatePassword(val);
            },
            cursorColor: AppColor.lightBlack,
            obscureText: !state.isPasswordVisible,
            enabled: state.isEnable,
            decoration: InputDecoration(
              errorText: state.passwordError,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 4.w,
                vertical: 2.h,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(color: AppColor.lightGrey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(
                  color: AppColor.lightBlack,
                  width: 1.5,
                ),
              ),
              hintText: "Enter your password",
              hintStyle: TextStyle(color: Colors.grey.shade500),
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Icon(Icons.lock_outline, color: Colors.grey.shade600),
              suffixIcon: IconButton(
                icon: Icon(
                  state.isPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
                onPressed: () =>
                    ref.read(registerProvider.notifier).togglePassword(),
              ),
            ),
          );
        },
      ),

      SizedBox(height: 2.h),

      Text(
        "Confirm Password",
        style: TextStyle(
          fontSize: 16.sp,
          color: AppColor.lightBlack,
          fontWeight: FontWeight.w600,
        ),
      ),

      SizedBox(height: 1.h),

      Consumer(
        builder: (context, ref, _) {
          final state = ref.watch(registerProvider);
          return TextField(
            onChanged: (val) {
              ref.read(registerProvider.notifier).updateConfirmPassword(val);
            },
            cursorColor: AppColor.lightBlack,
            obscureText: !state.isConfirmPasswordVisible,
            enabled: state.isEnable,
            decoration: InputDecoration(
              errorText: state.confirmPasswordError,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 4.w,
                vertical: 2.h,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(color: AppColor.lightGrey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(
                  color: AppColor.lightBlack,
                  width: 1.5,
                ),
              ),
              hintText: "Enter your confirm password",
              hintStyle: TextStyle(color: Colors.grey.shade500),
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Icon(Icons.lock_outline, color: Colors.grey.shade600),
              suffixIcon: IconButton(
                icon: Icon(
                  state.isConfirmPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
                onPressed: () =>
                    ref.read(registerProvider.notifier).toggleConfirmPassword(),
              ),
            ),
          );
        },
      ),

      SizedBox(height: 5.h),

  SizedBox(
          width: double.infinity,
          height: 6.5.h,
          child: Consumer(
            builder: (context, ref, _) {
              final state = ref.watch(registerProvider);
              return ElevatedButton(
                onPressed: state.isLoading
                    ? null
                    : () async {
                        final success = await ref
                            .read(registerProvider.notifier)
                            .register(context);

                        if (success) {
                        } else {
                          if (state.generalError != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.generalError!)),
                            );
                          }
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.lightBlack,
                  foregroundColor: AppColor.lightWhite,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            },
          ),
        ),

      SizedBox(height: 3.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "You have an account?",
            style: TextStyle(
              fontSize: 15.sp,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 1.w),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Routes.login);
            },
            child: Text(
              "Log in",
              style: TextStyle(
                fontSize: 15.sp,
                color: AppColor.lightBlack,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 4.h),
    ],
  );
}