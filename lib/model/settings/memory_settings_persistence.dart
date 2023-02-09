import 'settings_persistence.dart';

/// An in-memory implementation of [SettingsPersistence].
/// Useful for testing.
class MemoryOnlySettingsPersistence implements SettingsPersistence {
  bool musicOn = true;

  bool soundsOn = true;

  bool muted = false;

  String playerName = 'Player';

  String frequency = 'Alle Wörter';

  @override
  Future<bool> getMusicOn() async => musicOn;

  @override
  Future<bool> getMuted({required bool defaultValue}) async => muted;

  @override
  Future<String> getPlayerName() async => playerName;

  @override
  Future<bool> getSoundsOn() async => soundsOn;

  @override
  Future<String> getFrequency() async => frequency;

  @override
  Future<String> getSchwierigkeit() async => frequency;


  @override
  Future<void> saveMusicOn(bool value) async => musicOn = value;

  @override
  Future<void> saveMuted(bool value) async => muted = value;

  @override
  Future<void> savePlayerName(String value) async => playerName = value;

  @override
  Future<void> saveSoundsOn(bool value) async => soundsOn = value;

  @override
  Future<void> saveFrequency(String value) async => frequency = value;

  @override
  Future<void> saveSchwierigkeit(String value) async => frequency = value;
}
