import 'package:flutter_test/flutter_test.dart';

import 'package:kollab_auth/kollab_auth.dart';

void main() {
  test('constructs WelcomeWidget', () {
    final widget = WelcomeWidget();
    expect(widget.heroText, 'Build more with Bitmio.');
  });
}
