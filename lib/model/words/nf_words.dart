List nfall = [
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

List nfAutoteile = ['Scheibenwischer', 'Auspuff', 'Stoßstange', 'Klimaanlage', 'Tachometer', 'Gangschaltung', 'Bremspedal', 'Handschuhfach', 'Zündkerze', 'Wagenheber', 'Rückbank', 'Autotür', 'Sicherheitsgurt', 'Heckscheibe', 'Benzintank', 'Schiebedach', 'Kopfstütze'];

List nfBadezimmer = ['Nagellack','Nagelschere','Shampoo','Duschkabine','Fliese','Handtuchhalter','Duschvorhang','Zahnseide','Badezimmerschrank','Klobürste','Zahnputzbecher','Duschgel','Badematte','Duschhaube','Duschkopf'];

List nfBauernhof = ['Huhn','Scheune','Spaten','Teich','Schaf','Kartoffel','Ziege','Beet','Traktor','Rechen','Hundehütte','Gummistiefel','Milchkanne','Mistgabel','Latzhose'];

List nfBerufe = ['Therapeut','Fotograf','Kassierer','Uhrmacher','Klempner','Elektriker','Bademeister','Informatiker','Masseur','Dachdecker','Konditor','Tierpfleger','Flugbegleiter','Hotelkaufmann','Müllmann'];

List nfDeutscheStaedte = ['Lübeck','Regensburg','Tübingen','Aachen','Mannheim','Trier','Dortmund','Koblenz','Ulm','Chemnitz','Erlangen','Bochum','Ludwigshafen','Solingen','Idstein'];

List nfFahrzeuge = ['Tandem','Motorroller','Gabelstapler','Cabriolet','Hundeschlitten','Dreirad','Dampfwalze','Mofa','Polizeiauto','Feuerwehrauto','Dampflokomotive','Bollerwagen','Einrad','Abschleppwagen','Seifenkiste'];

List nfGarten = ['Liegestuhl','Sonnenschirm','Grill','Gießkanne','Hängematte','Sandkasten','Harke','Rechen','Regentonne','Rasenmäher','Vogelhaus','Rutsche','Wasserschlauch','Setzling','Blumenerde'];

List nfGemuese = ['Rhabarber','Rosenkohl','Weißkohl','Ingwer','Rotkohl','Grünkohl','Artischocke','Lauch','Wirsing','Karotte','Brokkoli','Aubergine','Peperoni','Süßkartoffel','Zucchini'];

List nfGetraenke = ['Orangensaft','Apfelsaft','Glühwein','Apfelwein','Tomatensaft','Radler','Fanta','Kirschsaft','Whiskey','Ananassaft','Karottensaft','Eistee','Bowle','Hefeweizen','Cappuccino'];

List nfHauptstaedte = ['Helsinki','Tokio','Lissabon','Ankara','Oslo','Kiew','Teheran','Bagdad','Dublin','Hanoi','Havanna','Bangkok','Ottawa','Nairobi','NeuDelhi'];

List nfHausbau = ['Kran','Bagger','Polier','Rohbau','Dachdecker','Schubkarre','Installateur','Schutzbrille','Wasserwaage','Bohrmaschine','Bauzeichnung','Stichsäge','Gerüstbauer','Gehörschutz','Abdeckfolie'];

List nfHobbys = ['Einkaufen','Nähen','Wintersport','Disco','Basteln','Kreuzworträtsel','Häkeln','Camping','Jodeln','Töpfern','Kampfsport','Fitness','Modelleisenbahn','Aerobic','Heimwerken'];

List nfKleidung = ['Unterhemd','Dirndl','BH','Gummistiefel','Anorak','Blazer','Strumpfhose','Hausschuh','Latzhose','Poncho','Korsage','Turnschuh','Leggings','Jogginghose','Pullunder'];

List nfKoerperteile = ['Ellenbogen','Wirbelsäule','Handgelenk','Wimper','Lippe','Gesäß','Knöchel','Niere','Wade','Fingernagel','Schlüsselbein','Lid','Augenbraue','Gebiss','Fußnagel'];

List nfKueche = ['Arbeitsplatte','Toaster','Spülmittel','Tauchsieder','Mikrowelle','Spülmaschine','Flaschenöffner','Eieruhr','Küchenrolle','Küchenhandtuch','Gefrierfach','Dosenöffner','Schneidebrett','Messerblock','Dunstabzugshaube'];

List nfLaender = ['Island','Tunesien','Malta','Peru','Bolivien','Mongolei','Namibia','Kroatien','Kenia','Ecuador','Nepal','Haiti','Russland','Jamaika','Tansania'];

List nfMoebel = ['Stehlampe','Standuhr','Sitzbank','Barhocker','Servierwagen','Schirmständer','Raumteiler','Hollywoodschaukel','Handtuchhalter','Zeitungsständer','Wickelkommode','Sideboard','Schuhschrank','Stockbett','Sitzsack'];

List nfMusikinstrumente = ['Saxophon','Akkordeon','Tuba','Triangel','Bratsche','Dudelsack','Xylophon','Waldhorn','Blockflöte','Tamburin','Drehleier','Querflöte','Balalaika','Ukulele','Kontrabass'];

List nfObst = ['Grapefruit','Kiwi','Granatapfel','Heidelbeere','Stachelbeere','Johannisbeere','Zwetschge','Mango','Physalis','Preiselbeere','Mirabelle','Papaya','Litschi','Kokusnuss','Maracuja'];

List nfPflanzen = ['Eberesche','Hortensie','Zypresse','Koriander','Hyazinthe','Geranie','Schlehe','Mammutbaum','Oregano','Ringelblume','Vergissmeinnicht','Löwenmäulchen','Brennnessel','Bärlauch'];

List nfResteraunt = ['Trinkgeld','Besteck','Menü','Speisekarte','Tresen','Vorspeise','Tischdecke','Dessert','Aperitif','Hauptgang','Weinkarte','Zapfhahn','Tageskarte','Reservierung','Digestif'];

List nfSportarten = ['Basketball','Eiskunstlauf','Marathonlauf','Baseball','Volleyball','Badminton','Joggen','Judo','Karate','Walken','Squash','Biathlon','Skisprung','Aerobic','Snowboard'];

List nfStrassenverkehr = ['Tankstelle','Ampel','Krankenwagen','Stau','Bushaltestelle','Fußgängerzone','Gehweg','Bordstein','Zebrastreifen','Kreisverkehr','Radweg','Verkehrsschild','Leitplanke','Blitzer','Mittelstreifen'];

List nfSupermarkt = ['Nudeln','Kaugummi','Leberwurst','Eierlikör','Heidelbeeren','Pizza','Apfelwein','Mettwurst','Klopapier','Spülmittel','Shampoo','Eiskaffee','Geschenkpapier','Rasierer','Eistee'];

List nfTiere = ['Schildkröte','Krokodil','Meerschweinchen','Leopard','Jaguar','Wiesel','Luchs','Hamster','Lama','Otter','Elch','Robbe','Pinguin','Alpaka','Delfin'];

List nfWerkzeuge = ['Zollstock','Kreissäge','Dübel','Wasserwaage','Bohrmaschine','Lötkolben','Kabeltrommel','Drahtbürste','Winkelmesser','Verlängerungskabel','Motorsäge','Handbohrer','Schweißgerät','Schleifpapier','Lüsterklemme'];