List hfall = [
'Sitz','Dach','Motor','Rad', 'Achse', 'Batterie', 'Reifen', 'Scheinwerfer', 'Lenkrad', 'Kupplung', 'Zündung', 'Kofferraum', 'Rückspiegel', 'Handbremse', 'Felge',
'Spiegel','Kalk','Seife','Toilette','Handtuch','Badewanne','Waschbecken','Schminke','Dusche','Creme','Fön','Zahnbürste','Wasserhahn','Waschlappen','Zahnpasta',
'Hund', 'Milch','Pferd','Bauer','Eier','Hahn','Wiese','Katze','Getreide','Stall','Käse','Futter','Schwein','Zaun','Kuh',
'Arzt', 'Lehrer', 'Maler', 'Politker', 'Sekretär', 'Schauspieler', 'Sänger', 'Koch', 'Anwalt', 'Erzieher', 'Gärtner', 'Dolmetscher', 'Polizist', 'Bäcker', 'Friseur',
'Berlin', 'München', 'Leipzig', 'Hamburg', 'Essen','Dresden','Frankfurt am Main','Köln','Stuttgart','Hannover','Düsseldorf','Bremen','Potsdam','Weimar','Münster',
'Zug', 'Schiff', 'Auto', 'Panzer', 'Straßenbahn', 'Fahrrad','Bus','Taxi','Motorrad','Lastkraftwagen','Fähre','UBahn','Transporter','Bagger','Limousine',
'Bank', 'Mauer', 'Baum', 'Gemüse', 'Blume', 'Zaun', 'Topf', 'Schuppen', 'Laub', 'Rasen', 'Unkraut', 'Kräuter', 'Spaten', 'Schere', 'Handschuh',
'Salat', 'Mais', 'Zwiebel', 'Linse', 'Kartoffel', 'Paprika', 'Pilz', 'Blumenkohl', 'Spinat', 'Spargel', 'Knoblauch', 'Gurke', 'Sellerie', 'Tomate', 'Bohne',
'Wasser', 'Kaffee', 'Milch', 'Bier', 'Tee', 'Sekt', 'Rotwein', 'Rum', 'Kakao', 'Champagner', 'Weißwein', 'Likör', 'Limonade', 'Nektar', 'Cola',
'Berlin','Paris', 'Wien', 'London', 'Rom', 'Moskau', 'Prag', 'Washington', 'Athen', 'Brüssel', 'Madrid', 'Budapest', 'Peking', 'Stockholm', 'Kopenhagen',
'Farbe', 'Holz', 'Ingenieur', 'Hammer', 'Architekt', 'Rohr', 'Lastwagen', 'Maurer', 'Helm', 'Beton', 'Gerüst', 'Besen', 'Schutt', 'Tapete', 'Zement',
'Musik', 'Theater', 'Garten', 'Schreiben', 'Reisen', 'Museum', 'Tanz', 'Sport', 'Gesang', 'Fernsehen', 'Computer', 'Lesen', 'Kino', 'Spielen', 'Schwimmen',
'Hut', 'Rock','Kleid','Tuch','Hemd','Anzug','Mütze','Stiefel','Hose','Jacke','Gürtel','Schuh','Bluse','Weste','Handschuh',
'Hand', 'Auge', 'Kopf', 'Herz', 'Mund', 'Arm', 'Rücken', 'Brust', 'Haut', 'Fuß', 'Finger', 'Nase', 'Stirn', 'Hals', 'Ohr',
'Glas','Messer','Teller','Tasse','Gabel','Löffel','Herd','Topf','Schüssel','Pfanne','Kühlschrank','Sieb','Schwamm','Backofen','Wasserhahn',
'Deutschland','Frankreich', 'USA','England','Italien','Polen','Österreich','China','Japan','Schweiz','Schweden','Türkei','Griechenland','Dänemark','Niederlande'
'Tisch','Bett','Spiegel','Stuhl','Schreibtisch','Sessel','Lampe','Schrank','Sofa','Garderobe','Schemel','Regal','Kommode','Truhe','Nachttisch',
'Klavier','Orgel','Trommel','Becken','Geige','Bass','Trompete','Schlagzeug','Gitarre','Harfe','Mundharmonika','Pauke','Posaune','Klarinette','Cello',
'Apfel','Zitrone','Orange','Birne','Ananas','Traube','Banane','Kirsche','Pfirsich','Melone','Feige','Mandarine','Erdbeere','Quitte','Aprikose'
'Buche','Rose','Klee','Kiefer','Petersilie','Linde','Eiche','Veilchen','Palme','Lorbeer','Flieder','Birke','Efeu','Hanf','Tanne'
'Geld','Musik','Tisch','Preis','Glas','Rechnung','Küche','Gast','Tafel','Messer','Teller','Kellner','Wirt','Speisen','Koch'
'Fußball','Tanzen','Schwimmen','Gymnastik','Reiten','Turnen','Tennis','Boxen','Rudern','Leichtathletik','Klettern','Fechten','Yoga','Tauchen','Tischtennis'
'Polizei','Auto', 'Kurve','Straßenbahn','Fahrrad','Baustelle','Feuerwehr','Kreuzung','Autobahn','Bus', 'Taxi','Fahrbahn', 'Fußgänger','Motorrad','Asphalt'
'Wein', 'Kaffee', 'Milch', 'Bier', 'Zeitschrift', 'Tee', 'Ei', 'Eis', 'Blume', 'Käse', 'Reis', 'Schokolade', 'Salat', 'Saft', 'Apfel'
'Hund', 'Pferd', 'Vogel', 'Fisch', 'Wolf', 'Katze', 'Fuchs', 'Schwein', 'Esel', 'Kuh', 'Tiger', 'Maus', 'Bär', 'Löwe', 'Huhn'
'Leiter', 'Hammer', 'Haken', 'Nagel', 'Pinsel', 'Seil', 'Bit', 'Besen', 'Schere', 'Zange', 'Schraube', 'Mzahnpastaeißel', 'Pinzette', 'Feile', 'Schraubenschlüssel'
];

