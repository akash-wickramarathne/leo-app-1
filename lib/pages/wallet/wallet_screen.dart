import 'package:flutter/material.dart';
import 'package:leo_final/pages/payment/payment_screen.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade200,
              Colors.blue.shade800,
            ],
          ),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/balance.jpeg'), // Replace with your background image
                      fit: BoxFit.cover,
                      opacity: 0.7,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.menu_rounded, color: Colors.white),
                      onPressed: () {},
                    ),
                  ],
                  title: const Text(
                    'Wallet',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(left: 20),
                  child: _buildBalanceWidget(),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.blue.shade200,
                          Colors.blue.shade800,
                        ],
                      ),
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Recharge Channel',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              children: const [
                                Text('Saudi Arabia',
                                    style: TextStyle(color: Colors.white)),
                                SizedBox(width: 8),
                                Icon(Icons.arrow_drop_down,
                                    color: Colors.white),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        _buildRechargeChannel(
                            'Google Pay', 'assets/images/google_pay.png'),
                        _buildRechargeChannel('VISA/MASTERCARD',
                            'assets/images/visa_mastercard.png'),
                        // _buildRechargeChannel('MADA', 'assets/images/mada.png'),
                        // _buildRechargeChannel('STC Pay', 'assets/images/stcpay.png'),
                        const SizedBox(height: 16),
                        Expanded(
                          child: GridView.count(
                            crossAxisCount: 3,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            children: [
                              _buildDiamondPackage(context, 1260, 10),
                              _buildDiamondPackage(context, 6300, 50),
                              _buildDiamondPackage(context, 18900, 150),
                              _buildDiamondPackage(context, 37800, 300),
                              _buildDiamondPackage(context, 63000, 500),
                              _buildDiamondPackage(context, 126000, 1000),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceWidget() {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Balance',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '0',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRechargeChannel(String name, String asset) {
    return Card(
      color: Colors.white,
      child: ListTile(
        leading: Image.asset(asset, width: 40),
        title: Text(name),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.blue),
        onTap: () {},
      ),
    );
  }

  Widget _buildDiamondPackage(BuildContext context, int diamonds, int price) {
    return GestureDetector(
      onTap: () {
        // Navigate to payment page and pass data
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentPage(diamond: diamonds, amount: price),
          ),
        );
      },
      child: Card(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/diamond.png',
              width: 60,
            ),
            const SizedBox(height: 2),
            Text(
              '$diamonds',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'USD $price',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
