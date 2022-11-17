List all = [
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
  'Deutschland','Frankreich', 'USA','England','Italien','Polen','Österreich','China','Japan','Schweiz','Schweden','Türkei','Griechenland','Dänemark','Niederlande',
  'Tisch','Bett','Spiegel','Stuhl','Schreibtisch','Sessel','Lampe','Schrank','Sofa','Garderobe','Schemel','Regal','Kommode','Truhe','Nachttisch',
  'Klavier','Orgel','Trommel','Becken','Geige','Bass','Trompete','Schlagzeug','Gitarre','Harfe','Mundharmonika','Pauke','Posaune','Klarinette','Cello',
  'Apfel','Zitrone','Orange','Birne','Ananas','Traube','Banane','Kirsche','Pfirsich','Melone','Feige','Mandarine','Erdbeere','Quitte','Aprikose',
  'Buche','Rose','Klee','Kiefer','Petersilie','Linde','Eiche','Veilchen','Palme','Lorbeer','Flieder','Birke','Efeu','Hanf','Tanne',
  'Geld','Musik','Tisch','Preis','Glas','Rechnung','Küche','Gast','Tafel','Messer','Teller','Kellner','Wirt','Speisen','Koch',
  'Fußball','Tanzen','Schwimmen','Gymnastik','Reiten','Turnen','Tennis','Boxen','Rudern','Leichtathletik','Klettern','Fechten','Yoga','Tauchen','Tischtennis',
  'Polizei','Auto', 'Kurve','Straßenbahn','Fahrrad','Baustelle','Feuerwehr','Kreuzung','Autobahn','Bus', 'Taxi','Fahrbahn', 'Fußgänger','Motorrad','Asphalt',
  'Wein', 'Kaffee', 'Milch', 'Bier', 'Zeitschrift', 'Tee', 'Ei', 'Eis', 'Blume', 'Käse', 'Reis', 'Schokolade', 'Salat', 'Saft', 'Apfel',
  'Hund', 'Pferd', 'Vogel', 'Fisch', 'Wolf', 'Katze', 'Fuchs', 'Schwein', 'Esel', 'Kuh', 'Tiger', 'Maus', 'Bär', 'Löwe', 'Huhn',
  'Leiter', 'Hammer', 'Haken', 'Nagel', 'Pinsel', 'Seil', 'Bit', 'Besen', 'Schere', 'Zange', 'Schraube', 'Meißel', 'Pinzette', 'Feile', 'Schraubenschlüssel',
  'Scheibenwischer', 'Auspuff', 'Stoßstange', 'Klimaanlage', 'Tachometer', 'Gangschaltung', 'Bremspedal', 'Handschuhfach', 'Zündkerze', 'Wagenheber', 'Rückbank', 'Autotür', 'Sicherheitsgurt', 'Heckscheibe', 'Benzintank', 'Schiebedach', 'Kopfstütze',
  'Nagellack','Nagelschere','Shampoo','Duschkabine','Fliese','Handtuchhalter','Duschvorhang','Zahnseide','Badezimmerschrank','Klobürste','Zahnputzbecher','Duschgel','Badematte','Duschhaube','Duschkopf',
  'Huhn','Scheune','Spaten','Teich','Schaf','Kartoffel','Ziege','Beet','Traktor','Rechen','Hundehütte','Gummistiefel','Milchkanne','Mistgabel','Latzhose',
  'Therapeut','Fotograf','Kassierer','Uhrmacher','Klempner','Elektriker','Bademeister','Informatiker','Masseur','Dachdecker','Konditor','Tierpfleger','Flugbegleiter','Hotelkaufmann','Müllmann',
  'Lübeck','Regensburg','Tübingen','Aachen','Mannheim','Trier','Dortmund','Koblenz','Ulm','Chemnitz','Erlangen','Bochum','Ludwigshafen','Solingen','Idstein',
  'Tandem','Motorroller','Gabelstapler','Cabriolet','Hundeschlitten','Dreirad','Dampfwalze','Mofa','Polizeiauto','Feuerwehrauto','Dampflokomotive','Bollerwagen','Einrad','Abschleppwagen','Seifenkiste',
  'Liegestuhl','Sonnenschirm','Grill','Gießkanne','Hängematte','Sandkasten','Harke','Rechen','Regentonne','Rasenmäher','Vogelhaus','Rutsche','Wasserschlauch','Setzling','Blumenerde',
  'Rhabarber','Rosenkohl','Weißkohl','Ingwer','Rotkohl','Grünkohl','Artischocke','Lauch','Wirsing','Karotte','Brokkoli','Aubergine','Peperoni','Süßkartoffel','Zucchini',
  'Orangensaft','Apfelsaft','Glühwein','Apfelwein','Tomatensaft','Radler','Fanta','Kirschsaft','Whiskey','Ananassaft','Karottensaft','Eistee','Bowle','Hefeweizen','Cappuccino',
  'Helsinki','Tokio','Lissabon','Ankara','Oslo','Kiew','Teheran','Bagdad','Dublin','Hanoi','Havanna','Bangkok','Ottawa','Nairobi','Neu-Delhi',
  'Kran','Bagger','Polier','Rohbau','Dachdecker','Schubkarre','Installateur','Schutzbrille','Wasserwaage','Bohrmaschine','Bauzeichnung','Stichsäge','Gerüstbauer','Gehörschutz','Abdeckfolie',
  'Einkaufen','Nähen','Wintersport','Disco','Basteln','Kreuzworträtsel','Häkeln','Camping','Jodeln','Töpfern','Kampfsport','Fitness','Modelleisenbahn','Aerobic','Heimwerken',
  'Unterhemd','Dirndl','BH','Gummistiefel','Anorak','Blazer','Strumpfhose','Hausschuh','Latzhose','Poncho','Korsage','Turnschuh','Leggings','Jogginghose','Pullunder',
  'Ellenbogen','Wirbelsäule','Handgelenk','Wimper','Lippe','Gesäß','Knöchel','Niere','Wade','Fingernagel','Schlüsselbein','Lid','Augenbraue','Gebiss','Fußnagel',
  'Arbeitsplatte','Toaster','Spülmittel','Tauchsieder','Mikrowelle','Spülmaschine','Flaschenöffner','Eieruhr','Küchenrolle','Küchenhandtuch','Gefrierfach','Dosenöffner','Schneidebrett','Messerblock','Dunstabzugshaube',
  'Island','Tunesien','Malta','Peru','Bolivien','Mongolei','Namibia','Kroatien','Kenia','Ecuador','Nepal','Haiti','Russland','Jamaika','Tansania',
  'Stehlampe','Standuhr','Sitzbank','Barhocker','Servierwagen','Schirmständer','Raumteiler','Hollywoodschaukel','Handtuchhalter','Zeitungsständer','Wickelkommode','Sideboard','Schuhschrank','Stockbett','Sitzsack',
  'Saxophon','Akkordeon','Tuba','Triangel','Bratsche','Dudelsack','Xylophon','Waldhorn','Blockflöte','Tamburin','Drehleier','Querflöte','Balalaika','Ukulele','Kontrabass',
  'Grapefruit','Kiwi','Granatapfel','Heidelbeere','Stachelbeere','Johannisbeere','Zwetschge','Mango','Physalis','Preiselbeere','Mirabelle','Papaya','Litschi','Kokusnuss','Maracuja',
  'Eberesche','Hortensie','Zypresse','Koriander','Hyazinthe','Geranie','Schlehe','Mammutbaum','Oregano','Ringelblume','Vergissmeinnicht','Löwenmäulchen','Brennnessel','Bärlauch',
  'Trinkgeld','Besteck','Menü','Speisekarte','Tresen','Vorspeise','Tischdecke','Dessert','Aperitif','Hauptgang','Weinkarte','Zapfhahn','Tageskarte','Reservierung','Digestif',
  'Basketball','Eiskunstlauf','Marathonlauf','Baseball','Volleyball','Badminton','Joggen','Judo','Karate','Walken','Squash','Biathlon','Skisprung','Aerobic','Snowboard',
  'Tankstelle','Ampel','Krankenwagen','Stau','Bushaltestelle','Fußgängerzone','Gehweg','Bordstein','Zebrastreifen','Kreisverkehr','Radweg','Verkehrsschild','Leitplanke','Blitzer','Mittelstreifen',
  'Nudeln','Kaugummi','Leberwurst','Eierlikör','Heidelbeeren','Pizza','Apfelwein','Mettwurst','Klopapier','Spülmittel','Shampoo','Eiskaffee','Geschenkpapier','Rasierer','Eistee',
  'Schildkröte','Krokodil','Meerschweinchen','Leopard','Jaguar','Wiesel','Luchs','Hamster','Lama','Otter','Elch','Robbe','Pinguin','Alpaka','Delfin',
  'Zollstock','Kreissäge','Dübel','Wasserwaage','Bohrmaschine','Lötkolben','Kabeltrommel','Drahtbürste','Winkelmesser','Verlängerungskabel','Motorsäge','Handbohrer','Schweißgerät','Schleifpapier','Lüsterklemme'
];

