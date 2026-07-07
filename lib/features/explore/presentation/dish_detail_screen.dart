import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/mock_explore_repository.dart';
import '../../../shared/widgets/miso_components.dart';

class DishDetailScreen extends ConsumerWidget {
  final String dishId;
  
  const DishDetailScreen({super.key, required this.dishId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const bgColor = Color(0xFF2C4C3B);
    const goldAccent = Color(0xFFC6A25A);
    const textPrimary = Color(0xFFE8D8A7);
    const textSecondary = Color(0xFF8B8A87);

    final dish = ref.watch(exploreRepositoryProvider).getDish(dishId);

    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // Parallax Hero Image
              SliverAppBar(
                expandedHeight: 450.0,
                pinned: true,
                backgroundColor: bgColor,
                elevation: 0,
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withValues(alpha: 0.5),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => context.pop(),
                    ),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: 'dish_image_${dish.id}',
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        MisoNetworkImage(
                          imageUrl: dish.imageUrl,
                          fit: BoxFit.cover,
                        ),
                        // Dark gradient at bottom
                        const DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, bgColor],
                              stops: [0.6, 1.0],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Badges
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: goldAccent.withValues(alpha: 0.1),
                              border: Border.all(color: goldAccent.withValues(alpha: 0.3)),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              dish.dietaryTags.isNotEmpty 
                                  ? dish.dietaryTags.join(' • ').toUpperCase() 
                                  : 'SIGNATURE DISH',
                              style: GoogleFonts.inter(
                                fontSize: 9,
                                color: goldAccent,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(Icons.eco_outlined, color: Colors.green.withValues(alpha: 0.8), size: 18),
                        ],
                      ).animate().fade(duration: 400.ms),
                      
                      const SizedBox(height: 16),
                      
                      // Title & Price
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              dish.name,
                              style: GoogleFonts.cormorantGaramond(
                                fontSize: 40,
                                color: textPrimary,
                                fontWeight: FontWeight.w600,
                                height: 1.1,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            '\$42',
                            style: GoogleFonts.cormorantGaramond(
                              fontSize: 32,
                              color: goldAccent,
                            ),
                          ),
                        ],
                      ).animate().fade(delay: 100.ms),
                      
                      const SizedBox(height: 24),
                      
                      // Story / Description
                      Text(
                        dish.description,
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          color: textSecondary,
                          height: 1.6,
                        ),
                      ).animate().fade(delay: 200.ms),

                      if (dish.history.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        Text(
                          dish.history,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: textSecondary.withValues(alpha: 0.8),
                            height: 1.6,
                            fontStyle: FontStyle.italic,
                          ),
                        ).animate().fade(delay: 250.ms),
                      ],
                      
                      const SizedBox(height: 32),
                      const Divider(color: Color(0xFF222222)),
                      const SizedBox(height: 32),
                      
                      // Pairings & Nutrition
                      if (dish.recommendedPairings.isNotEmpty) ...[
                        Text(
                          'RECOMMENDED PAIRINGS',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            letterSpacing: 2.0,
                            color: textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ).animate().fade(delay: 300.ms),
                        const SizedBox(height: 16),
                        ...dish.recommendedPairings.map((pairing) => Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Row(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFF1E1E1E),
                                  border: Border.all(color: goldAccent.withValues(alpha: 0.3)),
                                ),
                                child: const Icon(Icons.local_drink, color: goldAccent, size: 20),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  pairing,
                                  style: GoogleFonts.cormorantGaramond(
                                    fontSize: 18,
                                    color: textPrimary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )).toList().animate().fade(delay: 400.ms),
                        const SizedBox(height: 32),
                        const Divider(color: Color(0xFF222222)),
                        const SizedBox(height: 32),
                      ],
                      
                      // Ingredients
                      if (dish.ingredients.isNotEmpty) ...[
                        Text(
                          'KEY INGREDIENTS',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            letterSpacing: 2.0,
                            color: textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ).animate().fade(delay: 500.ms),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: dish.ingredients
                              .map((ingredient) => _buildIngredientChip(ingredient))
                              .toList(),
                        ).animate().fade(delay: 600.ms),
                      ],
                      
                      const SizedBox(height: 140), // Space for sticky button
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          // Floating Add to Cart Button
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.only(top: 24, bottom: 48, left: 24, right: 24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    bgColor,
                    bgColor.withValues(alpha: 0.9),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Row(
                children: [
                  // Quantity Selector
                  Container(
                    height: 64,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove, color: textPrimary),
                          onPressed: () {},
                        ),
                        Text(
                          '1',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            color: textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add, color: goldAccent),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Add Button
                  Expanded(
                    child: Container(
                      height: 64,
                      decoration: BoxDecoration(
                        color: goldAccent,
                        borderRadius: BorderRadius.circular(32),
                        boxShadow: [
                          BoxShadow(
                            color: goldAccent.withValues(alpha: 0.2),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Add to Order',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIngredientChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF161616),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 13,
          color: const Color(0xFFE8D8A7).withValues(alpha: 0.9),
        ),
      ),
    );
  }
}
