import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:soigne_moi_mobile/model/prescription.dart';
import 'package:soigne_moi_mobile/screens/home/home.dart';

class PrescriptionPage extends StatefulWidget {
  final HomeController controller;
  const PrescriptionPage({super.key, required this.controller});
  @override
  State<PrescriptionPage> createState() => _PrescriptionPageState();
}

class _PrescriptionPageState extends State<PrescriptionPage> {
  String selectedDrug = '';
  TextEditingController dosageController = TextEditingController();

  void addDrugContainer() {
    widget.controller
        .addDrug(Drug(name: selectedDrug, dosage: dosageController.text));
    setState(() {
      selectedDrug = '';
      dosageController.clear(); // Reset dosage field
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prescription'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: ElevatedButton(
              onPressed: widget.controller.prescribedDrugs.isEmpty
                  ? null
                  : widget.controller.showConfirmationDialog,
              style: ElevatedButton.styleFrom(
                  disabledForegroundColor: Colors.grey.withOpacity(0.38),
                  disabledBackgroundColor: Colors.grey
                      .withOpacity(0.12), // color when button deactivated
                  foregroundColor: Colors.green),
              child: Text('Valider'),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              ...widget.controller.prescribedDrugs.map((drug) {
                return Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[200],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text('Médicament : ${drug.name}'),
                            Text('Posologie : ${drug.dosage}'),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: 8,
                      top: 8,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.controller.removeDrug(drug);
                          });
                        },
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.red, width: 2.0),
                            color: Colors.white,
                          ),
                          child: Icon(
                            Icons.close,
                            color: Colors.red,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[200],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      DropdownSearch<String>(
                        asyncItems: (String filter) async {
                          await widget.controller.fetchDrugs();

                          List<String> drugs = widget.controller.drugs;
                          return drugs;
                        },
                        popupProps: PopupPropsMultiSelection.modalBottomSheet(
                          searchFieldProps: TextFieldProps(
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColorLight,
                                  width: 2.0,
                                ),
                              ),
                            ),
                            cursorColor: Theme.of(context).primaryColorLight,
                          ),
                          showSearchBox: true,
                          showSelectedItems: true,
                        ),
                        onChanged: (value) {
                          setState(() {
                            selectedDrug = value ?? '';
                          });
                        },
                        selectedItem: selectedDrug,
                        items: widget.controller.drugs,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: dosageController,
                        decoration: InputDecoration(
                          labelText: 'Posologie',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColorLight,
                              width: 2.0,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 2.0,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            dosageController.text = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.white, Colors.grey[400]!],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: () {
                    if (selectedDrug.isNotEmpty &&
                        dosageController.text.isNotEmpty) {
                      addDrugContainer();
                    }
                  },
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_circle),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Valider ce médicament',
                          ),
                        ],
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
