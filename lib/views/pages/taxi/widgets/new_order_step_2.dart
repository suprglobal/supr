import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:superapp/view_models/taxi.vm.dart';
import 'package:superapp/view_models/taxi_new_order_summary.vm.dart';
import 'package:superapp/views/pages/taxi/widgets/step_two/new_taxi_order_summary.collapsed.dart';
import 'package:superapp/views/pages/taxi/widgets/step_two/new_taxi_order_summary.panel.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart' show SlidingUpPanel;
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';


class NewTaxiOrderSummaryView extends StatelessWidget {
    NewTaxiOrderSummaryView(this.vm, {Key? key, required this.isCab}) : super(key: key);
  final TaxiViewModel vm;
    final bool isCab;

    @override
  Widget build(BuildContext context) {
    log("current step ${vm.currentStep(2)}");
    return ViewModelBuilder<NewTaxiOrderSummaryViewModel>.reactive(
      viewModelBuilder: () => NewTaxiOrderSummaryViewModel(context, vm),
      onViewModelReady: (vm) => WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          vm.initialise();
        },
      ),
      builder: (context, taxiNewOrderSummaryViewModel, child) {
        return Visibility(
          visible: vm.currentStep(2),
          child: Positioned(
            bottom: 0,
            left: 0,
            right: 0,
             child: SlidingUpPanel(
              color: Colors.white,
              controller: taxiNewOrderSummaryViewModel.panelController,
              minHeight: 400,
              maxHeight: context.screenHeight,
              onPanelClosed: taxiNewOrderSummaryViewModel.notifyListeners,

               collapsed:
              NewTaxiOrderSummaryCollapsed(taxiNewOrderSummaryViewModel,isCab: isCab),
              panel: NewTaxiOrderSummaryPanel(taxiNewOrderSummaryViewModel,isCab: isCab),
            )
                 .pOnly(
              bottom: context.mq.viewInsets.bottom,
            ),
          ),
        );
      },
    );
  }
}
