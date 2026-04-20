import 'package:movegui/consts/widget_constants.dart';
import 'package:movegui/models/widget_item.dart';

class ButtonItem extends WidgetItem{
  final String tooltipText;
  final double fontSize;
  final bool enabled;
  ButtonItem(super.title, this.tooltipText, this.enabled, {this.fontSize=WidgetConstants.buttonFonsize, required super.routeName});
}