<div align="center">

<br/>

<img src="assets/images/miso_logo.png" alt="MISO Logo" width="80"/>

# MISO

### *Dining should feel memorable long before the first dish arrives.*

<br/>

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![Firebase](https://img.shields.io/badge/Firebase-Auth-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)](https://firebase.google.com)
[![Riverpod](https://img.shields.io/badge/Riverpod-2.x-00B4D8?style=for-the-badge)](https://riverpod.dev)
[![License](https://img.shields.io/badge/License-MIT-A8DADC?style=for-the-badge)](LICENSE)

<br/>

</div>

---

## ✦ About

**MISO** was built on a simple idea — dining should feel memorable long before the first dish arrives.

Inspired by the richness of Asian cuisine, MISO blends modern technology with luxury hospitality to create an immersive experience for discovering restaurants, reserving tables, and exploring thoughtfully curated menus with effortless elegance.

Imagine if **Apple**, **Aman Resorts**, **Airbnb Experiences**, the **Michelin Guide**, and **Muji** collaborated to create a dining platform. The result is MISO — a beautifully curated Asian lifestyle magazine where every restaurant tells a story, every dish has heritage, and every interaction creates anticipation.

---

## ✦ Screenshots

<br/>

<div align="center">

| | | |
|:---:|:---:|:---:|
| <img src="Sceenshots/1.jpeg" width="220" alt="Onboarding"/> | <img src="Sceenshots/2.jpeg" width="220" alt="Home"/> | <img src="Sceenshots/3.jpeg" width="220" alt="Explore"/> |
| *Onboarding* | *Home* | *Explore* |
| <img src="Sceenshots/4.jpeg" width="220" alt="Country Detail"/> | <img src="Sceenshots/5.jpeg" width="220" alt="Restaurant"/> | <img src="Sceenshots/6.jpeg" width="220" alt="Menu"/> |
| *Country Detail* | *Restaurant* | *Menu* |
| <img src="Sceenshots/7.jpeg" width="220" alt="Reservations"/> | <img src="Sceenshots/8.jpeg" width="220" alt="Culinary Passport"/> | <img src="Sceenshots/9.jpeg" width="220" alt="AI Concierge"/> |
| *Reservations* | *Culinary Passport* | *AI Concierge* |

</div>

---

## ✦ Core Philosophy

| Principle | Description |
|---|---|
| 🎨 **Editorial over Transactional** | Immersive curated collections — *"Taste of Kyoto"*, *"Hidden Gems of Seoul"*, *"Tokyo After Dark"* — replacing generic listings |
| 🗺️ **The Culinary Passport** | Progress through the app like a luxury travel journal. Every country explored is a beautifully designed passport page. Every restaurant visited is a collectible stamp |
| 🏯 **Cultural Adaptability** | Subtly adapts to each cuisine's culture — sakura and bamboo for Japan, jade and silk for China, celadon for Korea |
| 🎬 **Cinematic Restaurant Pages** | Restaurants are luxury destinations, presented through their philosophy, chef introductions, and architecture before ever showing a menu |
| 📖 **Editorial Menus** | Dishes presented with ingredient sourcing, preparation techniques, regional history, and chef commentary |
| 🏨 **Ceremonial Reservations** | Booking feels like reserving a luxury hotel — seating maps, ambient previews, and elegant visual feedback |
| 🤖 **AI Concierge** | Natural AI integration recommending experiences based on mood, season, weather, and travel preferences |
| ✨ **Artisanal Motion Design** | Flowing ink animations, gently drifting particles, soft steam, subtle parallax, and fluid 60fps micro-interactions |

---

## ✦ Features

- 🌏 **Pan-Asian Discovery** — Browse curated restaurants across Japan, China, Korea, Thailand, India, and more
- 🔍 **Immersive Explore** — Editorial collections and cultural deep-dives into each cuisine
- 🗓️ **Luxury Reservations** — Seamless, ceremonial table booking with seating maps
- 🛎️ **AI Concierge** — Personalized dining recommendations powered by AI
- 🧳 **Culinary Passport** — Gamified journey through Asian culinary cultures with collectible stamps
- 📋 **Editorial Menus** — Rich dish stories with sourcing, heritage, and chef commentary
- 👤 **Profile & History** — Your dining journey beautifully archived
- 🎵 **Ambient Audio** — Subtle soundscapes that match the mood of each cuisine

---

## ✦ Tech Stack

| Layer | Technology |
|---|---|
| **Framework** | Flutter 3.x (Dart 3.x) |
| **State Management** | Riverpod 2.x + Riverpod Generator |
| **Navigation** | Go Router 13.x |
| **Backend / Auth** | Firebase Core + Firebase Auth |
| **Networking** | Dio 5.x |
| **Animations** | Flutter Animate + Lottie |
| **Fonts** | Google Fonts |
| **Image Caching** | Cached Network Image |
| **Code Generation** | Freezed + JSON Serializable + Build Runner |
| **Audio** | Just Audio |

---

## ✦ Project Structure

```
miso/
├── lib/
│   ├── core/              # Theme, typography, constants, routing
│   ├── features/
│   │   ├── onboarding/    # Welcome & intro screens
│   │   ├── home/          # Home feed & editorial collections
│   │   ├── explore/       # Country & cuisine discovery
│   │   ├── reservations/  # Table booking flow
│   │   ├── orders/        # Order history & tracking
│   │   ├── concierge/     # AI Concierge chat
│   │   └── profile/       # Culinary passport & profile
│   └── shared/            # Shared widgets, models, utilities
├── assets/
│   ├── images/            # App imagery
│   ├── icons/             # Custom icon set
│   └── lottie/            # Animation files
├── docs/                  # Vision, PRD & design documentation
└── Sceenshots/            # App screenshots
```

---

## ✦ Getting Started

### Prerequisites

- Flutter SDK `>=3.3.0`
- Dart SDK `>=3.0.0`
- Firebase project configured ([setup guide](https://firebase.google.com/docs/flutter/setup))

### Installation

```bash
# 1. Clone the repository
git clone https://github.com/swatalina-palar/MISO.git
cd MISO

# 2. Install dependencies
flutter pub get

# 3. Run code generation
dart run build_runner build --delete-conflicting-outputs

# 4. Run the app
flutter run
```

---

## ✦ Design Language

MISO's visual identity is anchored in:

- **Abundant whitespace** — every screen breathes with calm intentionality
- **Ultra-thin premium line icons** — delicate, handcrafted, precise
- **Handcrafted textures** — rice paper, bamboo, ceramics, silk
- **8-point grid system** — rigorous spatial harmony
- **Refined typography** — curated Google Fonts with editorial hierarchy
- **Depth over decoration** — subtle shadows, layered surfaces, tactile materials

> *"Every screen should feel calm, intentional, timeless, and sophisticated. It should make users feel they are beginning a memorable journey through the diverse culinary cultures of Asia."*

---

## ✦ License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.

---

<div align="center">

<br/>

*Crafted with care for those who believe dining is an art.*

**MISO** — *味噌*

<br/>

</div>
