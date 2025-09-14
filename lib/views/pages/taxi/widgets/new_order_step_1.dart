import 'package:flutter/material.dart';
import 'package:superapp/view_models/taxi.vm.dart';
import 'package:superapp/view_models/taxi_new_order_location_entry.vm.dart';
import 'package:superapp/views/pages/taxi/widgets/step_one/new_taxi_order_entry.collapsed.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:stacked/stacked.dart';
import 'package:superapp/views/pages/taxi/widgets/trip_driver_search.dart';
import 'package:velocity_x/velocity_x.dart';

// import 'step_one/new_taxi_order_entry.collapsed.dart';
import 'step_one/new_taxi_order_entry.panel.dart';

class NewTaxiOrderLocationEntryView extends StatelessWidget {
  const NewTaxiOrderLocationEntryView(this.vm, {Key? key, required this.type}) : super(key: key);
  final TaxiViewModel vm;
  final String type;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NewTaxiOrderLocationEntryViewModel>.reactive(
      viewModelBuilder: () => NewTaxiOrderLocationEntryViewModel(context, vm),
      onViewModelReady: (vm) => WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          vm.initialise();
        },
      ),
      builder: (context, taxiNewOrderViewModel, child) {
        return Visibility(
          visible: vm.currentStep(1),
          // child: TripDriverSearch(vm),
          child: Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: !taxiNewOrderViewModel.isDestinationSelected?
            SlidingUpPanel(
              // color: Colors.transparent,
              padding: EdgeInsets.zero,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              panel: NewTaxiOrderEntryPanel(pickup: '',taxiNewOrderViewModel,type:type ),
              collapsed: NewTaxiOrderEntryCollapsed(
                  taxiNewOrderViewModel
              ),
              controller: taxiNewOrderViewModel.panelController,
              minHeight: taxiNewOrderViewModel.customViewHeight,
              maxHeight: context.screenHeight,
              onPanelClosed: taxiNewOrderViewModel.notifyListeners,
            )
                :

            SlidingUpPanel(
              controller: taxiNewOrderViewModel.panelController,
              minHeight: 180,
              maxHeight: MediaQuery.of(context).size.height /0.9,
              borderRadius:   BorderRadius.vertical(top: Radius.circular(20)),
              panelBuilder: (sc) => NewTaxiOrderEntryPanelWidget(
                taxiNewOrderViewModel,
                type: type,
              ),
            collapsed: NewTaxiOrderEntryCollapsedWidget(taxiNewOrderViewModel,type: type),

            ),

          ),
        );
      },
    );
  }
}
