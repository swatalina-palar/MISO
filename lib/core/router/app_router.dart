import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/onboarding/presentation/splash_screen.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/explore/presentation/country_detail_screen.dart';
import '../../features/explore/presentation/dish_detail_screen.dart';
import '../../features/explore/presentation/discover_screen.dart';
import '../../features/explore/presentation/restaurant_details_screen.dart';
import '../../features/explore/presentation/menu_screen.dart';
import '../../features/reservations/presentation/reservation_screen.dart';
import '../../features/orders/presentation/cart_screen.dart';
import '../../features/orders/presentation/order_tracking_screen.dart';
import '../../features/profile/presentation/rewards_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/concierge/presentation/concierge_screen.dart';
import '../../features/profile/presentation/culinary_passport_screen.dart';
import '../../features/profile/presentation/settings_screen.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/discover',
        builder: (context, state) => const DiscoverScreen(),
      ),
      GoRoute(
        path: '/country/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return CountryDetailScreen(countryId: id);
        },
      ),
      GoRoute(
        path: '/dish/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return DishDetailScreen(dishId: id);
        },
      ),
      GoRoute(
        path: '/restaurant/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return RestaurantDetailsScreen(restaurantId: id);
        },
      ),
      GoRoute(
        path: '/restaurant/:id/menu',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return MenuScreen(restaurantId: id);
        },
      ),
      GoRoute(
        path: '/reservation',
        builder: (context, state) => const ReservationScreen(),
      ),
      GoRoute(
        path: '/cart',
        builder: (context, state) => const CartScreen(),
      ),
      GoRoute(
        path: '/order_tracking',
        builder: (context, state) => const OrderTrackingScreen(),
      ),
      GoRoute(
        path: '/rewards',
        builder: (context, state) => const RewardsScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/concierge',
        builder: (context, state) => const ConciergeScreen(),
      ),
      GoRoute(
        path: '/passport',
        builder: (context, state) => const CulinaryPassportScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
});
