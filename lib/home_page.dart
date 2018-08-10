import 'package:flutter/material.dart';
import 'package:initiativetracker/add_participant.dart';
import 'package:initiativetracker/initiative_order.dart';
import 'package:initiativetracker/model.dart';

class HomePage extends StatelessWidget {

  final GlobalKey<InitiativeOrderState> _initiativeKey = GlobalKey<InitiativeOrderState>();
  final VoidCallback onThemeToggled;

  HomePage({Key key, this.onThemeToggled}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Initiative tracker'),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.palette),
            tooltip: 'Toggle theme',
            onPressed: onThemeToggled,
          ),
          new IconButton(
            icon: new Icon(Icons.restore),
            tooltip: 'Reset',
            onPressed: _reset,
          ),
        ],
      ),
      body: new InitiativeOrder(key: _initiativeKey),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: () { showDialog(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              children: <Widget>[
                AddParticipantForm(
                  onFormSubmitted: (EncounterParticipant participant) {
                    _initiativeKey.currentState.addEncounterParticipant(participant);
                  },
                  closeForm: () { Navigator.pop(context); })
              ]
            );
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _reset() {
    _initiativeKey.currentState.resetEncounter();
  }
}
