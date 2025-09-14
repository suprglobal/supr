import 'package:flutter/material.dart';
import 'package:superapp/extensions/dynamic.dart';
import 'package:superapp/extensions/string.dart';
import 'package:superapp/models/order.dart';
import 'package:superapp/models/order_product.dart';
import 'package:superapp/constants/app_strings.dart';
import 'package:superapp/utils/ui_spacer.dart';
import 'package:superapp/views/pages/order/widgets/order_digitial_product_download.dart';
import 'package:superapp/widgets/buttons/arrow_indicator.dart';
import 'package:superapp/widgets/cards/custom.visibility.dart';
import 'package:superapp/widgets/cards/rounded_container.dart';
import 'package:superapp/widgets/custom_image.view.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:velocity_x/velocity_x.dart';

class OrderProductListItem extends StatelessWidget {
  const OrderProductListItem({
    required this.orderProduct,
    required this.order,
    Key? key,
  }) : super(key: key);

  final OrderProduct orderProduct;
  final Order order;
  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        //other status
        CustomVisibilty(
          visible: !order.isCommerce,
          child: HStack(
            [
              RoundedContainer(
                child: CustomImage(
                  imageUrl: orderProduct.product!.photo,
                  width: 50,
                  height: 50,
                ),
              ),

              VStack(
                [
                  //
                  "${orderProduct.product!.name}".text.make(),
                  Visibility(
                    visible: orderProduct.options != null,
                    child:
                        "${orderProduct.options}".text.sm.gray500.medium.make(),
                  ),
                  //
                  5.heightBox,
                  //qty
                  "x ${orderProduct.quantity}".text.bold.make(),
                ],
              ).px12().expand(),
              "${AppStrings.currencySymbol}${orderProduct.price}"
                  .currencyFormat()
                  .text
                  .semiBold
                  .make(),
              //
            ],
          ),
        ),


        //download digital product
        DigitialProductOrderDownload(order, orderProduct),
      ],
      spacing: 15,
    );
  }


}
