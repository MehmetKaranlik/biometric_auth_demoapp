import 'dart:async';

import 'package:biometric_auth_demoapp/view/home/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:local_auth/local_auth.dart';

class AuthViewModel extends GetxController {
  final AnimationController animationController;


  //constructor for getting animation controller from view
  AuthViewModel({required this.animationController});

  late final LocalAuthentication _localAuthentication;


  // error message to show on screen
  final RxString _errorMessage = 'Please scan your finger for authentication'.obs;
  String get errorMessage => _errorMessage.value;
  set errorMessage(String value) => _errorMessage.value = value;

  // countdown for lockdown duration
  final RxInt _lockDownDuration = 0.obs;
  int get lockDownDuration => _lockDownDuration.value;
  set lockDownDuration(int value) => _lockDownDuration.value = value;

  // check user is authenticated or not
  final RxBool _isAuthenticated = false.obs;
  bool get isAuthenticated => _isAuthenticated.value;
  set isAuthenticated(bool value) => _isAuthenticated.value = value;

  @override
  void onInit() {
    _localAuthentication = LocalAuthentication();
    authenticate();
    super.onInit();
  }


  // start listening for fingerprint sensor
  Future<void> authenticate() async {
    try {
      isAuthenticated = await _localAuthentication.authenticate(
        biometricOnly: true,
        localizedReason: 'Please authenticate to access your notes',
        useErrorDialogs: false,
        stickyAuth: true,
      );
      if (isAuthenticated) {
        _buildAuthenticatedFunction();
      }
    } on PlatformException catch (e) {
      _buildLockDownFunction(e);
    } 
  }

  void _buildLockDownFunction(PlatformException e) {
    if (e.code == "LockedOut") {
      lockDownDuration = 30;
      Timer.periodic(const Duration(seconds: 1), (timer) {
        lockDownDuration = lockDownDuration - 1;
        if (lockDownDuration == 2) {
          errorMessage = 'Please scan your finger for authentication';
        } else {}
        if (lockDownDuration == -1) {
          _buildCancelAndReInitFunction(timer);
        }
        errorMessage = "Too many attempts, try again $lockDownDuration later";
      });
    }
  }

  void _buildCancelAndReInitFunction(Timer timer) {
    _localAuthentication.stopAuthentication();
    timer.cancel();
    authenticate();
  }

  void _buildAuthenticatedFunction() {
    animationController.forward().whenComplete(() {
      return Get.to(() => const HomeView());
    });
  }
}
