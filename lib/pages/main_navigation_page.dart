// 📁 lib/pages/home_page.dart (fixed layout so login buttons appear)
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Map<String, String> pelabuhanLpiData = {
    'Patimban': 'LPI: 3.7 — Regional RoRo & Export Hub',
    'Tanjung Priok': 'LPI: 3.2 — Indonesia’s primary container gateway',
    'Belawan': 'LPI: 2.9 — Main port in western Indonesia',
  };

  String? selectedPelabuhan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          color: Colors.indigo,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                'LOGINIZER',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Smart Logistics Coordination',
                style: TextStyle(fontSize: 13, color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Image.asset(
                'assets/images/LogoProduct.png',
                width: 120,
                height: 120,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 24),
            const Center(
              child: Text(
                'Choose your option:',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 32),

            // 🔐 Login Buttons
            ElevatedButton.icon(
              icon: Icon(Icons.local_shipping),
              label: Text('Login Driver Truk'),
              onPressed: () => Navigator.pushNamed(context, '/track'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: Size(double.infinity, 48),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              icon: Icon(Icons.person),
              label: Text('Login Cargo Owner'),
              onPressed: () => Navigator.pushNamed(context, '/owner-login'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: Size(double.infinity, 48),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              icon: Icon(Icons.directions_boat),
              label: Text('Login Agen Kapal'),
              onPressed: () => Navigator.pushNamed(context, '/agent-login'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: Size(double.infinity, 48),
              ),
            ),

            const SizedBox(height: 32),
            Text(
              'Quick Access',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              childAspectRatio: 1.2,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildMenuCard(
                  context,
                  icon: Icons.directions_boat,
                  label: 'Vessel Order',
                  color: Colors.blue,
                  route: '/order_kapal',
                ),
                _buildMenuCard(
                  context,
                  icon: Icons.local_shipping,
                  label: 'Truck Order',
                  color: Colors.green,
                  route: '/order_truk',
                ),
              ],
            ),

            const SizedBox(height: 40),
            const Divider(height: 1, thickness: 1),
            const SizedBox(height: 20),
            const Text(
              'Logistics Performance Index',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Select Port',
                border: OutlineInputBorder(),
              ),
              value: selectedPelabuhan,
              items: pelabuhanLpiData.keys.map((port) {
                return DropdownMenuItem<String>(value: port, child: Text(port));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedPelabuhan = value;
                });
              },
            ),
            const SizedBox(height: 12),
            if (selectedPelabuhan != null)
              Text(
                pelabuhanLpiData[selectedPelabuhan!] ?? '',
                style: const TextStyle(
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                ),
              ),
            const SizedBox(height: 24),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.2,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                _GaugeCard(
                  title: 'ET:BT Ratio',
                  value: '0.82',
                  icon: LucideIcons.activity,
                ),
                _GaugeCard(
                  title: 'YOR (%)',
                  value: '67',
                  icon: LucideIcons.package,
                ),
                _GaugeCard(
                  title: 'Vessel Readiness',
                  value: '92%',
                  icon: LucideIcons.ship,
                ),
                _GaugeCard(
                  title: 'Truck Readiness',
                  value: '81%',
                  icon: LucideIcons.truck,
                ),
                _GaugeCard(
                  title: 'Delay Alerts',
                  value: '3',
                  icon: LucideIcons.alertTriangle,
                ),
                _GaugeCard(
                  title: 'BOR (%)',
                  value: '74',
                  icon: LucideIcons.alignVerticalSpaceAround,
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Divider(thickness: 1),
            const SizedBox(height: 16),
            const Text(
              'Logistics Marketplace',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.68,
              children: const [
                _MarketItem(
                  icon: Icons.local_shipping,
                  title: 'Truck Rental',
                  description:
                      'Ready-to-serve trucks for container or CBU delivery.',
                ),
                _MarketItem(
                  icon: Icons.directions_boat,
                  title: 'Vessel Charter',
                  description:
                      'Regional or domestic vessel charter for logistics.',
                ),
                _MarketItem(
                  icon: Icons.warehouse,
                  title: 'Warehouse Space',
                  description:
                      'Available storage near port or industrial zone.',
                ),
                _MarketItem(
                  icon: Icons.construction,
                  title: 'Cranes & Tools',
                  description:
                      'Rental for forklifts, cranes, and other equipment.',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required String route,
  }) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: color),
            const SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GaugeCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _GaugeCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 32),
                const SizedBox(height: 8),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(title, textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MarketItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _MarketItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Icon(icon, size: 36, color: Colors.indigo),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(100, 36),
                backgroundColor: Colors.indigo,
              ),
              child: const Text('Order', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