List hfAutoteile = [
'Sitz','Dach','Motor','Rad','Achse', 'Batterie', 'Reifen', 'Scheinwerfer', 'Lenkrad', 'Kupplung', 'Zündung', 'Kofferraum', 'Rückspiegel', 'Handbremse', 'Felge'
];

List hfBadezimmer = [
'Spiegel','Kalk','Seife','Toilette','Handtuch','Badewanne','Waschbecken','Schminke','Dusche','Creme','Fön','Zahnbürste','Wasserhahn','Waschlappen','Zahnpasta',
];

List hfBauernhof = [
'Hund', 'Milch','Pferd','Bauer','Eier','Hahn','Wiese','Katze','Getreide','Stall','Käse','Futter','Schwein','Zaun','Kuh',
];

List hfBerufe = [
'Arzt', 'Lehrer', 'Maler', 'Politiker', 'Sekretär', 'Schauspieler', 'Sänger', 'Koch', 'Anwalt', 'Erzieher', 'Gärtner', 'Dolmetscher', 'Polizist', 'Bäcker', 'Friseur'
];

List hfDeutscheStaedte = [
'Berlin', 'München', 'Leipzig', 'Hamburg', 'Essen','Dresden','Frankfurt am Main','Köln','Stuttgart','Hannover','Düsseldorf','Bremen','Potsdam','Weimar','Münster',
];

List hfFahrzeuge = [
'Zug', 'Schiff', 'Auto', 'Panzer', 'Straßenbahn', 'Fahrrad','Bus','Taxi','Motorrad','Lastkraftwagen','Fähre','UBahn','Transporter','Bagger','Limousine',
];

List hfGarten = [
'Bank', 'Mauer', 'Baum', 'Gemüse', 'Blume', 'Zaun', 'Blumentopf', 'Schuppen', 'Laub', 'Rasen', 'Unkraut', 'Kräuter', 'Spaten', 'Schere', 'Handschuh',
];

List hfGemuese = [
'Salat', 'Mais', 'Zwiebel', 'Linse', 'Kartoffel', 'Paprika', 'Pilz', 'Blumenkohl', 'Spinat', 'Spargel', 'Knoblauch', 'Gurke', 'Sellerie', 'Tomate', 'Bohne',
];

List hfGetraenke = [
'Wasser', 'Kaffee', 'Milch', 'Bier', 'Tee', 'Sekt', 'Rotwein', 'Rum', 'Kakao', 'Champagner', 'Weißwein', 'Likör', 'Limonade', 'Nektar', 'Cola',
];

