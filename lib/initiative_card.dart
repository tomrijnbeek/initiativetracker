import 'package:flutter/material.dart';
import 'package:initiativetracker/model.dart';

class InitiativeCard extends StatefulWidget {

  final EncounterParticipant participant;
  final VoidCallback onEndTurn;
  final VoidCallback onHoldTurn;
  final VoidCallback onDelete;
  final bool buttonsVisible;

  InitiativeCard({
    @required this.participant,
    this.onEndTurn,
    this.onHoldTurn,
    this.onDelete,
    this.buttonsVisible = false})
    : super(key: participant.key);

  @override
  State<StatefulWidget> createState() {
    return _InitiativeCardState();
  }
}

class _InitiativeCardState extends State<InitiativeCard> {

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(children: <Widget>[
          Expanded(
            child: Text(
              widget.participant.name,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w400)),
          ),
          Text('${widget.participant.initiative}'),
        ])
      ),
      widget.buttonsVisible ? ButtonTheme.bar(
        // make buttons use the appropriate styles for cards
        child: ButtonBar(
          children: <Widget>[
            FlatButton(
              child: const Text('DELETE'),
              onPressed: widget.onDelete,
              textColor: Colors.red,
            ),
            // FlatButton(
            //   child: const Text('HOLD TURN'),
            //   onPressed: widget.onHoldTurn,
            // ),
            FlatButton(
              child: const Text('END TURN'),
              onPressed: widget.onEndTurn,
            ),
          ],
        ),
      ) : Container(),
    ]));
  }
}
