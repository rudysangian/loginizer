import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ipm_web/widgets/chat_button.dart';
import 'package:ipm_web/pages/about_page.dart';
import 'package:ipm_web/pages/driver_location_page.dart';
import 'driver_login_page.dart';
import 'forwarder_dashboard.dart';
import 'forwarder_login_page.dart';
import 'shipping_login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String? selectedPort = 'Patimban';

  final Map<String, String> portLpiData = {
    'Patimban': 'LPI: 3.7 — Regional RoRo & Export Hub',
    'Tanjung Priok': 'LPI: 3.2 — Indonesia’s primary container gateway',
    'Belawan': 'LPI: 2.9 — Main port in western Indonesia',
  };

  final List<_PromoInfo> promoList = const [
    _PromoInfo(
      icon: Icons.local_shipping,
      title: 'Available Trucks for Hire',
      description:
          'Need a CBU delivery? Our fleet is ready for nationwide logistics.',
    ),
    _PromoInfo(
      icon: Icons.warehouse,
      title: 'Warehouse Space in Karawang',
      description:
          'Safe & dry storage ideal for automotive and industrial cargo.',
    ),
    _PromoInfo(
      icon: Icons.business,
      title: 'PT Logistik Pintar Nusantara',
      description:
          'Trusted by 100+ exporters. See how we help streamline your supply chain.',
    ),
  ];

  void _handleForwarderClick() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    final name = prefs.getString('forwarderName') ?? '';

    if (isLoggedIn && name.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ForwarderDashboard(forwarderName: name),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ForwarderLoginPage()),
      );
    }
  }

  void _handleDriverClick() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DriverLoginPage()),
    );
  }

  void _handleShippingClick() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ShippingLoginPage()),
    );
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _selectedIndex == 1
          ? const DriverLocationPage()
          : _selectedIndex == 2
          ? const AboutPage()
          : _buildHomeContent(context),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Track'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Info'),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
      ),
    );
  }

  Widget _buildHomeContent(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth > 1000;
    final maxWidth = isWide ? 1000.0 : screenWidth * 0.95;

    return SafeArea(
      child: Center(
        child: Container(
          width: maxWidth,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: _TopMenuBar(
                  onChatPressed: () => showChatForm(context),
                  onForwarderTap: _handleForwarderClick,
                  onDriverTap: _handleDriverClick,
                  onShippingTap: _handleShippingClick,
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: 16),
                  Center(
                    child: Image.asset(
                      'assets/images/LogoProduct.png',
                      width: isWide ? 120 : 90,
                      height: isWide ? 120 : 90,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Smart Logistics Coordination Tools',
                    style: TextStyle(
                      fontSize: isWide ? 16 : 13,
                      color: Colors.black87,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Select Port',
                        border: OutlineInputBorder(),
                      ),
                      value: selectedPort,
                      items: portLpiData.keys.map((port) {
                        return DropdownMenuItem<String>(
                          value: port,
                          child: Text(port),
                        );
                      }).toList(),
                      onChanged: (value) =>
                          setState(() => selectedPort = value),
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (selectedPort != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        portLpiData[selectedPort!] ?? '',
                        style: const TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),

                  const SizedBox(height: 24),
                  Text(
                    'Current Logistics Metrics',
                    style: TextStyle(
                      fontSize: isWide ? 18 : 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      alignment: WrapAlignment.center,
                      children: const [
                        _StatBox(
                          title: 'ET:BT Ratio',
                          value: '0.82',
                          icon: LucideIcons.activity,
                        ),
                        _StatBox(
                          title: 'YOR (%)',
                          value: '67',
                          icon: LucideIcons.package,
                        ),
                        _StatBox(
                          title: 'BOR (%)',
                          value: '74',
                          icon: LucideIcons.alignVerticalSpaceAround,
                        ),
                        _StatBox(
                          title: 'Productivity',
                          value: '132',
                          icon: LucideIcons.trendingUp,
                        ),
                        _StatBox(
                          title: 'Delay Alerts',
                          value: '3',
                          icon: LucideIcons.alertTriangle,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),
                  Text(
                    'Featured Logistics Services',
                    style: TextStyle(
                      fontSize: isWide ? 18 : 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final crossAxisCount = constraints.maxWidth > 900
                            ? 3
                            : constraints.maxWidth > 600
                            ? 2
                            : 1;

                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 16,
                                childAspectRatio: 3.8,
                              ),
                          itemCount: promoList.length,
                          itemBuilder: (context, index) {
                            final promo = promoList[index];
                            return Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: Colors.indigo.shade50,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      promo.icon,
                                      size: 28,
                                      color: Colors.indigo,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          promo.title,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          promo.description,
                                          style: const TextStyle(fontSize: 13),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 40),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopMenuBar extends SliverPersistentHeaderDelegate {
  final VoidCallback onChatPressed;
  final VoidCallback onForwarderTap;
  final VoidCallback onDriverTap;
  final VoidCallback onShippingTap;

  const _TopMenuBar({
    required this.onChatPressed,
    required this.onForwarderTap,
    required this.onDriverTap,
    required this.onShippingTap,
  });

  @override
  double get minExtent => 60;
  @override
  double get maxExtent => 60;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final isWide = MediaQuery.of(context).size.width > 600;

    return Material(
      color: Colors.white,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: isWide
              ? MainAxisAlignment.spaceAround
              : MainAxisAlignment.spaceBetween,
          children: [
            _roleButton(Icons.business, 'Forwarder', onTap: onForwarderTap),
            _roleButton(Icons.local_shipping, 'Driver', onTap: onDriverTap),
            _roleButton(
              Icons.directions_boat,
              'Shipping',
              onTap: onShippingTap,
            ),
            _roleButton(Icons.chat, 'AI Chat', onTap: onChatPressed),
          ],
        ),
      ),
    );
  }

  Widget _roleButton(IconData icon, String label, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20, color: Colors.indigo),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 10)),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

class _StatBox extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _StatBox({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 22, color: Colors.indigo),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(fontSize: 11),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _PromoInfo {
  final IconData icon;
  final String title;
  final String description;

  const _PromoInfo({
    required this.icon,
    required this.title,
    required this.description,
  });
}
