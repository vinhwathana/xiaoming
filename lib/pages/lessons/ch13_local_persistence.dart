//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xiaoming/pages/lessons/edit_entry_ch13.dart';
import 'package:xiaoming/classes/database_ch13.dart';
import 'package:intl/intl.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //hold the parsed JSON objects of the journal JSON object
  Database _database;
  // return List of the Journal class
  Future<List<Journal>> _loadJournals() async {
    //once the readJournals() method completes and returns the value, then()
    // executes the code inside. Note that the journalsJson parameter receives
    // the value from the JSON objects read from the saved local_persistence.json
    // file located in the device local documents folder.
    await DatabaseFileRoutines().readJournals().then((journalsJson) {
      //The databaseFromJson method in the database.dart class uses json.decode()
      //to parse the JSON objects that are read from the saved file.
      //Database.fromJson() is called, and it returns the JSON objects as a Dart List
      _database = databaseFromJson(journalsJson);
      _database.journal.sort((comp1, comp2) => comp2.date.compareTo(comp1.date));
    });
    return _database.journal;
  }

  // Add or Edit Journal Entry and call the Show Entry Dialog
  void _addOrEditJournal({bool add, int index, Journal journal}) async {
    JournalEdit _journalEdit = JournalEdit(action: '', journal: journal);
    _journalEdit = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EditEntry(
            add: add,
            index: index,
            journalEdit: _journalEdit,
          ),
          fullscreenDialog: true
      ),
    );
    switch (_journalEdit.action) {
      case 'Save':
        if (add) {
          setState(() {
            _database.journal.add(_journalEdit.journal);
          });
        } else {
          setState(() {
            _database.journal[index] = _journalEdit.journal;
          });
        }
        DatabaseFileRoutines().writeJournals(databaseToJson(_database));
        break;
      case 'Cancel':
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Local Persistence'),
      ),
      body: FutureBuilder(
        initialData: [],
        future: _loadJournals(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return !snapshot.hasData
              ? Center(child: CircularProgressIndicator())
              : _buildListViewSeparated(snapshot);
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Padding (padding: const EdgeInsets.all(24.0),),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Journal Entry',
        child: Icon(Icons.add),
        onPressed: () {
          _addOrEditJournal(add: true, index: -1, journal: Journal());
        },
      ),
    );
  }

  // Build ListView showing the journal entries.
  // Build the ListView with Separator
  Widget _buildListViewSeparated(AsyncSnapshot snapshot) {
    return ListView.separated(
      itemCount: snapshot.data.length,
      //To access each field, you use the snapshot.data[index].date or
      // snapshot.data[index].mood and so on.
      itemBuilder: (BuildContext context, int index) {
        String _titleDate = DateFormat.yMMMd().format(DateTime.parse(snapshot.data[index].date));
        String _subtitle = snapshot.data[index].mood + "\n" + snapshot.data[index].note;
        return Dismissible(
          key: Key(snapshot.data[index].id),
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 16.0),
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          secondaryBackground: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          child: ListTile(
            leading: Column(
              children: <Widget>[
                Text(DateFormat.d().format(DateTime.parse(snapshot.data[index].date)),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32.0,
                      color: Colors.blue),
                ),
                Text(DateFormat.E().format(DateTime.parse(snapshot.data[index].date))),
              ],
            ),
            title: Text(
              _titleDate,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(_subtitle),
            onTap: () async {
              _addOrEditJournal(
                add: false,
                index: index,
                journal: snapshot.data[index],
              );
            },
          ),
          onDismissed: (direction) {
            setState(() {
              _database.journal.removeAt(index);
            });
            DatabaseFileRoutines().writeJournals(databaseToJson(_database));
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          color: Colors.grey,
        );
      },
    );
  }
}