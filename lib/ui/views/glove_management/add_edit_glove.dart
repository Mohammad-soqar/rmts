import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rmts/data/models/enums/glove_status.dart';
import 'package:rmts/data/models/glove.dart';
import 'package:rmts/viewmodels/glove_viewmodel.dart';

class AddEditGloveView extends StatefulWidget {
  const AddEditGloveView({super.key});

  @override
  _AddEditGloveViewState createState() => _AddEditGloveViewState();
}

class _AddEditGloveViewState extends State<AddEditGloveView> {
  final _formKey = GlobalKey<FormState>();
  final _gloveStatusController = TextEditingController();
  final _patientIdController = TextEditingController();
  final _modelController = TextEditingController();
  final _versionController = TextEditingController();
  final _productionDateController = TextEditingController();

  @override
  void dispose() {
    _gloveStatusController.dispose();
    _patientIdController.dispose();
    _modelController.dispose();
    _versionController.dispose();
    _productionDateController.dispose();

    super.dispose();
  }

  void _submitForm(GloveViewModel viewModel) async {
    if (_formKey.currentState!.validate()) {
      final glove = Glove(
        gloveId: '',
        status: viewModel.selectedStatus,
        patientId: _patientIdController.text,
        model: _modelController.text,
        version: _versionController.text,
        productionDate: _productionDateController.text,
      );

      await viewModel.addGlove(glove);

      if (viewModel.errorMessage == null) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Glove added successfully!')),
        );
        Navigator.pop(context); // Go back to the previous screen
      } else {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(viewModel.errorMessage!)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<GloveViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Glove'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text("Select Glove Status:",
                  style: TextStyle(fontSize: 18)),

              // Dropdown using the ViewModel
              DropdownButton<GloveStatus>(
                value: viewModel.selectedStatus,
                onChanged: (GloveStatus? newValue) {
                  if (newValue != null) {
                    viewModel.setSelectedStatus(newValue);
                  }
                },
                items: GloveStatus.values.map((status) {
                  return DropdownMenuItem<GloveStatus>(
                    value: status,
                    child: Text(status.toString().split('.').last),
                  );
                }).toList(),
              ),

              TextFormField(
                controller: _patientIdController,
                decoration: const InputDecoration(labelText: 'Patient ID'),
              ),
              TextFormField(
                controller: _modelController,
                decoration: const InputDecoration(labelText: 'Model'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Model';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _versionController,
                decoration: const InputDecoration(labelText: 'Version'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Version';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _productionDateController,
                decoration: const InputDecoration(labelText: 'Production Date'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Production Date';
                  }
                  return null;
                },
              ),

              if (viewModel.isLoading)
                const Center(child: CircularProgressIndicator()),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed:
                    viewModel.isLoading ? null : () => _submitForm(viewModel),
                child: const Text('Add Glove'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
