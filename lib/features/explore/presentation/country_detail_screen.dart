import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../data/mock_explore_repository.dart';
import '../domain/models/dish.dart';

class CountryDetailScreen extends ConsumerWidget {
  final String countryId;

  const CountryDetailScreen({super.key, required this.countryId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final country = ref.watch(exploreRepositoryProvider).getCountry(countryId);
    final dishes = ref.watch(countryDishesProvider(countryId));

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                country.name,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppColors.softIvory,
                ),
              ),
              background: Hero(
                tag: 'country_image_${country.id}',
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      country.imageUrl,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            AppColors.charcoalBlack.withValues(alpha: 0.8),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
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
              padding: const EdgeInsets.all(24.0),
              child: Text(
                country.description,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ).animate().fade(duration: 400.ms).slideY(begin: 0.1, end: 0),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final dish = dishes[index];
                  return _DishListItem(dish: dish)
                      .animate()
                      .fade(delay: (100 + (index * 50)).ms)
                      .slideX(begin: 0.1, end: 0);
                },
                childCount: dishes.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 48)), // Bottom padding
        ],
      ),
    );
  }
}

class _DishListItem extends StatelessWidget {
  final Dish dish;

  const _DishListItem({required this.dish});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/dish/${dish.id}'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
          color: AppColors.riceWhite,
          borderRadius: BorderRadius.circular(2),
          boxShadow: [
            BoxShadow(
              color: AppColors.charcoalBlack.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Hero(
              tag: 'dish_image_${dish.id}',
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.horizontal(left: Radius.circular(2)),
                  image: DecorationImage(
                    image: NetworkImage(dish.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dish.name,
                      style: Theme.of(context).textTheme.titleLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      dish.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.local_fire_department, size: 16, color: AppColors.teaBrown),
                        const SizedBox(width: 4),
                        Text(
                          'Spice: ${dish.spiceLevel}/5',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
