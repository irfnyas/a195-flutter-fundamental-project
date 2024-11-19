// Mocks generated by Mockito 5.4.4 from annotations
// in a195_flutter_fundamental_project/test/module/home/home_screen_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;
import 'dart:ui' as _i10;

import 'package:a195_flutter_fundamental_project/data/model/api_response_model.dart'
    as _i2;
import 'package:a195_flutter_fundamental_project/data/model/restaurant_model.dart'
    as _i12;
import 'package:a195_flutter_fundamental_project/data/service/api_service.dart'
    as _i5;
import 'package:a195_flutter_fundamental_project/module/notification/notification_provider.dart'
    as _i11;
import 'package:a195_flutter_fundamental_project/module/notification/notification_service.dart'
    as _i4;
import 'package:a195_flutter_fundamental_project/module/settings/settings_provider.dart'
    as _i7;
import 'package:flutter/material.dart' as _i9;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i8;
import 'package:shared_preferences/shared_preferences.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeApiResponse_0 extends _i1.SmartFake implements _i2.ApiResponse {
  _FakeApiResponse_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSharedPreferences_1 extends _i1.SmartFake
    implements _i3.SharedPreferences {
  _FakeSharedPreferences_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeNotificationService_2 extends _i1.SmartFake
    implements _i4.NotificationService {
  _FakeNotificationService_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ApiService].
///
/// See the documentation for Mockito's code generation for more information.
class MockApiService extends _i1.Mock implements _i5.ApiService {
  MockApiService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.ApiResponse> getRestaurants() => (super.noSuchMethod(
        Invocation.method(
          #getRestaurants,
          [],
        ),
        returnValue: _i6.Future<_i2.ApiResponse>.value(_FakeApiResponse_0(
          this,
          Invocation.method(
            #getRestaurants,
            [],
          ),
        )),
      ) as _i6.Future<_i2.ApiResponse>);

  @override
  _i6.Future<_i2.ApiResponse> getRestaurant(String? id) => (super.noSuchMethod(
        Invocation.method(
          #getRestaurant,
          [id],
        ),
        returnValue: _i6.Future<_i2.ApiResponse>.value(_FakeApiResponse_0(
          this,
          Invocation.method(
            #getRestaurant,
            [id],
          ),
        )),
      ) as _i6.Future<_i2.ApiResponse>);
}

/// A class which mocks [SettingsProvider].
///
/// See the documentation for Mockito's code generation for more information.
class MockSettingsProvider extends _i1.Mock implements _i7.SettingsProvider {
  MockSettingsProvider() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.SharedPreferences get prefs => (super.noSuchMethod(
        Invocation.getter(#prefs),
        returnValue: _FakeSharedPreferences_1(
          this,
          Invocation.getter(#prefs),
        ),
      ) as _i3.SharedPreferences);

  @override
  String get kPrefsIsDarkMode => (super.noSuchMethod(
        Invocation.getter(#kPrefsIsDarkMode),
        returnValue: _i8.dummyValue<String>(
          this,
          Invocation.getter(#kPrefsIsDarkMode),
        ),
      ) as String);

  @override
  String get kPrefsIsNotifEnabled => (super.noSuchMethod(
        Invocation.getter(#kPrefsIsNotifEnabled),
        returnValue: _i8.dummyValue<String>(
          this,
          Invocation.getter(#kPrefsIsNotifEnabled),
        ),
      ) as String);

  @override
  _i9.ThemeMode get themeMode => (super.noSuchMethod(
        Invocation.getter(#themeMode),
        returnValue: _i9.ThemeMode.system,
      ) as _i9.ThemeMode);

  @override
  set themeMode(_i9.ThemeMode? _themeMode) => super.noSuchMethod(
        Invocation.setter(
          #themeMode,
          _themeMode,
        ),
        returnValueForMissingStub: null,
      );

  @override
  bool get isNotifEnabled => (super.noSuchMethod(
        Invocation.getter(#isNotifEnabled),
        returnValue: false,
      ) as bool);

  @override
  set isNotifEnabled(bool? _isNotifEnabled) => super.noSuchMethod(
        Invocation.setter(
          #isNotifEnabled,
          _isNotifEnabled,
        ),
        returnValueForMissingStub: null,
      );

  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);

  @override
  _i6.Future<void> readSettingsPreferences() => (super.noSuchMethod(
        Invocation.method(
          #readSettingsPreferences,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  void switchThemeMode(_i9.BuildContext? context) => super.noSuchMethod(
        Invocation.method(
          #switchThemeMode,
          [context],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void switchNotifStatus(_i9.BuildContext? context) => super.noSuchMethod(
        Invocation.method(
          #switchNotifStatus,
          [context],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void addListener(_i10.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void removeListener(_i10.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [NotificationProvider].
///
/// See the documentation for Mockito's code generation for more information.
class MockNotificationProvider extends _i1.Mock
    implements _i11.NotificationProvider {
  MockNotificationProvider() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.NotificationService get flutterNotificationService => (super.noSuchMethod(
        Invocation.getter(#flutterNotificationService),
        returnValue: _FakeNotificationService_2(
          this,
          Invocation.getter(#flutterNotificationService),
        ),
      ) as _i4.NotificationService);

  @override
  int get notificationId => (super.noSuchMethod(
        Invocation.getter(#notificationId),
        returnValue: 0,
      ) as int);

  @override
  set notificationId(int? _notificationId) => super.noSuchMethod(
        Invocation.setter(
          #notificationId,
          _notificationId,
        ),
        returnValueForMissingStub: null,
      );

  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);

  @override
  _i6.Future<void> requestPermissions() => (super.noSuchMethod(
        Invocation.method(
          #requestPermissions,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  void showNotification(_i12.Restaurant? restaurant) => super.noSuchMethod(
        Invocation.method(
          #showNotification,
          [restaurant],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void scheduleDailyNotification() => super.noSuchMethod(
        Invocation.method(
          #scheduleDailyNotification,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i6.Future<void> checkPendingNotificationRequests() => (super.noSuchMethod(
        Invocation.method(
          #checkPendingNotificationRequests,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> cancelAllPendingNotifications() => (super.noSuchMethod(
        Invocation.method(
          #cancelAllPendingNotifications,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  void addListener(_i10.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void removeListener(_i10.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}