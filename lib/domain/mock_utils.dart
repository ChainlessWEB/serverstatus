import 'dart:io';

import 'package:flutter/material.dart';

class MockUtils {
  static int mapServerStatus(int status) {
    if (status < 50) {
      return HttpStatus.ok;
    }
    if (status < 70) {
      return HttpStatus.unauthorized;
    }
    if (status < 90) {
      return HttpStatus.gatewayTimeout;
    }
    return HttpStatus.badGateway;
  }

  static TextStyle mapServerStatusColor(int status) {
    if (status >= 200 && status < 300) {
      return TextStyle(color: Colors.green.withOpacity(1.0));
    }
    if (status >= 300) {
      return TextStyle(color: Colors.red.withOpacity(1.0));
    }
    return TextStyle(color: Colors.black.withOpacity(1.0));
  }
}