List hfHauptstaedte = [
'Berlin','Paris', 'Wien', 'London', 'Rom', 'Moskau', 'Prag', 'Washington', 'Athen', 'Brüssel', 'Madrid', 'Budapest', 'Peking', 'Stockholm', 'Kopenhagen',
];

List hfHausbau = [
'Farbe', 'Holz', 'Ingenieur', 'Hammer', 'Architekt', 'Rohr', 'Lastkraftwagen', 'Maurer', 'Helm', 'Beton', 'Gerüst', 'Besen', 'Schutt', 'Tapete', 'Zement',
];

List hfHobbys = [
'Musik', 'Theater', 'Garten', 'Schreiben', 'Reisen', 'Museum', 'Tanz', 'Sport', 'Gesang', 'Fernsehen', 'Computer', 'Lesen', 'Kino', 'Spielen', 'Schwimmen',
];

List hfKleidung = [
'Hut', 'Rock','Kleid','Tuch','Hemd','Anzug','Mütze','Stiefel','Hose','Jacke','Gürtel','Schuh','Bluse','Weste','Handschuhe',
];

List hfKoerperteile = [
'Hand', 'Auge', 'Kopf', 'Herz', 'Mund', 'Arm', 'Rücken', 'Brust', 'Haut', 'Fuß', 'Finger', 'Nase', 'Stirn', 'Hals', 'Ohr',
];

List hfKueche = [
'Glas','Messer','Teller','Tasse','Gabel','Löffel','Herd','Topf','Schüssel','Pfanne','Kühlschrank','Sieb','Schwamm','Backofen','Wasserhahn',
];

List hfLaender = [
'Deutschland','Frankreich', 'USA','England','Italien','Polen','Österreich','China','Japan','Schweiz','Schweden','Türkei','Griechenland','Dänemark','Niederlande'
];

List hfMoebel = [
'Tisch','Bett','Spiegel','Stuhl','Schreibtisch','Sessel','Lampe','Schrank','Sofa','Garderobe','Schemel','Regal','Kommode','Truhe','Nachttisch',
];

List hfMusikinstrumente = [
'Klavier','Orgel','Trommel','Becken','Geige','Bass','Trompete','Schlagzeug','Gitarre','Harfe','Mundharmonika','Pauke','Posaune','Klarinette','Cello',
];

List hfObst = [
'Apfel','Zitrone','Orange','Birne','Ananas','Traube','Banane','Kirsche','Pfirsich','Melone','Feige','Mandarine','Erdbeere','Quitte','Aprikose'
];

List hfPflanzen = [
'Buche','Rose','Klee','Kiefer','Petersilie','Linde','Eiche','Veilchen','Palme','Lorbeer','Flieder','Birke','Efeu','Hanf','Tanne'
];

List hfResteraunt = [
'Geld','Musik','Tisch','Preis','Glas','Rechnung','Küche','Gast','Tafel','Messer','Teller','Kellner','Wirt','Speisen','Koch'
];

List hfSportarten = [
'Fußball','Tanzen','Schwimmen','Gymnastik','Reiten','Turnen','Tennis','Boxen','Rudern','Leichtathletik','Klettern','Fechten','Yoga','Tauchen','Tischtennis'
];

List hfStrassenverkehr = [
'Polizei','Auto', 'Kurve','Straßenbahn','Fahrrad','Baustelle','Feuerwehr','Kreuzung','Autobahn','Bus', 'Taxi','Fahrbahn', 'Fußgänger','Motorrad','Asphalt'
];

List hfSupermarkt = [
'Wein', 'Kaffee', 'Milch', 'Bier', 'Zeitschrift', 'Tee', 'Ei', 'Eis', 'Blume', 'Käse', 'Reis', 'Schokolade', 'Salat', 'Saft', 'Apfel'
];

List hfTiere = [
'Hund', 'Pferd', 'Vogel', 'Fisch', 'Wolf', 'Katze', 'Fuchs', 'Schwein', 'Esel', 'Kuh', 'Tiger', 'Maus', 'Bär', 'Löwe', 'Huhn'
];

List hfWerkzeuge = [
'Leiter', 'Hammer', 'Haken', 'Nagel', 'Pinsel', 'Seil', 'Bit', 'Besen', 'Schere', 'Zange', 'Schraube', 'Meißel', 'Pinzette', 'Feile', 'Schraubenschlüssel'
];