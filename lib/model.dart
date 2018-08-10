import 'package:flutter/material.dart';

class Encounter {
  final GlobalKey<AnimatedListState> listKey;
  final dynamic removedItemBuilder;
  final List<EncounterParticipant> _participants = new List();

  AnimatedListState get _animatedList => listKey.currentState;

  Encounter({@required this.listKey, @required this.removedItemBuilder})
      : assert(listKey != null), assert(removedItemBuilder != null);

  void add(EncounterParticipant participant) {
    if (_participants.isEmpty
        || _participants.every((p) => p.initiative == _participants[0].initiative)) {
      _participants.add(participant);
      _animatedList.insertItem(_participants.length - 1);
      return;
    }

    if (participant.initiative > _participants.first.initiative
        && (_participants.last.initiative >= participant.initiative || _participants.last.initiative < _participants.first.initiative)) {
      _participants.insert(0, participant);
      _animatedList.insertItem(0);
      return;
    }

    for (var i = 1; i < _participants.length; i++) {
      var before = _participants[i - 1];
      var after = _participants[i];
      if ((participant.initiative <= before.initiative || before.initiative < after.initiative)
          && participant.initiative > after.initiative) {
        _participants.insert(i, participant);
        _animatedList.insertItem(i);
        return;
      }
    }

    _participants.add(participant);
    _animatedList.insertItem(_participants.length - 1);
  }

  void endTurn() {
    if (_participants.length <= 1) return;
    _removeItemFromList(0);
    var participant = _participants.removeAt(0);
    _participants.add(participant);
    _animatedList.insertItem(_participants.length - 1);
  }

  void holdTurn() {
    if (_participants.length <= 1) return;
    if (_participants.every((p) => p.initiative == _participants[0].initiative)) return;
  }

  void deleteFirst() {
    _removeItemFromList(0);
    _participants.removeAt(0);
  }

  void clear() {
    for (var i = _participants.length - 1; i >= 0; i--) {
      _removeItemFromList(i);
    }
    _participants.clear();
  }

  void _removeItemFromList(int index, {Duration duration = Duration.zero}) {
    var p = _participants[index];
    _animatedList.removeItem(index, (context, animation) {
        return removedItemBuilder(
          EncounterParticipant(name: p.name, initiative: p.initiative),
          context,
          animation);
      }, duration: duration);
  }

  EncounterParticipant operator [](int index) => _participants[index];
}

class EncounterParticipant {
  final String name;
  final int initiative;
  final Key key;

  EncounterParticipant({@required this.name, @required this.initiative})
      : key = UniqueKey();
}
