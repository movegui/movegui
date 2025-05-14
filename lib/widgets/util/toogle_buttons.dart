import 'package:flutter/material.dart';
import 'package:movegui/consts/app_colors.dart';

class ToggleButtonExample extends StatefulWidget {
  const ToggleButtonExample({super.key, required this.onStateChanged});

  final Function(int) onStateChanged;

  @override
  // ignore: library_private_types_in_public_api
  _ToggleButtonExampleState createState() => _ToggleButtonExampleState();
}

class _ToggleButtonExampleState extends State<ToggleButtonExample> {
  List<bool> isSelected = [true, false];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return  Center(
        child: ToggleButtons(
          isSelected: [ _selectedIndex == 0, _selectedIndex == 1 ],
          onPressed: (int index) {
            setState(() {
              _selectedIndex = index;
               widget.onStateChanged(index);
            });
           
          },
           color: Colors.black, // text color when unselected
          selectedColor: AppColors.textColor, // text color when selected
          fillColor: AppColors.backgroundColor, // background color when selected
          borderColor: Colors.grey,
          selectedBorderColor: AppColors.textColor,
                children: <Widget>[
                    MovguiToggleButton(title: "Telephone", iconData: Icons.phone,),
                    MovguiToggleButton(title: "E-Mail", iconData: Icons.email,)
          ],
        ),
    );
  }
}


class MovguiToggleButton extends StatelessWidget {
  const MovguiToggleButton({super.key, required this.title, required this.iconData});

  final String title;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return                        Container(
                    padding: const EdgeInsets.all(8.0),
                //    color: AppColors.backgroundColor,
                    child: Row(
                     mainAxisAlignment: MainAxisAlignment.center,                   
                      children: [                               
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(iconData),
                      ), 
                      Text(title, style: TextStyle(fontSize: 18)),],
                    ),
                  );
  }
  
}