List autoteile = [
  'Sitz','Dach','Motor','Rad', 'Achse', 'Batterie', 'Reifen', 'Scheinwerfer', 'Lenkrad', 'Kupplung', 'Zündung', 'Kofferraum', 'Rückspiegel', 'Handbremse', 'Felge',
  'Scheibenwischer', 'Auspuff', 'Stoßstange', 'Klimaanlage', 'Tachometer', 'Gangschaltung', 'Bremspedal', 'Handschuhfach', 'Zündkerze', 'Wagenheber', 'Rückbank', 'Autotür', 'Sicherheitsgurt', 'Heckscheibe', 'Benzintank', 'Schiebedach', 'Kopfstütze'
];

List badezimmer = [
  'Spiegel','Kalk','Seife','Toilette','Handtuch','Badewanne','Waschbecken','Schminke','Dusche','Creme','Fön','Zahnbürste','Wasserhahn','Waschlappen','Zahnpasta',
  'Nagellack','Nagelschere','Shampoo','Duschkabine','Fliese','Handtuchhalter','Duschvorhang','Zahnseide','Badezimmerschrank','Klobürste','Zahnputzbecher','Duschgel','Badematte','Duschhaube','Duschkopf'
];

List bauernhof = [
  'Hund', 'Milch','Pferd','Bauer','Eier','Hahn','Wiese','Katze','Getreide','Stall','Käse','Futter','Schwein','Zaun','Kuh',
  'Huhn','Scheune','Spaten','Teich','Schaf','Kartoffel','Ziege','Beet','Traktor','Rechen','Hundehütte','Gummistiefel','Milchkanne','Mistgabel','Latzhose'
];

