import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:browse_in/in_app_browser.dart';

void main() {
  const MethodChannel channel = MethodChannel('in_app_browser');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await InAppWebView.platformVersion, '42');
  });
}
