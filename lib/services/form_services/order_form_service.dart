import 'package:movegui/models/order_item_model.dart';
import 'package:movegui/models/order_model.dart';
import 'package:movegui/models/store/store_model.dart';
import 'package:movegui/models/user_model.dart';
import 'package:movegui/services/form_services/form_service.dart';
import 'package:movegui/widgets/formsControllers/form_controller.dart';
import 'package:movegui/widgets/formsControllers/order_form_controller.dart';

abstract class OrderFormService<  M extends StoreModel,
  U extends UserModel,
  I extends OrderItemModel,
  OM extends OrderModel<U, I>,
  F extends FormController<M>,
  FS extends FormService<M,F> , O extends OrderFormController<M,U,I,OM,F,FS>>  extends FormService<M, O> {
  OrderFormService({required super.api});


}