// ignore_for_file: deprecated_member_use, prefer_final_fields, unused_field

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key, required this.currentFilters});

  final Map<Filter, bool> currentFilters;

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var _glutenFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _vegetarianFreeFilterSet = false;
  var _veganFilterSet = false;

  @override
  void initState() {
    super.initState();
    _glutenFreeFilterSet = widget.currentFilters[Filter.glutenFree]!;
    _lactoseFreeFilterSet = widget.currentFilters[Filter.lactoseFree]!;
    _vegetarianFreeFilterSet = widget.currentFilters[Filter.vegetarian]!;
    _veganFilterSet = widget.currentFilters[Filter.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Your Filters"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop({
            Filter.glutenFree: _glutenFreeFilterSet,
            Filter.lactoseFree: _lactoseFreeFilterSet,
            Filter.vegetarian: _vegetarianFreeFilterSet,
            Filter.vegan: _veganFilterSet,
          });
          return false;
        },
        child: Column(
          children: [
            SwitchListTile(
              value: _glutenFreeFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _glutenFreeFilterSet = isChecked;
                });
              },
              title: Text(
                'Gluten-free',
                style: GoogleFonts.poppins(color: Colors.white),
              ),
              subtitle: Text(
                'Only include gluten-free meals.',
                style: GoogleFonts.poppins(color: Colors.grey),
              ),
              activeColor: Colors.blueGrey,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _lactoseFreeFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _lactoseFreeFilterSet = isChecked;
                });
              },
              title: Text(
                'Lactose-free',
                style: GoogleFonts.poppins(color: Colors.white),
              ),
              subtitle: Text(
                'Only include lactose-free meals.',
                style: GoogleFonts.poppins(color: Colors.grey),
              ),
              activeColor: Colors.blueGrey,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _vegetarianFreeFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _vegetarianFreeFilterSet = isChecked;
                });
              },
              title: Text(
                'Vegetarian',
                style: GoogleFonts.poppins(color: Colors.white),
              ),
              subtitle: Text(
                'Only include vegetarian meals.',
                style: GoogleFonts.poppins(color: Colors.grey),
              ),
              activeColor: Colors.blueGrey,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _veganFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _veganFilterSet = isChecked;
                });
              },
              title: Text(
                'Vegan',
                style: GoogleFonts.poppins(color: Colors.white),
              ),
              subtitle: Text(
                'Only include vegan meals.',
                style: GoogleFonts.poppins(color: Colors.grey),
              ),
              activeColor: Colors.blueGrey,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
          ],
        ),
      ),
    );
  }
}