// Copyright 2024, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:firebase_data_connect/src/common/common_library.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// Mock classes for Firebase dependencies
class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirebaseAppCheck extends Mock implements FirebaseAppCheck {}

void main() {
  group('GoogApiClient', () {
    test('should return no codegen suffix if using core sdk', () {
      final packageVersion = "1.0.0";
      expect(getGoogApiVal(CallerSDKType.core, packageVersion),
          'gl-dart/$packageVersion fire/$packageVersion');
    });
    test('should return codegen suffix if using gen sdk', () {
      final packageVersion = "1.0.0";
      expect(getGoogApiVal(CallerSDKType.generated, packageVersion),
          'gl-dart/$packageVersion fire/$packageVersion dart/gen');
    });
  });
  group('TransportOptions', () {
    test('should properly initialize with given parameters', () {
      final transportOptions = TransportOptions('localhost', 8080, true);

      expect(transportOptions.host, 'localhost');
      expect(transportOptions.port, 8080);
      expect(transportOptions.isSecure, true);
    });

    test('should allow null values for optional parameters', () {
      final transportOptions = TransportOptions('localhost', null, null);

      expect(transportOptions.host, 'localhost');
      expect(transportOptions.port, null);
      expect(transportOptions.isSecure, null);
    });

    test('should update properties correctly', () {
      final transportOptions = TransportOptions('localhost', 8080, true);

      transportOptions.host = 'newhost';
      transportOptions.port = 9090;
      transportOptions.isSecure = false;

      expect(transportOptions.host, 'newhost');
      expect(transportOptions.port, 9090);
      expect(transportOptions.isSecure, false);
    });
  });

  group('DataConnectTransport', () {
    late DataConnectTransport transport;
    late TransportOptions transportOptions;
    late DataConnectOptions dataConnectOptions;
    late MockFirebaseAuth mockFirebaseAuth;
    late MockFirebaseAppCheck mockFirebaseAppCheck;

    setUp(() {
      transportOptions = TransportOptions('localhost', 8080, true);
      dataConnectOptions = DataConnectOptions(
        'projectId',
        'location',
        'connector',
        'serviceId',
      );
      mockFirebaseAuth = MockFirebaseAuth();
      mockFirebaseAppCheck = MockFirebaseAppCheck();

      transport = TestDataConnectTransport(
        transportOptions,
        dataConnectOptions,
        'testAppId',
        CallerSDKType.core,
        auth: mockFirebaseAuth,
        appCheck: mockFirebaseAppCheck,
      );
    });

    test('should properly initialize with given parameters', () {
      expect(transport.transportOptions.host, 'localhost');
      expect(transport.transportOptions.port, 8080);
      expect(transport.transportOptions.isSecure, true);
    });

    test('should handle invokeQuery with proper deserializer', () async {
      final queryName = 'testQuery';
      final deserializer = (json) => json;
      final result = await transport.invokeQuery(
          queryName, deserializer, emptySerializer, null);

      expect(result, isNotNull);
    });

    test('should handle invokeMutation with proper deserializer', () async {
      final queryName = 'testMutation';
      final deserializer = (json) => json;
      final result = await transport.invokeMutation(
          queryName, deserializer, emptySerializer, null);

      expect(result, isNotNull);
    });
  });
}

// Test class extending DataConnectTransport for testing purposes
class TestDataConnectTransport extends DataConnectTransport {
  TestDataConnectTransport(TransportOptions transportOptions,
      DataConnectOptions options, String appId, CallerSDKType sdkType,
      {FirebaseAuth? auth, FirebaseAppCheck? appCheck})
      : super(transportOptions, options, appId, sdkType) {
    this.auth = auth;
    this.appCheck = appCheck;
  }

  @override
  Future<Data> invokeQuery<Data, Variables>(
    String queryName,
    Deserializer<Data> deserializer,
    Serializer<Variables>? serializer,
    Variables? vars,
  ) async {
    // Simulate query invocation logic here
    return deserializer('{}');
  }

  @override
  Future<Data> invokeMutation<Data, Variables>(
    String queryName,
    Deserializer<Data> deserializer,
    Serializer<Variables>? serializer,
    Variables? vars,
  ) async {
    // Simulate mutation invocation logic here
    return deserializer('{}');
  }
}
