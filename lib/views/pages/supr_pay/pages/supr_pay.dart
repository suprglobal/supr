import 'package:flutter/material.dart';
import 'package:superapp/constants/app_colors.dart';
import 'package:superapp/constants/global_variables.dart';

class SuprPayPage extends StatefulWidget {
  const SuprPayPage({super.key});

  @override
  State<SuprPayPage> createState() => _SuprPayPageState();
}

class _SuprPayPageState extends State<SuprPayPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            colors: [
              const Color.fromARGB(255, 235, 227, 78),
              const Color.fromARGB(255, 231, 221, 221),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                      radius: 14,
                      backgroundColor: AppColors.darkGrey,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 1, left: 5),
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 15,
                          color: colorScheme(context).surface,
                        ),
                      )),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSl0dPvyV3W5epqYI8PLBuEEjjlMEzXkmFndHMlxhLypfvPjWG0_3HwMsoWXqZUUCOb94U&usqp=CAU', // Add this icon in assets
                    height: 60,
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: Text(
                    'MONEY BALANCE',
                    style: textTheme(context).bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorScheme(context).error.withOpacity(0.5)),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    '₹0',
                    style: textTheme(context).displayLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme(context).onSurface),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  // padding: const EdgeInsets.all(15)
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF3CF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '★  Important Update  ★',
                        style: textTheme(context).bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme(context).onSurface),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Supr Money is now exclusively usable',
                        style: textTheme(context).bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: colorScheme(context).error.withOpacity(0.6)),
                      ),
                      Text(
                        'non Supr.',
                        style: textTheme(context).bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: colorScheme(context).error.withOpacity(0.6)),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '    We’re soon launching a wallet made for Supr,\ndesigned for smooth, one-tap checkouts. Stay tuned!',
                        style: textTheme(context).bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: colorScheme(context)
                                .onSurface
                                .withOpacity(0.4)),
                      ),
                      SizedBox(height: 12),
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 240, 215, 172),
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                          child: Text(
                            'For any queries regarding your Supr Money balance\n  please contact   suprtechnology@gmail.com',
                            style: textTheme(context).bodySmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: colorScheme(context)
                                    .error
                                    .withOpacity(0.3)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Opacity(
                  opacity: 0.3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Enjoy seamless',
                          style: textTheme(context).titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff0A0C0B)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'one tap payments',
                        style: textTheme(context).titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff0A0C0B)),
                      ),
                      const SizedBox(height: 12),
                      Image.network(
                        'https://c8.alamy.com/comp/2B0NR05/wallet-icon-in-trendy-flat-style-isolated-on-grey-background-wallet-symbol-for-your-web-site-design-logo-app-ui-vector-illustration-eps10-2B0NR05.jpg', // same icon as above
                        height: 40,
                      ),
                      const Text(
                        'supr\nMONEY',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
