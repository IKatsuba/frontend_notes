import 'package:flutter/material.dart';
import 'package:frontend_notes/enums/languages.dart';
import 'package:frontend_notes/enums/sort_by.dart';

class FilterChangeEvent {
  Languages language;
  SortBy sortBy;
  String q;
  List domains;

  FilterChangeEvent({this.language, this.sortBy, this.q, this.domains});
}

class Filter extends StatefulWidget {
  final List<Languages> languages = [Languages.RU, Languages.EN];
  final List<SortBy> sortBy = [
    SortBy.PUBLISHEDAT,
    SortBy.POPULARITY,
    SortBy.RELEVANCY
  ];

  final void Function(FilterChangeEvent event) onChange;

  Filter({@required this.onChange});

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  Languages _language;
  SortBy _sortBy;

  @override
  void initState() {
    super.initState();
    _language = Languages.RU;
    _sortBy = SortBy.PUBLISHEDAT;

    onChange(language: _language, sortBy: _sortBy);
  }

  void onChange({language, sortBy}) {
    setState(() {
      _language = language ?? _language;
      _sortBy = sortBy ?? _sortBy;

      if (widget.onChange != null) {
        widget.onChange(
            new FilterChangeEvent(language: _language, sortBy: _sortBy));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Row(
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width * 0.45,
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.05),
              child: new InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Language',
                  ),
                  child: new DropdownButtonHideUnderline(
                    child: DropdownButton(
                      isDense: true,
                      value: _language,
                      items: widget.languages
                          .map((lang) => DropdownMenuItem<Languages>(
                                value: lang,
                                child: Text(lang.value.toUpperCase()),
                              ))
                          .toList(),
                      onChanged: (value) => onChange(language: value),
                    ),
                  ))),
          Container(
            width: MediaQuery.of(context).size.width * 0.45,
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
            child: new InputDecorator(
              decoration: const InputDecoration(
                labelText: 'Sort by',
              ),
              child: new DropdownButtonHideUnderline(
                child: new DropdownButton<SortBy>(
                  value: _sortBy,
                  isDense: true,
                  onChanged: (value) => onChange(sortBy: value),
                  items: widget.sortBy
                      .map((sortBy) => DropdownMenuItem<SortBy>(
                            value: sortBy,
                            child: Text(sortBy.toString()),
                          ))
                      .toList(),
                ),
              ),
            ),
          )
        ],
      )
    ]);
  }
}
