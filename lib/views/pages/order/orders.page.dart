import 'package:flutter/material.dart';
import 'package:superapp/constants/sizes.dart';
import 'package:superapp/services/order.service.dart';
import 'package:superapp/view_models/orders.vm.dart';
import 'package:superapp/widgets/base.page.dart';
import 'package:superapp/widgets/custom_list_view.dart';
import 'package:superapp/widgets/list_items/order.list_item.dart';
import 'package:superapp/widgets/list_items/taxi_order.list_item.dart';
import 'package:superapp/widgets/states/empty.state.dart';
import 'package:superapp/widgets/states/order.empty.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage>
    with AutomaticKeepAliveClientMixin<OrdersPage>, WidgetsBindingObserver {
  //
  late OrdersViewModel vm;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      vm.fetchMyOrders();
    }
  }

  @override
  Widget build(BuildContext context) {
    vm = OrdersViewModel(context);
    super.build(context);
    return BasePage(
      body: ViewModelBuilder<OrdersViewModel>.reactive(
        viewModelBuilder: () => vm,
        onViewModelReady: (vm) => vm.initialise(),
        builder: (context, vm, child) {
          return VStack([
            //
            20.heightBox,
            "My Orders".tr().text.xl2.semiBold.make().px(20),
            10.heightBox,
            //
            if (vm.isAuthenticated())
              CustomListView(
                canPullUp: true,
                canRefresh: true,
                refreshController: vm.refreshController,
                onRefresh: () => vm.fetchMyOrders(),
                onLoading: () => vm.fetchMyOrders(initialLoading: false),
                dataSet: vm.orders,
                padding: EdgeInsets.all(Sizes.paddingSizeDefault),
                emptyWidget: EmptyOrder(),
                separatorBuilder: (_, index) => 2.heightBox,
                isLoading: vm.isBusy,
                itemBuilder: (context, index) {
                  final order = vm.orders[index];
                  //for taxi tye of order
                  if (order.taxiOrder != null) {
                    return TaxiOrderListItem(
                      order: order,
                      orderPressed: () => vm.openOrderDetails(order),
                    );
                  }
                  return OrderListItem(
                    order: order,
                    orderPressed: () => vm.openOrderDetails(order),
                    onPayPressed:
                        () => OrderService.openOrderPayment(order, vm),
                  );
                },
              ).expand(),

            if (!vm.isAuthenticated())
              EmptyState(
                auth: true,
                showAction: true,
                actionPressed: vm.openLogin,
              ).py12().centered().expand(),

          ]);
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
