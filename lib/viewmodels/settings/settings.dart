// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:wortschatz/model/settings/settings_persistence.dart';

/// An class that holds settings like [playerName] or [musicOn],
/// and saves them to an injected persistence store.
class SettingsController {
  final SettingsPersistence _persistence;

  ValueNotifier<bool> muted = ValueNotifier(false);

  ValueNotifier<String> playerName = ValueNotifier('Player');

  ValueNotifier<bool> soundsOn = ValueNotifier(false);

  ValueNotifier<bool> musicOn = ValueNotifier(false);

  ValueNotifier<String> frequency = ValueNotifier('Alle Wörter');

  ValueNotifier<String> schwierigkeit = ValueNotifier('Leicht');

  /// Creates a new instance of [SettingsController] backed by [persistence].
  SettingsController({required SettingsPersistence persistence})
      : _persistence = persistence;

  /// Asynchronously loads values from the injected persistence store.
  Future<void> loadStateFromPersistence() async {
    await Future.wait([
      _persistence
          .getMuted(defaultValue: kIsWeb)
          .then((value) => muted.value = value),
      _persistence.getSoundsOn().then((value) => soundsOn.value = value),
      _persistence.getMusicOn().then((value) => musicOn.value = value),
      _persistence.getPlayerName().then((value) => playerName.value = value),
      _persistence.getFrequency().then((value) => frequency.value = value),
      _persistence.getSchwierigkeit().then((value) => schwierigkeit.value = value),
    ]);
  }

  void setFrequency(String name) {
    frequency.value = name;
    _persistence.saveFrequency(frequency.value);
  }

  void setSchwierigkeit(String name) {
    schwierigkeit.value = name;
    _persistence.saveSchwierigkeit(schwierigkeit.value);
  }

  void setPlayerName(String name) {
    playerName.value = name;
    _persistence.savePlayerName(playerName.value);
  }

  void toggleMusicOn() {
    musicOn.value = !musicOn.value;
    _persistence.saveMusicOn(musicOn.value);
  }

  void toggleMuted() {
    muted.value = !muted.value;
    _persistence.saveMuted(muted.value);
  }

  void toggleSoundsOn() {
    soundsOn.value = !soundsOn.value;
    _persistence.saveSoundsOn(soundsOn.value);
  }
}
