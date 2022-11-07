import 'dart:io';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import '../providers/places_provider.dart';
import '../widgets/image_input.dart';
import '../widgets/location_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static String routName = '/add-place';
  const AddPlaceScreen({super.key});

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;
  LocationData? _selectedLocation;

  void selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void selectLocation(LocationData location) {
    _selectedLocation = location;
  }

  void _onSubmit() {
    if (_titleController.text.isEmpty ||
        _pickedImage == null ||
        _selectedLocation == null) {
      return;
    }
    context.read<Places>().addItem(
        title: _titleController.text,
        latitude: _selectedLocation!.latitude as double,
        longitude: _selectedLocation!.longitude as double,
        image: _pickedImage!);

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add place'),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(children: [
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(labelText: 'Title'),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ImageInput(selectImage),
                    SizedBox(
                      height: 15,
                    ),
                    LocationInput(selectLocation),
                  ]),
                ),
              ),
            ),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    foregroundColor: colorScheme.primary,
                    backgroundColor: colorScheme.secondary,
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    elevation: 0,
                    shape: const ContinuousRectangleBorder()),
                onPressed: _onSubmit,
                icon: const Icon(Icons.photo_size_select_actual_rounded),
                label: const Text('Add place'))
          ]),
    );
  }
}
