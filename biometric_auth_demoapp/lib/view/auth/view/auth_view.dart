import 'package:biometric_auth_demoapp/core/constants/assets/animation_constants.dart';
import 'package:biometric_auth_demoapp/view/auth/view_model/auth_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class AuthView extends StatefulWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> with TickerProviderStateMixin {
  late final AnimationController animationController;
  late final AuthViewModel _viewModel;
  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _viewModel = Get.put(AuthViewModel(animationController: animationController));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  SafeArea _buildBody() {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildStatusMessage(),
          _buildFingerPrintAnimation(),
        ],
      ),
    );
  }

  LottieBuilder _buildFingerPrintAnimation() {
    return LottieBuilder.asset(
      AnimationConstants.instance.bioAuthSuccess,
      controller: _viewModel.animationController,
    );
  }

  Row _buildStatusMessage() {
    return Row(
      children: [
        const Spacer(),
        Obx(() => Text(_viewModel.errorMessage)),
        const Spacer(),
      ],
    );
  }
}
