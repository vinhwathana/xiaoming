import 'package:path_provider/path_provider.dart'; //Filesystem locations
import 'dart:io'; //Used byFile
import 'dart:convert'; //Used by json

class DatabaseFileRoutines {
  //return documents directory path
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  //return json file location
  Future<File> get _localFile async {
    final path = await _localPath;

    return File('$path/local_persistence.json');
  }

  //try-catch in case there is an issue with reading
  //to check whether the file exists if not create it
  Future<String> readJournals() async {
    try {
      final file = await _localFile;
      if (!file.existsSync()) {
        print("File does not Exist: ${file.absolute}");
        await writeJournals('{"journals":[]');
      }
      //Read the file
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      print("error readJournals: $e");
      return "";
    }
  }

  //save the JSON objects to file
  Future<File> writeJournals(String json) async {
    final file = await _localFile;

    //Write the file
    return file.writeAsString('$json');
  }
}

// Local Storage JSON Database file and Journal Class
// To read and parse from JSON data - databaseFromJson(jsonString);
// To save and parse to JSON Data - databaseToJson(jsonString);

Database databaseFromJson(String str) {
  final dataFromJson = json.decode(str);
  return Database.fromJson(dataFromJson);
}

// To save and parse to JSON Data - databaseToJson(jsonString);
String databaseToJson(Database data) {
  final dataToJson = data.toJson();
  return json.encode(dataToJson);
}

//The Database class is responsible for encoding and decoding the JSON file
// and mapping it to a List.
class Database {
  List<Journal> journal;
  Database({
    this.journal,
  });
  //To retrieve and map the JSON objects to a List<Journal>
  factory Database.fromJson(Map<String, dynamic> json) => Database(
    journal: List<Journal>.from(json["journals"].map((x) => Journal.fromJson(x))),
  );

  //To convert the List<Journal> to JSON objects, create the toJson method that
  //parses each Journal class to JSON objects.
  Map<String, dynamic> toJson() => {
    "journals": List<dynamic>.from(journal.map((x) => x.toJson())),
  };
}
//The Journal class maps each journal entry from and to JSON.
//using curly ({}) brackets to declare the constructor named parameters.
class Journal {
  String id;
  String date;
  String mood;
  String note;

  Journal({
    this.id,
    this.date,
    this.mood,
    this.note,
  });
  //To retrieve and convert the JSON object to a Journal class
  factory Journal.fromJson(Map<String, dynamic> json) => Journal(
    id: json["id"],
    date: json["date"],
    mood: json["mood"],
    note: json["note"],
  );

  //To convert the Journal class to a JSON object
  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date,
    "mood": mood,
    "note": note,
  };
}

//The JournalEdit class is used to pass an action (save or cancel)
// and a journal entry between pages.
// Used for Data Entry to pass between pages
class JournalEdit {
  String action;
  Journal journal;

  JournalEdit({this.action, this.journal});
}
