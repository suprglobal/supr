import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:superapp/constants/app_colors.dart';
import 'package:superapp/constants/constants.dart';
import 'package:superapp/utils/ui_spacer.dart';
import 'package:superapp/utils/utils.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:measure_size/measure_size.dart';
import 'package:velocity_x/velocity_x.dart';

class BasePage extends StatefulWidget {
  final bool showAppBar;
  final bool showLeadingAction;
  final bool? extendBodyBehindAppBar;
  final Function? onBackPressed;
  final bool showCart;
  final dynamic title;
  final List<Widget>? actions;
  final Widget? leading;
  final Widget body;
  final Widget? bottomSheet;
  final Widget? bottomNavigationBar;
  final Widget? fab;
  final FloatingActionButtonLocation? fabLocation;
  final bool isLoading;
  final Color? appBarColor;
  final double? elevation;
  final Color? appBarItemColor;
  final Color? backgroundColor;
  final bool showCartView;
  final PreferredSizeWidget? customAppbar;

  BasePage({
    this.showAppBar = false,
    this.leading,
    this.showLeadingAction = false,
    this.onBackPressed,
    this.showCart = false,
    this.title = "",
    this.actions,
    required this.body,
    this.bottomSheet,
    this.bottomNavigationBar,
    this.fab,
    this.fabLocation,
    this.isLoading = false,
    this.appBarColor,
    this.appBarItemColor,
    this.backgroundColor,
    this.elevation,
    this.extendBodyBehindAppBar,
    this.showCartView = false,
    this.customAppbar,
    Key? key,
  }) : super(key: key);

  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  //
  double bottomPaddingSize = 0;

  //
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Utils.isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: KeyboardDismisser(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: widget.backgroundColor ?? AppColors.faintBgColor,
          extendBodyBehindAppBar: widget.extendBodyBehindAppBar ?? false,
          appBar: widget.customAppbar != null
              ? widget.customAppbar
              : widget.showAppBar
              ? AppBar(
                  scrolledUnderElevation: 0,
                  backgroundColor: widget.appBarColor ?? context.primaryColor,
                  elevation: widget.elevation,
                  automaticallyImplyLeading: widget.showLeadingAction,
                  leading: widget.showLeadingAction
                      ? widget.leading == null
                            ? Padding(
                                padding: const EdgeInsets.only(
                                  top: 8,
                                  bottom: 8,
                                  left: Dimensions.homePagePadding,
                                ),
                                child: InkWell(
                                  onTap: widget.onBackPressed != null
                                      ? () => widget.onBackPressed!()
                                      : () => Navigator.pop(context),
                                  child: Container(
                                    height: 30,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey.shade400),
                                      // border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    child: const Icon(
                                      Icons.arrow_back,
                                      color: AppColors.darkGrey,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              )
                            : widget.leading
                      : null,
                  title: widget.title is Widget
                      ? widget.title
                      : "${widget.title}".text
                            .maxLines(1)
                            .xl2
                            .overflow(TextOverflow.ellipsis)
                            .color(widget.appBarItemColor ?? Colors.white)
                            .make(),
                  actions:
                      widget.actions ??
                      [

                      ],
                )
              : null,
          body: Stack(
            children: [
              //body
              VStack([
                //
                widget.isLoading
                    ? LinearProgressIndicator()
                    : UiSpacer.emptySpace(),

                //
                widget.body.pOnly(bottom: bottomPaddingSize).expand(),
              ]),
            ],
          ),
          bottomNavigationBar: widget.bottomNavigationBar,
          bottomSheet: widget.bottomSheet,
          floatingActionButton: widget.fab,
          floatingActionButtonLocation: widget.fabLocation,
        ),
      ),
    );
  }
}
