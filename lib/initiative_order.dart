import 'package:flutter/material.dart';
import 'package:initiativetracker/initiative_card.dart';
import 'package:initiativetracker/model.dart';

class InitiativeOrder extends StatefulWidget {

  const InitiativeOrder({ Key key }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new InitiativeOrderState();
  }
}

class InitiativeOrderState extends State<InitiativeOrder> {
  Encounter _encounter;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    _encounter = new Encounter(
      listKey: _listKey,
      removedItemBuilder: _buildRemovedItem);
  }

  @override
  Widget build(BuildContext context) {
    return new AnimatedList(
      key: _listKey,
      itemBuilder: _buildItem,
    );
  }

  void addEncounterParticipant(EncounterParticipant participant) {
    setState(() { _encounter.add(participant); });
  }

  void resetEncounter() {
    setState(() { _encounter.clear(); });
  }

  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
    return InitiativeCard(
      participant: _encounter[index],
      onEndTurn: _encounter.endTurn,
      onHoldTurn: _encounter.holdTurn,
      onDelete: _encounter.deleteFirst,
      buttonsVisible: index == 0);
  }

  Widget _buildRemovedItem(
      EncounterParticipant participant, BuildContext context, Animation<double> animation) {
    return InitiativeCard(participant: participant);
  }
}
