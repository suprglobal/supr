import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:superapp/constants/app_images.dart';
import 'package:superapp/constants/constants.dart';
import 'package:superapp/views/pages/home/widgets/categories_gridview.dart';
import 'package:superapp/views/pages/home/widgets/home_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, });


  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> items = [
      {'name': 'Rides', 'pictureUrl': "assets/icon/car.png"},
      {'name': 'Box', 'pictureUrl': "assets/icon/parcel.png"},
      {'name': 'Food', 'pictureUrl': "assets/icon/food.png"},
      {'name': 'Bike', 'pictureUrl': "assets/icon/bike.png"},
      {'name': 'Groceries', 'pictureUrl': "assets/icon/groceries.png"},
      {'name': 'Home Cleaning', 'pictureUrl':"assets/icon/home-cleaning-icon.png"},
      {'name': 'Shop', 'pictureUrl': "assets/icon/shop.png"},
      {'name': 'All Services', 'pictureUrl': "assets/icon/all-services.png"},
    ];
    final List<Map<String, String>> suggestionsItems = [
        {'imagePath': AppImages.dailyProdcuts, 'title': 'Daily Products'},
      {
        'imagePath': "assets/image/fresh_vegetables.png",
        'title': 'Fresh vegetables'
      },
      {'imagePath': AppImages.fruits, 'title': 'Fresh Fruits'},
      // Add more items as needed
      {'imagePath': AppImages.dailyProdcuts, 'title': 'Daily Products'},
      {
        'imagePath': "assets/image/fresh_vegetables.png",
        'title': 'Fresh vegetables'
      },
      {'imagePath': AppImages.fruits, 'title': 'Fresh Fruits'},
      // Add more items as needed
    ];
    final List<String> images = [
        AppImages.dineOut,
        AppImages.offerFood,
        AppImages.pizzaFood

    ];
    final List<String> images2 = [
     AppImages.homeCleaning,
     AppImages.acCleaning,
     AppImages.furnitureCleaning,
     AppImages.kitchenCleaning,
    ];
    return AnnotatedRegion(
      value:SystemUiOverlayStyle(
        statusBarColor: Color(0xFFFFF3D9)
      ) ,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                HomeHeader(),
                CategoriesGridview(items: items),
                // HomeProductCategories(),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35.0),
                  child: Image.asset(
                    'assets/image/taj_mehal.PNG',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color:  Color(0xFFEEEEEE),
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Column(
                    children: [

                      const SizedBox(height: 20),
                      Text(
                        'Congratulations!',
                        style: GoogleFonts.poppins(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                    ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Exclusive discounts just for you',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                  borderRadius: BorderRadius.circular(14)
                              ),
                              alignment: Alignment.center,
                              child: Text("Subscribe for INR 20",style: TextStyle(
                                   fontSize: 15,
                                fontWeight: FontWeight.w600
                              )),
                            ),
                            const SizedBox(height: 15),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                              decoration: BoxDecoration(
                                  // color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    offset: const Offset(0, 4),
                                    blurRadius: 4,
                                    spreadRadius: 1,
                                  ),
                                ],
                                color: Colors.white,


                                  borderRadius: BorderRadius.circular(14)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      spacing: 4,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Instant 10% back on rides",style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600
                                        )),
                                        Text("Credited to your Supr Pay wallet",style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600
                                        )),
                                      ],
                                    ),
                                  ),
                                  Image.asset(
                                    AppImages.rides,
                                    fit: BoxFit.fitHeight,
                                    height: 50,
                                    width: 50,
                                  ),

                                ],
                              ),
                            ),
                            const SizedBox(height: 15),

                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      offset: const Offset(0, 4),
                                      blurRadius: 4,
                                      spreadRadius: 1,
                                    ),
                                  ],

                                  borderRadius: BorderRadius.circular(14)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      spacing: 4,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Free delivery on food & groceries",
                                            style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600
                                        )),
                                        Text("Credited to your Supr Pay wallet",style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600
                                        )),
                                      ],
                                    ),
                                  ),
                                  Image.asset(
                                    AppImages.food,
                                    fit: BoxFit.fitHeight,
                                    height: 50,
                                    width: 50,
                                  ),

                                ],
                              ),
                            ),
                            const SizedBox(height: 15),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                              decoration: BoxDecoration(
                                  // color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      offset: const Offset(0, 4),
                                      blurRadius: 4,
                                      spreadRadius: 1,
                                    ),
                                  ],

                                  color: Colors.white,

                                  borderRadius: BorderRadius.circular(14)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      spacing: 4,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Save INR 300+ every month",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600
                                            )),
                                        Text("On rides,food,groceries,Dineout plus more",style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600
                                        )),
                                      ],
                                    ),
                                  ),
                                  Image.asset(
                                    AppImages.sendmoney,
                                    fit: BoxFit.fitHeight,
                                    height: 50,
                                    width: 50,
                                  ),

                                ],
                              ),
                            ),
                            const SizedBox(height: 15),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                              decoration: BoxDecoration(
                                  // color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      offset: const Offset(0, 4),
                                      blurRadius: 4,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                  color: Colors.white,

                                  borderRadius: BorderRadius.circular(14)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text("View all Supr Plus benefits",style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600
                                    )),
                                  ),
                                  Icon(Icons.arrow_forward)
                                ],
                              ),
                            ),
                            const SizedBox(height: 15),

                          ],
                        ),
                      ),
                      // const CongratulationsContainer(),
                    ],
                  ),
                ),
                const SizedBox(height: 15),

                SizedBox(
                  height: 160,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: images.length,
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.homePagePadding,
                    ),
                    separatorBuilder: (context, index) => SizedBox(width: 13),
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                              images[index],
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size .width * 0.8
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 190,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: images2.length,
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.homePagePadding,
                    ),
                    separatorBuilder: (context, index) => SizedBox(width: 13),
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                              images2[index],
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size .width * 0.4
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 25),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

