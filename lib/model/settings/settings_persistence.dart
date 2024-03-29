/// An interface of persistence stores for settings.
///
/// Implementations can range from simple in-memory storage through
/// local preferences to cloud-based solutions.
abstract class SettingsPersistence {
  Future<bool> getMusicOn();
  Future<bool> getMuted({required bool defaultValue});
  Future<String> getPlayerName();
  Future<bool> getSoundsOn();
  Future<String> getFrequency();
  Future<String> getSchwierigkeit();

  Future<void> saveMusicOn(bool value);
  Future<void> saveMuted(bool value);
  Future<void> savePlayerName(String value);
  Future<void> saveFrequency(String value);
  Future<void> saveSchwierigkeit(String value);
  Future<void> saveSoundsOn(bool value);

}
