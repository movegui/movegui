import 'package:movegui/consts/widget_constants.dart';
import 'package:movegui/models/widget_item.dart';

class ButtonItem extends WidgetItem{
  final String tooltipText;
   double fontSize;
  final bool enabled;
  ButtonItem({ required super.title, required  this.tooltipText, required this.enabled, this.fontSize=WidgetConstants.buttonFonsize, required super.routeName});
}