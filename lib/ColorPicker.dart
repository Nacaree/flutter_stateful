import 'package:flutter/material.dart';
import 'package:learn_stateful/ColorLogic.dart';
import 'package:provider/provider.dart';

class Colorpicker extends StatelessWidget {
  const Colorpicker({super.key});
  @override
  Widget build(BuildContext context) {
    final ColorLogic logic = context.read<ColorLogic>();
    final String name = context.select<ColorLogic, String>(
      (colorN) => colorN.colorName,
    );
    return Scaffold(
      body: Container(
        color: context.select<ColorLogic, Color>(
          (colorBackground) => colorBackground.currentColor,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Color: $name",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      logic.setColor(Colors.blue, "Blue");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      fixedSize: Size(90, 30),
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      "Blue",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      logic.setColor(Colors.red, "Red");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      fixedSize: Size(90, 30),
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      "Red",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(width: 10),

                  ElevatedButton(
                    onPressed: () {
                      logic.setColor(Colors.green, "Green");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      "Green",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
