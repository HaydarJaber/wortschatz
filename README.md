<h1 align="center">Wortschatz-App</h1>
<p align="center">
  <img width="200" height="200" src="https://user-images.githubusercontent.com/37445336/235227809-ae40c0b4-a457-4183-aff4-4c70e857a923.gif">
</p>

## Beteiligte Labore
<p align="center">
  <a target="_blank" href="https://rchst.de/en/"><img width="500" height="150" src="https://user-images.githubusercontent.com/37445336/235238270-a98ce06f-c806-4aec-b557-a34d21146239.png" /></a>
  <a target="_blank" href="https://ehealth.rcbe.de/"><img width="500" height="150" src="https://user-images.githubusercontent.com/37445336/235239104-2f23caf0-cc65-4b82-bd1e-d464a368b878.png" /></a>
</p>

## Teammitglieder
Haydar Hamed-Jaber


## Beschreibung

<img align="left" width="300" height="500" src="https://user-images.githubusercontent.com/37445336/235228889-328f03dc-40da-4f97-bd61-32da1120af14.png" > Die <strong>Wortschatz-App</strong> ist ein Serious Game, das Menschen mit Aphasie als ergänzendes Training zu herkömmlichen Therapiesitzungen dient.

- <strong>Serious Game?..</strong> Bei einem Serious Game handelt es sich um ein Spiel, das nicht zur reinen Unterhaltung entwickelt wurde, sondern mit dem Ziel, bestimmte Inhalte zu vermitteln.
- <strong>Aphasie?..</strong> Aphasie ist eine erworbene Sprachstörung, die nach einer Hirnschädigung auftreten kann (z.B nach einem Schlaganfall). Betroffene haben Schwierigkeiten, Sprache zu produzieren, zu verstehen, zu lesen oder zu schreiben.

<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>

## Motivation & Ziel 

Mit der klassischen Sprachtherapie allein kann die für einen positiven Therapieerfolg notwendige Therapieintensität nicht erreicht werden. Um dieser Problematik entgegenzuwirken, wurde die App konzipiert und realisiert. Ziel ist es, den
Betroffenen ein individuelles Wortfindungstraining zu ermöglichen und damit die Therapieintensität zu steigern. Entscheidend für den Einsatz der App ist die Akzeptanz durch die Betroffenen. Sie entscheiden letztendlich, ob die App genutzt wird oder nicht. 
Bei der Umsetzung der App wurde besonders darauf geachtet, Frustrationen zu vermeiden und Motivationsmechanismen zu schaffen.

<br/>

## Das Spiel
<p align="center">
  <img width="300" height="500" src="https://user-images.githubusercontent.com/37445336/235264351-6f025296-5752-4617-a656-175396a702b6.png" /></a>
  <img width="300" height="500" src="https://user-images.githubusercontent.com/37445336/235265495-caf2828e-4547-4386-8f73-d9cd075b0da4.png" /></a>
</p>
<p align="center">
  <img width="300" height="500" src="https://user-images.githubusercontent.com/37445336/235265539-079e71fd-9be1-4f97-a022-e4d760fe6d31.png" /></a>
  <img width="300" height="500" src="https://user-images.githubusercontent.com/37445336/235268082-9c470433-8e9f-440a-8696-b507329014ea.png" /></a>
</p>


Die App basiert auf dem Spielprinzip des Galgenmännchens. Zum Start des Spiels muss zunächst eine Wortkategorie ausgewählt werden, die trainiert/gespielt werden soll.
Menschen mit einer Aphasie sollen durch die Eingabe der richtigen Buchstaben ein Wort erraten und auf diese Weise das Wort über einen längeren Zeitraum hinweg trainieren.
Nach jedem gespielten Wort wird den Spielenden ein sofortiges Feedback in Form eines Bildes und der schriftlichen Benennung des gesuchten Wortes gegeben. 
Sind alle Wörter einer Wortkategorie und damit das Spiel durchgespielt, erscheint eine Spielübersicht. Hier werden die gefundenen und die nicht gefundenen Wörter noch einmal angezeigt.
Als Grundlage wurde ein vorhandenes Mockup, welches von einer Absolventin des Bachelor-Studiengangs Logopädie an der Hochschule Fresenius entworfen wurde, herangezogen.

<br/>

Eine vollständige und ausführliche Spielanleitung kann hier eingesehen werden: <a href="https://gitlab.oth-regensburg.de/RCHST/EHEALTH/abschlussarbeiten/ma_hamed/-/blob/master/assets/Spieler_Anleitung.pdf"><strong>Spielanleitung</strong></a>

## Zusätzliche Features der App

<p align="center">
  <img width="300" height="500" src="https://user-images.githubusercontent.com/37445336/235269459-379007d4-cb7e-4e88-8f76-7047b058c53f.png" /></a>
  <img width="300" height="500" src="https://user-images.githubusercontent.com/37445336/235269486-c6a6c363-94ad-41dc-8648-ff2ba89964fe.png" /></a>
