import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const bgColor = Color(0xFF2C4C3B);
    const goldAccent = Color(0xFFC6A25A);
    const textPrimary = Color(0xFFE8D8A7);
    const textSecondary = Color(0xFF8B8A87);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        title: Text(
          'Your Order',
          style: GoogleFonts.cormorantGaramond(
            fontSize: 28,
            color: textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(24.0),
                children: [
                  // Order Items
                  _buildCartItem('A5 Wagyu Truffle Maki', '\$42.00', 1),
                  const SizedBox(height: 24),
                  _buildCartItem('Matcha Opera Cake', '\$16.00', 2),
                  
                  const SizedBox(height: 32),
                  const Divider(color: Color(0xFF222222)),
                  const SizedBox(height: 32),
                  
                  // Promo Code
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF161616),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.local_offer_outlined, color: textSecondary, size: 20),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            style: GoogleFonts.inter(color: textPrimary),
                            decoration: InputDecoration(
                              hintText: 'Add a promo code',
                              hintStyle: GoogleFonts.inter(color: textSecondary),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Text(
                          'Apply',
                          style: GoogleFonts.inter(
                            color: goldAccent,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Receipt Summary
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xFF161616),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                    ),
                    child: Column(
                      children: [
                        _buildReceiptRow('Subtotal', '\$74.00'),
                        const SizedBox(height: 16),
                        _buildReceiptRow('Taxes & Fees', '\$6.50'),
                        const SizedBox(height: 16),
                        _buildReceiptRow('Delivery', '\$5.00'),
                        const SizedBox(height: 24),
                        const Divider(color: Color(0xFF333333)),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total',
                              style: GoogleFonts.cormorantGaramond(
                                fontSize: 24,
                                color: textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '\$85.50',
                              style: GoogleFonts.cormorantGaramond(
                                fontSize: 28,
                                color: goldAccent,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Checkout Button
            Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: const Color(0xFF0C0C0C),
                border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.05))),
              ),
              child: GestureDetector(
                onTap: () => context.push('/order_tracking'),
                child: Container(
                  height: 64,
                  decoration: BoxDecoration(
                    color: goldAccent,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Proceed to Checkout',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Icon(Icons.arrow_forward, color: Colors.black, size: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItem(String title, String price, int quantity) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
          ),
          child: const Center(child: Icon(Icons.restaurant, color: Color(0xFF333333))),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 20,
                  color: const Color(0xFFE8D8A7),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                price,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: const Color(0xFFC6A25A),
                ),
              ),
            ],
          ),
        ),
        // Mini Quantity Control
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Icon(Icons.remove, color: Color(0xFF8B8A87), size: 16),
              ),
              Text(
                quantity.toString(),
                style: GoogleFonts.inter(color: Colors.white),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Icon(Icons.add, color: Color(0xFFC6A25A), size: 16),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReceiptRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: const Color(0xFF8B8A87),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: const Color(0xFFE8D8A7),
          ),
        ),
      ],
    );
  }
}
