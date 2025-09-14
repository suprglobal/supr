import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:superapp/constants/app_colors.dart';
import 'package:superapp/constants/app_strings.dart';
import 'package:superapp/constants/global_variables.dart';
import 'package:superapp/extensions/context.dart';
import 'package:superapp/models/vendor_type.dart';
import 'package:superapp/utils/utils.dart';
import 'package:superapp/view_models/taxi.vm.dart';
import 'package:superapp/views/pages/taxi/widgets/new_order_step_1.dart';
import 'package:superapp/views/pages/taxi/widgets/new_order_step_2.dart';
import 'package:superapp/views/pages/taxi/widgets/step_one/new_taxi_order_entry.collapsed.dart';
import 'package:superapp/views/pages/taxi/widgets/step_one/new_taxi_order_entry.panel.dart';
import 'package:superapp/views/pages/taxi/widgets/taxi_rate_driver.view.dart';
import 'package:superapp/views/pages/taxi/widgets/taxi_trip_ready.view.dart';
import 'package:superapp/views/pages/taxi/widgets/trip_driver_search.dart';
import 'package:superapp/views/pages/taxi/widgets/unsupported_taxi_location.view.dart';
import 'package:superapp/widgets/base.page.dart';
import 'package:superapp/widgets/buttons/custom_leading.dart';
import 'package:superapp/widgets/top_sheet.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../view_models/taxi_new_order_location_entry.vm.dart';

class TaxiPage extends StatefulWidget {
  const TaxiPage( {Key? key, this.vendorType}) : super(key: key);

  final VendorType? vendorType;

  @override
  _TaxiPageState createState() => _TaxiPageState();
}

class _TaxiPageState extends State<TaxiPage> with WidgetsBindingObserver
{
  //
  late TaxiViewModel taxiViewModel;

  @override
  void initState() {
    super.initState();
    taxiViewModel = TaxiViewModel(context, widget.vendorType);
  }

  //
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // if (state == AppLifecycleState. resumed) {
    // }
    taxiViewModel.setGoogleMapStyle();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TaxiViewModel>.reactive(
      viewModelBuilder: () => taxiViewModel,
      onViewModelReady: (vm) => vm.initialise(),
      builder: (context, vm, child) {
        return BasePage(
          showAppBar: false,
          showLeadingAction: !AppStrings.isSingleVendorMode,
          elevation: 0,
          title: "${widget.vendorType?.name}",
          appBarColor: context.theme.colorScheme.surface,
          appBarItemColor: AppColors.primaryColor,
          body: Stack(
            children: [
              //google map
              SafeArea(
                child: GoogleMap(
                  initialCameraPosition: vm.mapCameraPosition,
                  onMapCreated: vm.onMapCreated,
                  padding: vm.googleMapPadding,
                  zoomGesturesEnabled: true,

                  zoomControlsEnabled: false,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  markers: vm.gMapMarkers,
                  polylines: vm.gMapPolylines,
                  style: vm.mapStyle,
                  onCameraIdle: vm.onCameraIdle, // prints current location when stop

                ),
              ),
              Positioned(
                top: 30,
                left: 10,
                right: 10,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          context.pop();
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            border: Border.all(color: AppColors.appGrey),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            color: AppColors.darkGrey,
                            size: 20,
                          ),
                        ),
                      ),
                      Text(
                        'Rides',
                        style: textTheme(context).headlineLarge?.copyWith(
                          color: colorScheme(context).primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 25
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showGeneralDialog(
                            context: context,
                            barrierDismissible: true,
                            barrierLabel: 'TopSheet',
                            transitionDuration:
                            const Duration(milliseconds: 300),
                            pageBuilder: (_, __, ___) =>
                            const SizedBox.shrink(),
                            transitionBuilder: (_, animation, __, ___) {
                              return SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(0, -1),
                                  end: Offset.zero,
                                ).animate(animation),
                                child: const Align(
                                  alignment: Alignment.topCenter,
                                  child: TopSheetWidget(),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: colorScheme(context).primary,
                            border: Border.all(color: AppColors.appGrey),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: const Icon(
                            Icons.menu,
                            color: Color.fromARGB(255, 20, 188, 96),
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),



              //show when location is not supported
              UnSupportedTaxiLocationView(vm),

              //new taxi order form - Step 1
                NewTaxiOrderLocationEntryView(vm,type: (widget.vendorType?.name ?? "Car").contains("Bike") ? "Bike" : "Car"),




              NewTaxiOrderSummaryView(vm,isCab: (widget.vendorType?.name ?? "Car").contains("Bike") ? false : true),

              Visibility(
                visible: vm.currentStep(3),
                child: TripDriverSearch(vm),
              ),

              Visibility(
                visible: vm.currentStep(4),
                child: TaxiTripReadyView(vm),
              ),
              if (vm.currentStep(6)) TaxiRateDriverView(vm),
            ],
          ),
        );
      },
    );
  }
}
