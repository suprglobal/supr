import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:superapp/constants/app_colors.dart';
import 'package:superapp/utils/ui_spacer.dart';
import 'package:superapp/view_models/order_details.vm.dart';
import 'package:superapp/widgets/buttons/custom_button.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:velocity_x/velocity_x.dart';

class OrderBottomSheet extends StatelessWidget {
  const OrderBottomSheet(this.vm, {Key? key}) : super(key: key);
  final OrderDetailsViewModel vm;
  @override
  Widget build(BuildContext context) {
    return vm.order.canCancel && !vm.isBusy
        ? SafeArea(
            child: VStack(
              [
                //
                vm.order.canCancel
                    ? CustomButton(
                        title: "Cancel Order".tr(),
                        color: AppColors.closeColor,
                        icon: FlutterIcons.close_ant,
                        onPressed: vm.cancelOrder,
                        loading: vm.busy(vm.order),
                      ).p20()
                    : UiSpacer.emptySpace(),
              ],
              crossAlignment: CrossAxisAlignment.center,
            ),
          )
            .box
            .shadow
            .color(context.theme.colorScheme.surface)
            .make()
            .wFull(context)
        : UiSpacer.emptySpace();
  }
}
