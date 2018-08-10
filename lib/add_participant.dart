import 'package:flutter/material.dart';
import 'package:initiativetracker/model.dart';

class AddParticipantForm extends StatefulWidget {
  final ValueSetter<EncounterParticipant> onFormSubmitted;
  final VoidCallback closeForm;

  const AddParticipantForm(
      {Key key, this.onFormSubmitted, this.closeForm})
      : super(key: key);

  @override
  AddParticipantFormState createState() {
    return AddParticipantFormState();
  }
}

class AddParticipantFormState extends State<AddParticipantForm> {
  final _formKey = GlobalKey<FormState>();

  String _name;
  int _initiative;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: new InputDecoration(
                    hintText: 'Character name'
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter some text';
                    }
                  },
                  onSaved: (value) {
                    _name = value;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: new InputDecoration(
                    hintText: 'Initiative'
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter some text';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Enter a valid number';
                    }
                  },
                  onSaved: (value) {
                    _initiative = int.parse(value);
                  },
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                        child: Text("Cancel"),
                        onPressed: widget.closeForm),
                    RaisedButton(
                        child: Text("Add"),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            widget.onFormSubmitted(EncounterParticipant(
                                name: _name, initiative: _initiative));
                            widget.closeForm();
                          }
                        })
                  ],
                )
              ],
            )));
  }
}
