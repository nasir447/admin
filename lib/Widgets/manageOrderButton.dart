import 'package:flutter/material.dart';

class ManageOrderButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 70,
      child: MaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          color:   Color.fromRGBO(244, 75, 89, 1),
          child: Row(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 42.0),
                child: Text(
                  "Manage Order",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                  ),
                ),
              ),
            ],
          ),
          onPressed: () => {
            Navigator.pushNamed(context, '/order')
          }),
    );
  }
}