List berufe = [
  'Arzt', 'Lehrer', 'Maler', 'Politker', 'Sekretär', 'Schauspieler', 'Sänger', 'Koch', 'Anwalt', 'Erzieher', 'Gärtner', 'Dolmetscher', 'Polizist', 'Bäcker', 'Friseur',
  'Therapeut','Fotograf','Kassierer','Uhrmacher','Klempner','Elektriker','Bademeister','Informatiker','Masseur','Dachdecker','Konditor','Tierpfleger','Flugbegleiter','Hotelkaufmann','Müllmann'
];

List deutscheStaedte = [
  'Berlin', 'München', 'Leipzig', 'Hamburg', 'Essen','Dresden','Frankfurt am Main','Köln','Stuttgart','Hannover','Düsseldorf','Bremen','Potsdam','Weimar','Münster',
  'Lübeck','Regensburg','Tübingen','Aachen','Mannheim','Trier','Dortmund','Koblenz','Ulm','Chemnitz','Erlangen','Bochum','Ludwigshafen','Solingen','Idstein'
];

List fahrzeuge = [
  'Zug', 'Schiff', 'Auto', 'Panzer', 'Straßenbahn', 'Fahrrad','Bus','Taxi','Motorrad','Lastkraftwagen','Fähre','UBahn','Transporter','Bagger','Limousine',
  'Tandem','Motorroller','Gabelstapler','Cabriolet','Hundeschlitten','Dreirad','Dampfwalze','Mofa','Polizeiauto','Feuerwehrauto','Dampflokomotive','Bollerwagen','Einrad','Abschleppwagen','Seifenkiste'
];

List garten = [
  'Bank', 'Mauer', 'Baum', 'Gemüse', 'Blume', 'Zaun', 'Topf', 'Schuppen', 'Laub', 'Rasen', 'Unkraut', 'Kräuter', 'Spaten', 'Schere', 'Handschuh',
  'Liegestuhl','Sonnenschirm','Grill','Gießkanne','Hängematte','Sandkasten','Harke','Rechen','Regentonne','Rasenmäher','Vogelhaus','Rutsche','Wasserschlauch','Setzling','Blumenerde'
];

List gemuese = [
  'Salat', 'Mais', 'Zwiebel', 'Linse', 'Kartoffel', 'Paprika', 'Pilz', 'Blumenkohl', 'Spinat', 'Spargel', 'Knoblauch', 'Gurke', 'Sellerie', 'Tomate', 'Bohne',
  'Rhabarber','Rosenkohl','Weißkohl','Ingwer','Rotkohl','Grünkohl','Artischocke','Lauch','Wirsing','Karotte','Brokkoli','Aubergine','Peperoni','Süßkartoffel','Zucchini'
];