</p>
<p align="center">
  <img width="300" height="500" src="https://user-images.githubusercontent.com/37445336/235269504-51a5b21d-fbdc-4882-abba-ecb1bf32b715.png" /></a>
  <img width="300" height="500" src="https://user-images.githubusercontent.com/37445336/235269523-21b523e0-03cc-4c5c-bdca-a49f85ba4b28.png" /></a>
</p>

Im Spiel stehen den Spielern für jedes Wort bis zu vier Tipps zur Verfügung. Zusätzlich können Spieler und Therapeuten den Fortschritt der gespielten Wortkategorien einsehen.
Die Wortkategorien werden im Fortschritt hervorgehoben, sobald sie einmal gewonnen wurden. Außerdem kann der Schwierigkeitsgrad des Spiels in den Einstellungen für zukünftige Spiele festgelegt werden.

## Technische Merkmale

Zielplattform: iOS, Android 
<br/>
verwendete Entwicklungsumgebung:  [Android Studio Electric Eel | 2022.1.1 Patch 1](https://developer.android.com/studio/releases/past-releases/as-electric-eel-release-notes#android-studio-electric-eel-|-2022.1.1-patch-1-february-2023) 
<br/>
Programmiersprache: [Flutter 3.7.0 (Dart)](https://docs.flutter.dev/release/archive)
<br/>
Desgin Pattern: Model-View-ViewModel
<br/>
Datenhaltung: [Hive](https://pub.dev/packages/hive)
<br/>
Packagerepository: [pub.dev](https://pub.dev/)

## Getting Started
Die folgenden Schritte sind erforderlich, um das Repository lokal zum Laufen zu bringen:

### Vorbedingungen
1. [Android Studio](https://developer.android.com/studio) (empfohlen) oder Visual Studio muss installiert sein. 
2. [Flutter Version 3.7.0](https://flutter.dev/) oder höher muss installiert werden. (Hinweis: Dart SDK ist in der Flutter Installation enthalten und muss nicht sperat installiert werden.)

Für Mac: Zusätzlich noch [Xcode](https://developer.apple.com/xcode/) installieren. Wird benötigt um die App auf einen iOS Emulator zu kompilieren.

### Installation
1. Repository clonen
git clone https://gitlab.oth-regensburg.de/RCHST/EHEALTH/abschlussarbeiten/ma_hamed.git
2. Packages importieren 
> pubspec.yaml öffnen, dann auf "Pub get" klicken (empfohlen) oder 'flutter pub get' im Terminal 
3. Emulator Starten
> Device Manager öffnen, dann einen gewünschten Emualtor starten.
> Dann in der main.dart die Funktion Future<void> main() async{} starten (via grünen Start-Icon)


## Wie kann man...

### ...neue Wörter hinzufügen?
Im [Model der App](https://gitlab.oth-regensburg.de/RCHST/EHEALTH/abschlussarbeiten/ma_hamed/-/tree/master/lib/model/words), sind die verwendeten Wörter zu finden. 
> Ein Wort muss zugeordnet werden: Die Wortfrequenz (hochfrequent oder niederfrequent), 4 Hilfestellungen und die entsprechende Wortkategorie 
Je nach Wortfrequenz des neuen Wortes, muss die entsprechende Datei ('hf_words.dart' oder 'nf_words.dart') ausgewählt werden. 
Darin kann unter der entsprechenden Wortkategorie das Wort samt den vier Hilfen hinzugefügt werden.
Zusätzlich muss das Wort in 'all_words.dart' angefügt werden, um für alle Frequenzen zur Verfügung zu stehen.

### ...neue Wortkategorien hinzufügen?
In allen drei genannten Datein ('all_words.dart','hf_words.dart','nf_words.dart') muss eine Map für die Wortkategorie erstellt werden.
Darin werden die einzelnen Wörter angelegt.

### ...ein Bild für ein Wort ändern oder für ein neues Wort hinzufügen?
Die Bilder sind in den [assets](https://gitlab.oth-regensburg.de/RCHST/EHEALTH/abschlussarbeiten/ma_hamed/-/tree/master/assets/images/W%C3%B6rter) gespeichert. 
Damit die Bilder von der App wahrgenommen werden, müssen diese in der [pubspec.yaml](https://gitlab.oth-regensburg.de/RCHST/EHEALTH/abschlussarbeiten/ma_hamed/-/blob/master/pubspec.yaml) hintergelegt werden.

Unter der entsprechende Wortkategorie (markiert als Kommentar) sind die einzelnen Pfade der Bilder gespeichert.
Es ist zu beachten, dass die Bilder unter den selben Namen gespeichert werden müssen wie die Wörter. Da sonst eine zuordnung zwischen Wort und Bild fehlschlägt.

## Lizenz
MIT License

Copyright (c) 2023 Haydar Hamed-Jaber

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.




