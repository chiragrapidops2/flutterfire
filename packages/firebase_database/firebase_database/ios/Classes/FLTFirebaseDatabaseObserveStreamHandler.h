// Copyright 2021 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
@import FirebaseDatabase;
#import <TargetConditionals.h>

#if TARGET_OS_OSX
#import <FlutterMacOS/FlutterMacOS.h>
#else
#import <Flutter/Flutter.h>
#endif

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FLTFirebaseDatabaseObserveStreamHandler : NSObject <FlutterStreamHandler>
- (instancetype)initWithFIRDatabaseQuery:(FIRDatabaseQuery *)databaseQuery
                       andOnDisposeBlock:(void (^)(void))disposeBlock;
@end

NS_ASSUME_NONNULL_END
