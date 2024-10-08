// Copyright 2024, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('emptySerializer', () {
    test('should return an empty string when null is passed', () {
      final result = emptySerializer(null);
      expect(result, '');
    });

    test('should return an empty string when any value is passed', () {
      final resultWithVoid = emptySerializer(null); // void type simulation
      final resultWithInt = emptySerializer(42);
      final resultWithString = emptySerializer('Some String');
      final resultWithList = emptySerializer([1, 2, 3]);

      expect(resultWithVoid, '');
      expect(resultWithInt, '');
      expect(resultWithString, '');
      expect(resultWithList, '');
    });
  });
}
