import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:soigne_moi_mobile/screens/home/home.dart';

class PrescriptionPage extends StatefulWidget {
  final HomeController controller;
  const PrescriptionPage({super.key, required this.controller});
  @override
  State<PrescriptionPage> createState() => _PrescriptionPageState();
}

class _PrescriptionPageState extends State<PrescriptionPage> {
  String selectedDrug = '';
  String dosage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prescription'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
                                // width: 2.0,
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
                      decoration: InputDecoration(
                        labelText: 'Posologie',
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        setState(() {
                          dosage = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Ajoutez ici la logique de validation
                print('Médicament sélectionné : $selectedDrug');
                print('Posologie : $dosage');
              },
              child: Text('Valider'),
            ),
          ],
        ),
      ),
    );
  }
}