List getraenke = [
  'Wasser', 'Kaffee', 'Milch', 'Bier', 'Tee', 'Sekt', 'Rotwein', 'Rum', 'Kakao', 'Champagner', 'Weißwein', 'Likör', 'Limonade', 'Nektar', 'Cola',
  'Orangensaft','Apfelsaft','Glühwein','Apfelwein','Tomatensaft','Radler','Fanta','Kirschsaft','Whiskey','Ananassaft','Karottensaft','Eistee','Bowle','Hefeweizen','Cappuccino'
];

List hauptstaedte = [
  'Berlin','Paris', 'Wien', 'London', 'Rom', 'Moskau', 'Prag', 'Washington', 'Athen', 'Brüssel', 'Madrid', 'Budapest', 'Peking', 'Stockholm', 'Kopenhagen',
  'Helsinki','Tokio','Lissabon','Ankara','Oslo','Kiew','Teheran','Bagdad','Dublin','Hanoi','Havanna','Bangkok','Ottawa','Nairobi','Neu-Delhi'
];

List hausbau = [
  'Farbe', 'Holz', 'Ingenieur', 'Hammer', 'Architekt', 'Rohr', 'Lastwagen', 'Maurer', 'Helm', 'Beton', 'Gerüst', 'Besen', 'Schutt', 'Tapete', 'Zement',
  'Kran','Bagger','Polier','Rohbau','Dachdecker','Schubkarre','Installateur','Schutzbrille','Wasserwaage','Bohrmaschine','Bauzeichnung','Stichsäge','Gerüstbauer','Gehörschutz','Abdeckfolie'
];

List hobbys = [
  'Musik', 'Theater', 'Garten', 'Schreiben', 'Reisen', 'Museum', 'Tanz', 'Sport', 'Gesang', 'Fernsehen', 'Computer', 'Lesen', 'Kino', 'Spielen', 'Schwimmen',
  'Einkaufen','Nähen','Wintersport','Disco','Basteln','Kreuzworträtsel','Häkeln','Camping','Jodeln','Töpfern','Kampfsport','Fitness','Modelleisenbahn','Aerobic','Heimwerken'
];

List kleidung = [
  'Hut', 'Rock','Kleid','Tuch','Hemd','Anzug','Mütze','Stiefel','Hose','Jacke','Gürtel','Schuh','Bluse','Weste','Handschuh',
  'Unterhemd','Dirndl','BH','Gummistiefel','Anorak','Blazer','Strumpfhose','Hausschuh','Latzhose','Poncho','Korsage','Turnschuh','Leggings','Jogginghose','Pullunder'
];

List koerperteile = [
  'Hand', 'Auge', 'Kopf', 'Herz', 'Mund', 'Arm', 'Rücken', 'Brust', 'Haut', 'Fuß', 'Finger', 'Nase', 'Stirn', 'Hals', 'Ohr',
  'Ellenbogen','Wirbelsäule','Handgelenk','Wimper','Lippe','Gesäß','Knöchel','Niere','Wade','Fingernagel','Schlüsselbein','Lid','Augenbraue','Gebiss','Fußnagel'
];

List kueche = [
  'Glas','Messer','Teller','Tasse','Gabel','Löffel','Herd','Topf','Schüssel','Pfanne','Kühlschrank','Sieb','Schwamm','Backofen','Wasserhahn',
  'Arbeitsplatte','Toaster','Spülmittel','Tauchsieder','Mikrowelle','Spülmaschine','Flaschenöffner','Eieruhr','Küchenrolle','Küchenhandtuch','Gefrierfach','Dosenöffner','Schneidebrett','Messerblock','Dunstabzugshaube'
];

List laender = [
  'Deutschland','Frankreich', 'USA','England','Italien','Polen','Österreich','China','Japan','Schweiz','Schweden','Türkei','Griechenland','Dänemark','Niederlande',
  'Island','Tunesien','Malta','Peru','Bolivien','Mongolei','Namibia','Kroatien','Kenia','Ecuador','Nepal','Haiti','Russland','Jamaika','Tansania'
];

List moebel = [
  'Tisch','Bett','Spiegel','Stuhl','Schreibtisch','Sessel','Lampe','Schrank','Sofa','Garderobe','Schemel','Regal','Kommode','Truhe','Nachttisch',
  'Stehlampe','Standuhr','Sitzbank','Barhocker','Servierwagen','Schirmständer','Raumteiler','Hollywoodschaukel','Handtuchhalter','Zeitungsständer','Wickelkommode','Sideboard','Schuhschrank','Stockbett','Sitzsack'
];

