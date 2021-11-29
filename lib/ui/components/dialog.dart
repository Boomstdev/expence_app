import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_expense_app/utils/icon_list.dart';

showAddDialog(
    {required BuildContext context,
    TextEditingController? expenceController,
    TextEditingController? priceController,
    Icon? dropdownValue,
    List<Icon>? iconList,
    Function()? onPressed,
    Function(Icon?)? onChange}) async {
  await showDialog(
      context: context,
      builder: (context) => AlertDialog(
            backgroundColor: Colors.white70,
            title: Text("Add Expense"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  child: PopupMenuButton<int>(
                    icon: Row(
                      children: [
                       Icon(Icons.food_bank),
                        Icon(Icons.filter_list),
                      ],
                    ),
                    onSelected: (result) {
                      switch (result) {
                        case  0:
                          print('filter 1 clicked');
                          break;
                        case 1:
                          print('filter 2 clicked');
                          break;
                        case 2:
                          print('Clear filters');
                          break;
                        default:
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<int>>[
                       PopupMenuItem<int>(
                        value: 0,
                        child: Icon(Icons.food_bank),
                      ),
                       PopupMenuItem<int>(
                        value: 1,
                        child: Icon(Icons.mobile_friendly),
                      ),
                       PopupMenuItem<int>(
                        value: 2,
                        child: Icon(Icons.food_bank),
                      ),
                       PopupMenuItem<int>(
                        value: 3,
                        child:  Icon(Icons.free_breakfast),
                      ),
                       PopupMenuItem<int>(
                        value: 4,
                        child: Icon(Icons.reviews_rounded),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: TextField(
                    controller: expenceController,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: 'Enter Expense',
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.5),
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.5),
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: TextField(
                    controller: priceController,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: 'Enter Prices',
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.5),
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.5),
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  "Cancel",
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(
                  "Save",
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
                onPressed: onPressed,
              )
            ],
          ));
}
