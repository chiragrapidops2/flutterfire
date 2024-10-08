// Copyright 2024, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of firebase_data_connect_transport;

/// Default TransportStub to satisfy compilation of the library.
class TransportStub implements DataConnectTransport {
  /// Constructor.
  TransportStub(
    this.transportOptions,
    this.options,
    this.appId,
    this.sdkType,
    this.auth,
    this.appCheck,
  );

  /// FirebaseAuth
  @override
  FirebaseAuth? auth;

  /// FirebaseAppCheck
  @override
  FirebaseAppCheck? appCheck;

  /// DataConnect backend options.
  @override
  DataConnectOptions options;

  /// Network configuration options.
  @override
  TransportOptions transportOptions;

  /// Core or Generated SDK being used.
  @override
  CallerSDKType sdkType;

  @override
  String appId;

  /// Stub for invoking a mutation.
  @override
  Future<Data> invokeMutation<Data, Variables>(
      String queryName,
      Deserializer<Data> deserializer,
      Serializer<Variables>? serializer,
      Variables? vars) async {
    // TODO: implement invokeMutation
    throw UnimplementedError();
  }

  /// Stub for invoking a query.
  @override
  Future<Data> invokeQuery<Data, Variables>(
      String queryName,
      Deserializer<Data> deserializer,
      Serializer<Variables>? serialize,
      Variables? vars) async {
    // TODO: implement invokeQuery
    throw UnimplementedError();
  }
}

DataConnectTransport getTransport(
  TransportOptions transportOptions,
  DataConnectOptions options,
  String appId,
  CallerSDKType sdkType,
  FirebaseAuth? auth,
  FirebaseAppCheck? appCheck,
) =>
    TransportStub(transportOptions, options, appId, sdkType, auth, appCheck);