List musikinstrumente = [
  'Klavier','Orgel','Trommel','Becken','Geige','Bass','Trompete','Schlagzeug','Gitarre','Harfe','Mundharmonika','Pauke','Posaune','Klarinette','Cello',
  'Saxophon','Akkordeon','Tuba','Triangel','Bratsche','Dudelsack','Xylophon','Waldhorn','Blockflöte','Tamburin','Drehleier','Querflöte','Balalaika','Ukulele','Kontrabass'
];

List obst = [
  'Apfel','Zitrone','Orange','Birne','Ananas','Traube','Banane','Kirsche','Pfirsich','Melone','Feige','Mandarine','Erdbeere','Quitte','Aprikose',
  'Grapefruit','Kiwi','Granatapfel','Heidelbeere','Stachelbeere','Johannisbeere','Zwetschge','Mango','Physalis','Preiselbeere','Mirabelle','Papaya','Litschi','Kokusnuss','Maracuja'
];

List pflanzen = [
  'Buche','Rose','Klee','Kiefer','Petersilie','Linde','Eiche','Veilchen','Palme','Lorbeer','Flieder','Birke','Efeu','Hanf','Tanne',
  'Eberesche','Hortensie','Zypresse','Koriander','Hyazinthe','Geranie','Schlehe','Mammutbaum','Oregano','Ringelblume','Vergissmeinnicht','Löwenmäulchen','Brennnessel','Bärlauch'
];

List resteraunt = [
  'Geld','Musik','Tisch','Preis','Glas','Rechnung','Küche','Gast','Tafel','Messer','Teller','Kellner','Wirt','Speisen','Koch',
  'Trinkgeld','Besteck','Menü','Speisekarte','Tresen','Vorspeise','Tischdecke','Dessert','Aperitif','Hauptgang','Weinkarte','Zapfhahn','Tageskarte','Reservierung','Digestif'
];

List sportarten = [
  'Fußball','Tanzen','Schwimmen','Gymnastik','Reiten','Turnen','Tennis','Boxen','Rudern','Leichtathletik','Klettern','Fechten','Yoga','Tauchen','Tischtennis',
  'Basketball','Eiskunstlauf','Marathonlauf','Baseball','Volleyball','Badminton','Joggen','Judo','Karate','Walken','Squash','Biathlon','Skisprung','Aerobic','Snowboard'
];

List strassenverkehr = [
  'Polizei','Auto', 'Kurve','Straßenbahn','Fahrrad','Baustelle','Feuerwehr','Kreuzung','Autobahn','Bus', 'Taxi','Fahrbahn', 'Fußgänger','Motorrad','Asphalt',
  'Tankstelle','Ampel','Krankenwagen','Stau','Bushaltestelle','Fußgängerzone','Gehweg','Bordstein','Zebrastreifen','Kreisverkehr','Radweg','Verkehrsschild','Leitplanke','Blitzer','Mittelstreifen'
];

List supermarkt = [
  'Wein', 'Kaffee', 'Milch', 'Bier', 'Zeitschrift', 'Tee', 'Ei', 'Eis', 'Blume', 'Käse', 'Reis', 'Schokolade', 'Salat', 'Saft', 'Apfel',
  'Nudeln','Kaugummi','Leberwurst','Eierlikör','Heidelbeeren','Pizza','Apfelwein','Mettwurst','Klopapier','Spülmittel','Shampoo','Eiskaffee','Geschenkpapier','Rasierer','Eistee'
];

List tiere = [
  'Hund', 'Pferd', 'Vogel', 'Fisch', 'Wolf', 'Katze', 'Fuchs', 'Schwein', 'Esel', 'Kuh', 'Tiger', 'Maus', 'Bär', 'Löwe', 'Huhn',
  'Schildkröte','Krokodil','Meerschweinchen','Leopard','Jaguar','Wiesel','Luchs','Hamster','Lama','Otter','Elch','Robbe','Pinguin','Alpaka','Delfin'
];

List werkzeuge = [
  'Leiter', 'Hammer', 'Haken', 'Nagel', 'Pinsel', 'Seil', 'Bit', 'Besen', 'Schere', 'Zange', 'Schraube', 'Meißel', 'Pinzette', 'Feile', 'Schraubenschlüssel',
  'Zollstock','Kreissäge','Dübel','Wasserwaage','Bohrmaschine','Lötkolben','Kabeltrommel','Drahtbürste','Winkelmesser','Verlängerungskabel','Motorsäge','Handbohrer','Schweißgerät','Schleifpapier','Lüsterklemme'
];