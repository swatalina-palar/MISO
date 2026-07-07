import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

class MenuScreen extends StatefulWidget {
  final String restaurantId;
  
  const MenuScreen({super.key, required this.restaurantId});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _selectedCategoryIndex = 0;
  
  final List<String> _categories = [
    'Signature Specials', 'Starters', 'Sushi', 'Dim Sum', 
    'Noodles', 'Rice', 'Curry', 'Desserts', 'Tea'
  ];

  final Map<String, List<Map<String, dynamic>>> _categoryItems = {
    'Signature Specials': [
      {
        'title': 'A5 Wagyu Truffle Maki',
        'description': 'Seared premium wagyu beef, black truffle shavings, gold leaf, and our signature soy glaze.',
        'price': '\$42.00',
        'image': 'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?q=80&w=1000',
      },
      {
        'title': 'Bluefin Tuna Otoro',
        'description': 'Fattiest tuna belly delicately torched with yuzu kosho and smoked sea salt.',
        'price': '\$38.00',
        'image': 'https://images.unsplash.com/photo-1534482421-64566f976cfa?q=80&w=1000',
      },
      {
        'title': 'Lobster Tempura Udon',
        'description': 'Hand-pulled udon noodles in a rich dashi broth with crispy Maine lobster tail.',
        'price': '\$32.00',
        'image': 'https://images.unsplash.com/photo-1615361200141-f45040f367be?q=80&w=1000',
      },
    ],
    'Starters': [
      {
        'title': 'Edamame with Smoked Salt',
        'description': 'Charred edamame pods tossed with cherrywood smoked sea salt.',
        'price': '\$8.00',
        'image': 'https://images.unsplash.com/photo-1574484284002-952d92456975?q=80&w=1000',
      },
      {
        'title': 'Wagyu Gyoza',
        'description': 'Pan-seared dumplings filled with minced wagyu beef and scallions, served with black vinegar.',
        'price': '\$16.00',
        'image': 'https://images.unsplash.com/photo-1496116218417-1a781b1c416c?q=80&w=1000',
      },
      {
        'title': 'Yellowtail Jalapeño',
        'description': 'Thinly sliced yellowtail with jalapeño, cilantro, and yuzu ponzu.',
        'price': '\$22.00',
        'image': 'https://images.unsplash.com/photo-1623595119708-26b1f7300075?q=80&w=1000',
      },
    ],
    'Sushi': [
      {
        'title': 'Salmon Nigiri (2pc)',
        'description': 'Premium Scottish salmon brushed with nikiri soy over warm sushi rice.',
        'price': '\$12.00',
        'image': 'https://images.unsplash.com/photo-1583623025817-d180a2221d0a?q=80&w=1000',
      },
      {
        'title': 'Spicy Tuna Crispy Rice',
        'description': 'Spicy bigeye tuna atop crispy sushi rice cakes with jalapeño slices.',
        'price': '\$18.00',
        'image': 'https://images.unsplash.com/photo-1553621042-f6e147245754?q=80&w=1000',
      },
      {
        'title': 'Dragon Roll',
        'description': 'Shrimp tempura and cucumber topped with eel, avocado, and sweet eel sauce.',
        'price': '\$24.00',
        'image': 'https://images.unsplash.com/photo-1558985250-27a406d64cb3?q=80&w=1000',
      },
    ],
    'Dim Sum': [
      {
        'title': 'Har Gow (Shrimp Dumplings)',
        'description': 'Translucent pleated dumplings filled with plump shrimp and bamboo shoots.',
        'price': '\$14.00',
        'image': 'https://images.unsplash.com/photo-1525999147711-845183393962?q=80&w=1000',
      },
      {
        'title': 'Siu Mai (Pork Dumplings)',
        'description': 'Open-faced steamed dumplings of pork, shrimp, and black mushrooms.',
        'price': '\$14.00',
        'image': 'https://images.unsplash.com/photo-1512058564366-18510be2db19?q=80&w=1000',
      },
    ],
    'Noodles': [
      {
        'title': 'Tonkotsu Ramen',
        'description': 'Rich pork bone broth with chashu pork belly, soft-boiled egg, and wood ear mushrooms.',
        'price': '\$22.00',
        'image': 'https://images.unsplash.com/photo-1557872943-16a5ac26437e?q=80&w=1000',
      },
      {
        'title': 'Spicy Dan Dan Mian',
        'description': 'Sichuan street-style noodles with spicy minced pork and sesame peanut sauce.',
        'price': '\$18.00',
        'image': 'https://images.unsplash.com/photo-1627063628093-68f445355694?q=80&w=1000',
      },
    ],
    'Rice': [
      {
        'title': 'Sizzling Stone Bibimbap',
        'description': 'Crispy rice topped with prime ribeye, seasonal namul, and gochujang sauce.',
        'price': '\$28.00',
        'image': 'https://images.unsplash.com/photo-1564834724105-918b73d1b9e0?q=80&w=1000',
      },
      {
        'title': 'Unagi Don',
        'description': 'Grilled freshwater eel glazed with sweet tare sauce over steamed rice.',
        'price': '\$34.00',
        'image': 'https://images.unsplash.com/photo-1606551381395-53841e21b798?q=80&w=1000',
      },
    ],
    'Curry': [
      {
        'title': 'Katsu Curry',
        'description': 'Crispy panko-breaded pork cutlet served with rich Japanese curry and rice.',
        'price': '\$24.00',
        'image': 'https://images.unsplash.com/photo-1604908176997-125f25cc6f3d?q=80&w=1000',
      },
    ],
    'Desserts': [
      {
        'title': 'Kyoto Matcha Tiramisu',
        'description': 'Ceremonial grade matcha dusted over mascarpone foam and adzuki bean paste.',
        'price': '\$18.00',
        'image': 'https://images.unsplash.com/photo-1563729784474-d77dbb933a9e?q=80&w=1000',
      },
      {
        'title': 'Mochi Ice Cream Trio',
        'description': 'Three flavors of premium ice cream wrapped in soft, sweet rice dough.',
        'price': '\$12.00',
        'image': 'https://images.unsplash.com/photo-1579954115545-a95591f28bfc?q=80&w=1000',
      },
    ],
    'Tea': [
      {
        'title': 'Sencha Green Tea',
        'description': 'High-grade Japanese green tea with a refreshing, grassy flavor profile.',
        'price': '\$6.00',
        'image': 'https://images.unsplash.com/photo-1576092762791-dd9e2220abd4?q=80&w=1000',
      },
      {
        'title': 'Oolong Tea',
        'description': 'Semi-oxidized traditional Chinese tea with roasted, floral notes.',
        'price': '\$6.00',
        'image': 'https://images.unsplash.com/photo-1564890369478-c89ca6d9cde9?q=80&w=1000',
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    const bgColor = Color(0xFF2C4C3B);
    const goldAccent = Color(0xFFC6A25A);
    const textPrimary = Color(0xFFE8D8A7);
    const textSecondary = Color(0xFF8B8A87);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: textPrimary, size: 20),
                      onPressed: () => context.pop(),
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Kyoto Kaiseki Menu',
                        style: TextStyle(
                          fontFamily: 'CormorantGaramond', // Fallback if font fails
                          fontSize: 24,
                          color: textPrimary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48), // Balance for back button
                ],
              ),
            ),
            
            // Sticky Category Tabs
            Container(
              height: 60,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
                ),
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final isSelected = _selectedCategoryIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategoryIndex = index;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: isSelected ? goldAccent : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          _categories[index],
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: isSelected ? goldAccent : textSecondary,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            
            // Menu Items List
            Expanded(
              child: Builder(
                builder: (context) {
                  final currentCategory = _categories[_selectedCategoryIndex];
                  final currentItems = _categoryItems[currentCategory] ?? [];
                  
                  if (currentItems.isEmpty) {
                    return const Center(
                      child: Text(
                        'Menu coming soon',
                        style: TextStyle(color: Color(0xFF8B8A87)),
                      ),
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.all(24),
                    itemCount: currentItems.length,
                    separatorBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: Divider(color: Colors.white.withValues(alpha: 0.05)),
                    ),
                    itemBuilder: (context, index) {
                      final item = currentItems[index];
                      return _buildDishCard(
                        title: item['title']!,
                        description: item['description']!,
                        price: item['price']!,
                        imageUrl: item['image']!,
                        isSignature: index == 0,
                        delay: index * 100,
                      );
                    },
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDishCard({
    required String title,
    required String description,
    required String price,
    required String imageUrl,
    required bool isSignature, 
    required int delay,
  }) {
    const goldAccent = Color(0xFFC6A25A);
    const textPrimary = Color(0xFFE8D8A7);
    const textSecondary = Color(0xFF8B8A87);
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Dish Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isSignature)
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: goldAccent.withValues(alpha: 0.1),
                    border: Border.all(color: goldAccent.withValues(alpha: 0.3)),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.stars, color: goldAccent, size: 12),
                      const SizedBox(width: 4),
                      Text(
                        'CHEF\'S RECOMMENDATION',
                        style: GoogleFonts.inter(
                          fontSize: 8,
                          color: goldAccent,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
              
              Text(
                title,
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 22,
                  color: textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              
              Text(
                description,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 12),
              
              Row(
                children: [
                  Text(
                    price,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  // Dietary / Spice icons
                  Icon(Icons.eco_outlined, color: Colors.green.withValues(alpha: 0.8), size: 16),
                  const SizedBox(width: 4),
                  Icon(Icons.whatshot, color: Colors.red.withValues(alpha: 0.8), size: 16),
                ],
              ),
            ],
          ),
        ),
        
        const SizedBox(width: 24),
        
        // Image & Add Button
        Column(
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: textPrimary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Add',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    ).animate().fade(delay: delay.ms).slideY(begin: 0.1, end: 0);
  }
}
