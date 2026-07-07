import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/miso_components.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key});

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen>
    with TickerProviderStateMixin {
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 3));
  int _selectedTimeIndex = 2;
  int _guestCount = 2;
  String _selectedSeating = 'Dining Room';
  bool _showConfirmation = false;
  late AnimationController _confirmAnimController;

  final List<String> _times = [
    '6:00 PM',
    '6:30 PM',
    '7:00 PM',
    '7:30 PM',
    '8:00 PM',
    '8:30 PM',
    '9:00 PM',
  ];

  final List<_SeatingOption> _seatingOptions = const [
    _SeatingOption(
      name: 'Dining Room',
      description: 'The full kaiseki experience amid seasonal ikebana',
      icon: Icons.restaurant_outlined,
    ),
    _SeatingOption(
      name: "Chef's Table",
      description: 'Intimate counter seating with kitchen theatre',
      icon: Icons.person_outline,
    ),
    _SeatingOption(
      name: 'Tatami Room',
      description: 'Private room with floor seating & garden view',
      icon: Icons.spa_outlined,
    ),
    _SeatingOption(
      name: 'Sake Bar',
      description: 'Curated sake flights paired with small plates',
      icon: Icons.local_bar_outlined,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _confirmAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
  }

  @override
  void dispose() {
    _confirmAnimController.dispose();
    super.dispose();
  }

  void _confirmReservation() async {
    setState(() => _showConfirmation = true);
    _confirmAnimController.forward();
    await Future.delayed(const Duration(milliseconds: 3000));
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.deepIndigo,
        body: Stack(
          children: [
            // Main Content
            CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // -- Cinematic Hero Header ----------------------------------
                SliverToBoxAdapter(child: _buildHero(context)),

                // -- Date Selection -----------------------------------------
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
                  sliver: SliverToBoxAdapter(child: _buildDateSelector()),
                ),

                // -- Time Selection -----------------------------------------
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
                  sliver: SliverToBoxAdapter(child: _buildTimeSelector()),
                ),

                // -- Guests -------------------------------------------------
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
                  sliver: SliverToBoxAdapter(child: _buildGuestSelector()),
                ),

                // -- Seating Experience -------------------------------------
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
                  sliver: SliverToBoxAdapter(child: _buildSeatingSelector()),
                ),

                // -- Dress & Arrival Notes ----------------------------------
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
                  sliver: SliverToBoxAdapter(child: _buildArrivalNotes()),
                ),

                // -- Personal Note ------------------------------------------
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
                  sliver: SliverToBoxAdapter(child: _buildPersonalNote()),
                ),

                // -- Reserve Button -----------------------------------------
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 60),
                  sliver: SliverToBoxAdapter(child: _buildReserveButton()),
                ),
              ],
            ),

            // -- Ceremonial Confirmation Overlay ----------------------------
            if (_showConfirmation) _buildConfirmationOverlay(),
          ],
        ),
      ),
    );
  }

  Widget _buildHero(BuildContext context) {
    return Stack(
      children: [
        const SizedBox(
          height: 260,
          width: double.infinity,
          child: MisoNetworkImage(
            imageUrl:
                'https://images.unsplash.com/photo-1611143669185-af224c5e3252?auto=format&fit=crop&q=80&w=1200',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          height: 260,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.3),
                AppColors.deepIndigo,
              ],
              stops: const [0.3, 1.0],
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: GestureDetector(
              onTap: () => context.pop(),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withValues(alpha: 0.35),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                ),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 24,
          left: 24,
          right: 24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'KYOTO KAISEKI',
                style: GoogleFonts.inter(
                  fontSize: 9,
                  color: AppColors.lotusGold,
                  letterSpacing: 3.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Reserve Your\nExperience',
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 34,
                  color: AppColors.softIvory,
                  fontWeight: FontWeight.w400,
                  height: 1.1,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDateSelector() {
    // Generate the next 14 days
    final dates = List.generate(14, (i) {
      return DateTime.now().add(Duration(days: i + 1));
    });
    final dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final monthNames = [
      'Jan\', \'Feb\', \'Mar\', \'Apr\', \'May\', \'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('SELECT DATE'),
        const SizedBox(height: 16),
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: dates.length,
            itemBuilder: (context, index) {
              final date = dates[index];
              final isSelected = date.day == _selectedDate.day &&
                  date.month == _selectedDate.month;
              final dayName = dayNames[date.weekday - 1];

              return GestureDetector(
                onTap: () => setState(() => _selectedDate = date),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(right: 10),
                  width: 58,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: isSelected
                        ? AppColors.lotusGold.withValues(alpha: 0.15)
                        : AppColors.darkSlate,
                    border: Border.all(
                      color: isSelected
                          ? AppColors.lotusGold.withValues(alpha: 0.5)
                          : AppColors.softIvory.withValues(alpha: 0.06),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        dayName.toUpperCase(),
                        style: GoogleFonts.inter(
                          fontSize: 8,
                          color: isSelected
                              ? AppColors.lotusGold
                              : AppColors.softIvory.withValues(alpha: 0.35),
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${date.day}',
                        style: GoogleFonts.cormorantGaramond(
                          fontSize: 24,
                          color: isSelected
                              ? AppColors.softIvory
                              : AppColors.softIvory.withValues(alpha: 0.5),
                          fontWeight: FontWeight.w400,
                          height: 1,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        monthNames[date.month - 1].toUpperCase(),
                        style: GoogleFonts.inter(
                          fontSize: 8,
                          color: isSelected
                              ? AppColors.lotusGold.withValues(alpha: 0.7)
                              : AppColors.softIvory.withValues(alpha: 0.25),
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ).animate().fade(delay: 200.ms, duration: 600.ms);
  }

  Widget _buildTimeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('SELECT TIME'),
        const SizedBox(height: 16),
        SizedBox(
          height: 44,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: _times.length,
            itemBuilder: (context, index) {
              final isSelected = index == _selectedTimeIndex;
              return GestureDetector(
                onTap: () => setState(() => _selectedTimeIndex = index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: isSelected
                        ? AppColors.lotusGold.withValues(alpha: 0.15)
                        : AppColors.darkSlate,
                    border: Border.all(
                      color: isSelected
                          ? AppColors.lotusGold.withValues(alpha: 0.5)
                          : AppColors.softIvory.withValues(alpha: 0.06),
                    ),
                  ),
                  child: Text(
                    _times[index],
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: isSelected
                          ? AppColors.softIvory
                          : AppColors.softIvory.withValues(alpha: 0.45),
                      fontWeight: isSelected ? FontWeight.w400 : FontWeight.w300,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ).animate().fade(delay: 300.ms, duration: 600.ms);
  }

  Widget _buildGuestSelector() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.darkSlate,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.softIvory.withValues(alpha: 0.04)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.people_outline,
            color: AppColors.lotusGold,
            size: 18,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'GUESTS',
                  style: GoogleFonts.inter(
                    fontSize: 9,
                    color: AppColors.lotusGold,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$_guestCount ${_guestCount == 1 ? "Guest" : "Guests"}',
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 20,
                    color: AppColors.softIvory,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              _GuestButton(
                icon: Icons.remove,
                onTap: () {
                  if (_guestCount > 1) setState(() => _guestCount--);
                },
                enabled: _guestCount > 1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  '$_guestCount',
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 24,
                    color: AppColors.softIvory,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              _GuestButton(
                icon: Icons.add,
                onTap: () {
                  if (_guestCount < 10) setState(() => _guestCount++);
                },
                enabled: _guestCount < 10,
              ),
            ],
          ),
        ],
      ),
    ).animate().fade(delay: 400.ms, duration: 600.ms);
  }

  Widget _buildSeatingSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('SEATING EXPERIENCE'),
        const SizedBox(height: 16),
        ...List.generate(_seatingOptions.length, (index) {
          final option = _seatingOptions[index];
          final isSelected = option.name == _selectedSeating;
          return GestureDetector(
            onTap: () => setState(() => _selectedSeating = option.name),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: isSelected
                    ? AppColors.lotusGold.withValues(alpha: 0.08)
                    : AppColors.darkSlate,
                border: Border.all(
                  color: isSelected
                      ? AppColors.lotusGold.withValues(alpha: 0.35)
                      : AppColors.softIvory.withValues(alpha: 0.04),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected
                          ? AppColors.lotusGold.withValues(alpha: 0.15)
                          : AppColors.softIvory.withValues(alpha: 0.04),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.lotusGold.withValues(alpha: 0.3)
                            : AppColors.softIvory.withValues(alpha: 0.06),
                      ),
                    ),
                    child: Icon(
                      option.icon,
                      color: isSelected
                          ? AppColors.lotusGold
                          : AppColors.softIvory.withValues(alpha: 0.3),
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          option.name,
                          style: GoogleFonts.cormorantGaramond(
                            fontSize: 18,
                            color: isSelected
                                ? AppColors.softIvory
                                : AppColors.softIvory.withValues(alpha: 0.6),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          option.description,
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            color: AppColors.softIvory.withValues(alpha: 0.35),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isSelected)
                    const Icon(
                      Icons.check,
                      color: AppColors.lotusGold,
                      size: 14,
                    ),
                ],
              ),
            ),
          );
        }),
      ],
    ).animate().fade(delay: 500.ms, duration: 600.ms);
  }

  Widget _buildArrivalNotes() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.darkSlate,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.softIvory.withValues(alpha: 0.04)),
      ),
      child: Column(
        children: [
          _buildInfoRow(
            Icons.watch_later_outlined,
            'Expected Duration',
            'Approximately 2.5-3 hours',
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1, color: Color(0xFF2A2A2A)),
          ),
          _buildInfoRow(
            Icons.checkroom_outlined,
            'Dress Suggestion',
            'Smart casual — No shorts or sportswear',
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1, color: Color(0xFF2A2A2A)),
          ),
          _buildInfoRow(
            Icons.wb_sunny_outlined,
            'Recommended Arrival',
            '15 minutes before your reservation',
          ),
        ],
      ),
    ).animate().fade(delay: 600.ms, duration: 600.ms);
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.lotusGold.withValues(alpha: 0.6), size: 16),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 9,
                  color: AppColors.softIvory.withValues(alpha: 0.4),
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: AppColors.softIvory.withValues(alpha: 0.75),
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPersonalNote() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('PERSONAL NOTE'),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: AppColors.darkSlate,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.softIvory.withValues(alpha: 0.04)),
          ),
          child: TextField(
            maxLines: 4,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: AppColors.softIvory.withValues(alpha: 0.8),
              fontWeight: FontWeight.w300,
              height: 1.6,
            ),
            decoration: InputDecoration(
              hintText:
                  'Anniversary dinner, dietary requirements, or anything the chef should know...',
              hintStyle: GoogleFonts.inter(
                fontSize: 13,
                color: AppColors.softIvory.withValues(alpha: 0.25),
                fontWeight: FontWeight.w300,
                height: 1.6,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(20),
            ),
            cursorColor: AppColors.lotusGold,
            cursorWidth: 1,
          ),
        ),
      ],
    ).animate().fade(delay: 700.ms, duration: 600.ms);
  }

  Widget _buildReserveButton() {
    return GestureDetector(
      onTap: _confirmReservation,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.lotusGold.withValues(alpha: 0.9),
              AppColors.lotusGold.withValues(alpha: 0.6),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.lotusGold.withValues(alpha: 0.2),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              'CONFIRM RESERVATION',
              style: GoogleFonts.inter(
                fontSize: 12,
                color: AppColors.charcoalBlack,
                letterSpacing: 2.5,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '$_guestCount guests · ${_times[_selectedTimeIndex]}',
              style: GoogleFonts.inter(
                fontSize: 11,
                color: AppColors.charcoalBlack.withValues(alpha: 0.6),
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    ).animate().fade(delay: 800.ms, duration: 600.ms).slideY(
          begin: 0.05,
          end: 0,
          curve: Curves.easeOutCubic,
        );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 1,
          color: AppColors.lotusGold.withValues(alpha: 0.4),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 9,
            color: AppColors.lotusGold,
            letterSpacing: 2.5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // -- Ceremonial Confirmation Overlay ----------------------------------------

  Widget _buildConfirmationOverlay() {
    return Positioned.fill(
      child: GestureDetector(
        onTap: () {},
        child: Container(
          color: Colors.black.withValues(alpha: 0.85),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Gold ring animation
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.lotusGold.withValues(alpha: 0.4),
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.lotusGold.withValues(alpha: 0.12),
                      border: Border.all(
                        color: AppColors.lotusGold.withValues(alpha: 0.5),
                        width: 1,
                      ),
                    ),
                    child: const Icon(
                      Icons.check,
                      color: AppColors.lotusGold,
                      size: 28,
                    ),
                  ),
                ),
              )
                  .animate()
                  .scale(
                    begin: const Offset(0.6, 0.6),
                    end: const Offset(1, 1),
                    duration: 600.ms,
                    curve: Curves.elasticOut,
                  )
                  .fade(duration: 400.ms),
              const SizedBox(height: 40),
              Text(
                'Your table is reserved',
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 32,
                  color: AppColors.softIvory,
                  fontWeight: FontWeight.w300,
                  letterSpacing: -0.5,
                ),
              )
                  .animate()
                  .fade(delay: 400.ms, duration: 600.ms)
                  .slideY(begin: 0.1, end: 0),
              const SizedBox(height: 16),
              Text(
                'Kyoto Kaiseki · ${_times[_selectedTimeIndex]}',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: AppColors.lotusGold.withValues(alpha: 0.7),
                  fontWeight: FontWeight.w300,
                  letterSpacing: 0.5,
                ),
              ).animate().fade(delay: 600.ms, duration: 600.ms),
              const SizedBox(height: 10),
              Text(
                '$_guestCount guests · $_selectedSeating',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: AppColors.softIvory.withValues(alpha: 0.4),
                  fontWeight: FontWeight.w300,
                ),
              ).animate().fade(delay: 700.ms, duration: 600.ms),
              const SizedBox(height: 48),
              Text(
                'A confirmation has been sent to\nyour registered email address.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: AppColors.softIvory.withValues(alpha: 0.3),
                  fontWeight: FontWeight.w300,
                  height: 1.6,
                ),
              ).animate().fade(delay: 900.ms, duration: 600.ms),
            ],
          ),
        ),
      ),
    );
  }
}

class _SeatingOption {
  final String name;
  final String description;
  final IconData icon;

  const _SeatingOption({
    required this.name,
    required this.description,
    required this.icon,
  });
}

class _GuestButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool enabled;

  const _GuestButton({
    required this.icon,
    required this.onTap,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: enabled
                ? AppColors.lotusGold.withValues(alpha: 0.3)
                : AppColors.softIvory.withValues(alpha: 0.08),
          ),
        ),
        child: Icon(
          icon,
          size: 14,
          color: enabled
              ? AppColors.lotusGold
              : AppColors.softIvory.withValues(alpha: 0.2),
        ),
      ),
    );
  }
}
