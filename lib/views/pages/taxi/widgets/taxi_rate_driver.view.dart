import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:superapp/constants/app_colors.dart';
import 'package:superapp/constants/app_strings.dart';
import 'package:superapp/extensions/string.dart';
import 'package:superapp/models/order.dart';
import 'package:superapp/utils/ui_spacer.dart';
import 'package:superapp/view_models/taxi.vm.dart';
import 'package:superapp/widgets/busy_indicator.dart';
import 'package:superapp/widgets/buttons/custom_button.dart';
import 'package:superapp/widgets/buttons/custom_text_button.dart';
import 'package:superapp/widgets/custom_image.view.dart';
import 'package:superapp/widgets/custom_text_form_field.dart';
import 'package:jiffy/jiffy.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:velocity_x/velocity_x.dart';

class TaxiRateDriverView extends StatefulWidget {
  const TaxiRateDriverView(this.vm, {Key? key}) : super(key: key);
  final TaxiViewModel vm;

  @override
  State<TaxiRateDriverView> createState() => _TaxiRateDriverViewState();
}

class _TaxiRateDriverViewState extends State<TaxiRateDriverView> {
  bool isBusy = true;
  Order? order;

  //init
  @override
  void initState() {
    super.initState();
    //
    widget.vm.getLastTripForRating().then((value) {
      //
      order = value;
      setState(() {
        order = value;
        isBusy = false;
      });

      //if order is null, dismiss the rating view
      if (order == null || order?.driver == null) {
        widget.vm.dismissTripRating();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: context.screenHeight,
      color: Colors.black.withOpacity(0.40),
      child:
          //busy
          (isBusy)
              ? BusyIndicator()
                  .p(20)
                  .box
                  .roundedSM
                  .color(context.theme.colorScheme.surface)
                  .make()
                  .centered()
              :
              //empty
              (order == null)
              ? Container()
              :
              //rating
              VStack([
                //close button: icon and word
                HStack([
                  "Rate your trip".tr().text.xl2.make(),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.redAccent.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    padding: EdgeInsets.all(5),
                    child: Icon(
                      Icons.close,
                      color: Colors.red,
                      size: 22,
                    ).onInkTap(widget.vm.dismissTripRating),
                  ),
                ], alignment: MainAxisAlignment.center).px(20).py(10),
                // info
                VStack([
                      10.heightBox,
                      //driver details
                      VStack(
                        [
                          CustomImage(
                            imageUrl: order!.driver!.photo,
                            width: context.screenWidth * 0.18,
                            height: context.screenWidth * 0.18,
                          ).box.roundedSM.clip(Clip.antiAlias).makeCentered(),
                          10.heightBox,
                          //
                          "${order!.driver!.name}".text.xl.medium.make(),
                          "${order!.driver!.vehicle!.vehicleInfo}".text.light
                              .make(),
                        ],
                        alignment: MainAxisAlignment.center,
                        crossAlignment: CrossAxisAlignment.center,
                      ),
                      //Price
                      VStack(
                        [
                          UiSpacer.divider(),
                          VStack([
                            "${order!.taxiOrder!.currency != null ? order?.taxiOrder?.currency?.symbol : AppStrings.currencySymbol} ${order?.total}"
                                .currencyFormat()
                                .text
                                .semiBold
                                .xl3
                                .makeCentered(),
                            // trip time
                            Jiffy.parseFromDateTime(order!.createdAt)
                                .format(pattern: "dd MMM, yyyy hh:mm a")
                                .text
                                .sm
                                .semiBold
                                .makeCentered(),
                          ]),
                          UiSpacer.divider(),
                        ],
                        alignment: MainAxisAlignment.center,
                        crossAlignment: CrossAxisAlignment.center,
                        spacing: 6,
                      ),
                      // RATE
                      VStack(
                        [
                          "Rate your trip".tr().text.make(),
                          RatingBar.builder(
                            initialRating: 3,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemCount: 5,
                            itemSize: 32,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder:
                                (context, _) => Icon(
                                  EvaIcons.star,
                                  color: Colors.yellow[700],
                                ),
                            onRatingUpdate: (rating) {
                              //
                              widget.vm.newTripRating = rating;
                            },
                          ).py8(),
                          UiSpacer.verticalSpace(),
                          CustomTextFormField(
                            hintText: "Review".tr(),
                            textEditingController: widget.vm.tripReviewTEC,
                            minLines: 3,
                            maxLines: 5,
                          ),
                          //submit button
                          UiSpacer.verticalSpace(),
                          CustomButton(
                            title: "Submit Rating".tr(),
                            loading: widget.vm.busy(widget.vm.newTripRating),
                            onPressed: () {
                              widget.vm.submitTripRating(order!);
                            },
                          ).wFull(context),
                        ],
                        alignment: MainAxisAlignment.center,
                        crossAlignment: CrossAxisAlignment.center,
                      ),
                  InkWell(
                    onTap: ()=> widget.vm.dismissTripRating(),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.redAccent.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,

                      child:   Text("Close".tr(),
                        style: TextStyle(
                            color: AppColors.getStausColor("failed"),
                            fontWeight: FontWeight.bold

                        ),
                      ),
                    ).centered(),
                  ),


                    ], spacing: 10)
                    .p20()
                    .centered()
                    .scrollVertical()
                    .pOnly(bottom: context.mq.viewInsets.bottom)
                    .expand(),
              ]).safeArea().box.color(context.theme.colorScheme.surface).make(),
    );
  }
}
