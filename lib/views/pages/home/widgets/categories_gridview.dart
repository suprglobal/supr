// ignore_for_file: prefer_const_declarations

import 'package:flutter/material.dart';
import 'package:superapp/common/comig_soon_widget.dart';
import 'package:superapp/models/vendor_type.dart';
import 'package:superapp/services/navigation.service.dart';
import 'package:superapp/view_models/welcome.vm.dart';
import 'package:superapp/views/pages/home/widgets/animated_service_tile.dart';
import 'package:superapp/views/pages/home/widgets/item_gridtile.dart';
import 'package:velocity_x/velocity_x.dart';


class CategoriesGridview extends StatelessWidget {
  final WelcomeViewModel? vm;
  const CategoriesGridview({super.key, required this.items, this.vm});

  final List<Map<String, String>> items;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double horizontalPadding = 32;
    final double spacing = 10 * 3;
    final double tileWidth = (screenWidth - horizontalPadding - spacing) / 4;

    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 25),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.78,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];

          // 3rd (index 2), 7th (index 6), 8th (index 7)
          // final specialIndexes = [2, 6, 7];
          // final scaleFactor = specialIndexes.contains(index) ? 1.7 : 1.0;

          final name = item['name']!;
          if (name == 'All Services') {
            return AnimatedGridTile(
              imageList: [
                "assets/icon/all-services.png",
                "assets/icon/car.png",
                "assets/icon/parcel.png",
                "assets/icon/food.png",
                "assets/icon/bike.png",
                "assets/icon/groceries.png",
               "assets/icon/home-cleaning-icon.png",
               "assets/icon/shop.png",
              ],

              title: name,
              tileWidth: tileWidth,
               onTap: () {
                 context.nextPage(ComingSoonScreen());

               },
            );
          }
          return ItemGridTile(
            imagePath: item['pictureUrl']!,
            title: item['name']!,
            tileWidth: tileWidth,
            // imageScaleFactor: scaleFactor,
            onTap: () {
              // _handleNavigation(context, item['name']!);
              if(index == 0){
                final vendorType = VendorType(id: 6, name: 'Taxi Booking', description: '', slug: 'taxi', color: '#000000', isActive: 1, logo: 'https://multisevices.in/storage/32/mgaMq247jkqpvhYVGShrZ1Oo6iocOC-metadmVuZG9yLnBuZw==-.png', hasBanners: false);
                NavigationService.pageSelected(
                  vendorType,
                  context: context,
                );
              }else if(index == 3){
                final vendorType = VendorType(id: 9, name: 'Bike Booking', description: '', slug: 'taxi', color: '#000000', isActive: 1, logo: 'https://multisevices.in/storage/32/mgaMq247jkqpvhYVGShrZ1Oo6iocOC-metadmVuZG9yLnBuZw==-.png', hasBanners: false);
                NavigationService.pageSelected(
                  vendorType,
                  context: context,
                );
              }
              // else if(index == 2){
              //   context.nextPage(FoodPage());
              // // context.nextPage(DineOutPage());
              // }
              // else if(index==5){
              //                   context.nextPage(HomeServicesScreen());
              //
              // }
              else{
                context.nextPage(ComingSoonScreen());

              }
            },
          );
        },
      ),
    );

  }
}
