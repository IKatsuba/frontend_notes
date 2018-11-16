import 'package:flutter/material.dart';
import 'package:frontend_notes/enums/enums.dart';
import './fn_card.dart';

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
    return Container(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 6.0, right: 8.0),
                child: InputDecorator(
                    decoration: const InputDecoration(labelText: 'Language'),
                    child: DropdownButtonHideUnderline(
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
                    )),
              ),
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.only(left: 6.0, right: 8.0),
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Sort by',
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<SortBy>(
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
            ))
          ],
        ));
  }
}
