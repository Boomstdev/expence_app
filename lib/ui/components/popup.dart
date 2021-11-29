import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PopupEnterExpense extends StatefulWidget {
  final TextEditingController? expenceController;
  final TextEditingController? priceController;
  final Function()? onPressed;
  final Function(int)? onSelectIcon;

  PopupEnterExpense(
      {this.expenceController,
      this.priceController,
      this.onPressed,
      this.onSelectIcon});

  @override
  _PopupEnterExpenseState createState() => _PopupEnterExpenseState();
}

class _PopupEnterExpenseState extends State<PopupEnterExpense> {
  Icon? dropdownValue = Icon(Icons.food_bank);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white70,
      title: Text("Add Expense"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(),
            child: PopupMenuButton<int>(
              icon: Row(
                children: [
                  Expanded(child: dropdownValue!),
                  Container(child: Icon(Icons.filter_list)),
                ],
              ),
              onSelected:(result) {
                switch (result) {
                  case 0:
                    {
                      setState(() {
                        dropdownValue = Icon(Icons.food_bank);
                        widget.onSelectIcon!(result);
                      });
                    }
                    break;
                  case 1:
                    {
                      setState(() {
                        dropdownValue = Icon(Icons.mobile_friendly);
                        widget.onSelectIcon!(result);
                      });
                    }
                    break;
                  case 2:
                    {
                      setState(() {
                        dropdownValue = Icon(Icons.money);
                        widget.onSelectIcon!(result);
                      });
                    }
                    break;
                  case 3:
                    {
                      setState(() {
                        dropdownValue = Icon(Icons.money);
                        widget.onSelectIcon!(result);
                      });
                    }
                    break;
                  case 4:
                    {
                      setState(() {
                        dropdownValue = Icon(Icons.money);
                        widget.onSelectIcon!(result);
                      });
                    }
                    break;
                    
                  default:
                  widget.onSelectIcon!(result);
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
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
                  child: Icon(Icons.money),
                ),
                PopupMenuItem<int>(
                  value: 3,
                  child: Icon(Icons.free_breakfast),
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
              controller: widget.expenceController,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                labelText: 'Enter Expense',
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 1.5),
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 1.5),
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
              controller: widget.priceController,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                labelText: 'Enter Prices',
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 1.5),
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 1.5),
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
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(
            "Save",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
          onPressed: widget.onPressed,
        )
      ],
    );
  }
}
