import 'package:flutter/material.dart';

final GlobalKey<State<StatefulWidget>> appKey =
    GlobalKey<State<StatefulWidget>>();

void main() {
  runApp(CoffeeCupApp(key: appKey));
}

/* ======================================================
   GLOBAL STATE
====================================================== */

bool isDark = true;
int mainTabIndex = 0; // for switching to Cart tab from Home

List<Map<String, dynamic>> cart = [];
List<Map<String, dynamic>> wishlist = [];
Map<String, double> userRatings = {};

List<Map<String, dynamic>> orders = [];
// NEW: simple notifier to trigger rebuild on theme change
final ValueNotifier<bool> themeNotifier = ValueNotifier<bool>(true);

final List<Map<String, dynamic>> products = [
  {
    "id": "1",
    "name": "Cappuccino",
    "price": 4.5,
    "image": "assets/images/cappicinno.jpg",
    "rating": 4.8,
    "description": "Classic espresso with steamed milk and foam",
    "category": "Hot Drinks",
  },
  {
    "id": "2",
    "name": "Latte",
    "price": 4.0,
    "image": "assets/images/icedlatte.jpg",
    "rating": 4.6,
    "description": "Smooth espresso with steamed milk",
    "category": "Cold Drinks",
  },
  {
    "id": "3",
    "name": "Iced Coffee",
    "price": 3.8,
    "image": "assets/images/coffeeiced.jpg",
    "rating": 4.5,
    "description": "Chilled coffee with ice cubes",
    "category": "Cold Drinks",
  },
  {
    "id": "4",
    "name": "Matcha Latte",
    "price": 4.2,
    "image": "assets/images/coffee1.jpg",
    "rating": 4.7,
    "description": "Premium matcha with steamed milk",
    "category": "Specialty",
  },
  {
    "id": "5",
    "name": "Flat White",
    "price": 4.3,
    "image": "assets/images/flatwhite.jpg",
    "rating": 4.6,
    "description": "Velvety microfoam over a double espresso shot.",
    "category": "Hot Drinks",
  },
  {
    "id": "6",
    "name": "expresso",
    "price": 2.5,
    "image": "assets/images/expresso.jpg",
    "rating": 4.4,
    "description": "expresso strong coffee",
    "category": "Specialty",
  },
  {
    "id": "7",
    "name": "Mocha",
    "price": 4.8,
    "image": "assets/images/mocha1.jpg",
    "rating": 4.7,
    "description": "Rich espresso with steamed milk and chocolate syrup.",
    "category": "Hot Drinks",
  },
  {
    "id": "8",
    "name": "Mocha",
    "price": 4.7,
    "image": "assets/images/mocha.jpg",
    "rating": 4.7,
    "description": "Chocolate flavored coffee drink",
    "category": "Cold Drinks",
  },
  {
    "id": "9",
    "name": "Caramel Latte",
    "price": 4.9,
    "image": "assets/images/caramel_latte.jpg",
    "rating": 4.9,
    "description": "Latte with rich caramel flavor",
    "category": "Cold Drinks",
  },
  {
    "id": "10",
    "name": "Iced Americano",
    "price": 3.9,
    "image": "assets/images/iced_americano.jpg",
    "rating": 4.4,
    "description": "Chilled espresso with water and ice",
    "category": "Cold Drinks",
  },
  {
    "id": "11",
    "name": "Iced Mocha",
    "price": 4.8,
    "image": "assets/images/iced_mocha.jpg",
    "rating": 4.6,
    "description": "Iced coffee with chocolate and milk",
    "category": "Cold Drinks",
  },
  {
    "id": "12",
    "name": "Cheesecake",
    "price": 5.5,
    "image": "assets/images/cheesecake.jpg",
    "rating": 4.7,
    "description": "Creamy dessert slice",
    "category": "Desserts",
  },
  {
    "id": "13",
    "name": "Brownie",
    "price": 3.2,
    "image": "assets/images/brownie.jpg",
    "rating": 4.5,
    "description": "Rich chocolate brownie",
    "category": "Desserts",
  },
  {
    "id": "14",
    "name": "Croissant",
    "price": 2.8,
    "image": "assets/images/croissant.jpg",
    "rating": 4.3,
    "description": "Buttery flaky pastry",
    "category": "Pastries",
  },
  {
    "id": "15",
    "name": "Muffin",
    "price": 2.9,
    "image": "assets/images/muffin.jpg",
    "rating": 4.4,
    "description": "Soft baked muffin",
    "category": "Pastries",
  },
  {
    "id": "16",
    "name": "Cinnamon Roll",
    "price": 3.5,
    "image": "assets/images/cinnamonroll.jpg",
    "rating": 4.7,
    "description": "Soft roll swirled with cinnamon and sugar glaze.",
    "category": "Pastries",
  },
  {
    "id": "17",
    "name": "Hazelnut Latte",
    "price": 4.7,
    "image": "assets/images/hazelnutlatte.jpg",
    "rating": 4.7,
    "description": "Creamy latte infused with roasted hazelnut syrup.",
    "category": "Specialty", // hot + specialty
  },
];

/* ======================================================
   APP
====================================================== */

class CoffeeCupApp extends StatefulWidget {
  const CoffeeCupApp({super.key});

  @override
  State<CoffeeCupApp> createState() => _CoffeeCupAppState();
}

class _CoffeeCupAppState extends State<CoffeeCupApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDark ? darkTheme : lightTheme,
      home: const SplashScreen(),
    );
  }
}

/* ======================================================
   THEMES
====================================================== */

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF121212),
  primaryColor: const Color(0xFFA26A3D),
  cardColor: const Color(0xFF1E1E1E),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1E1E1E),
    foregroundColor: Colors.white,
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.white),
    headlineSmall: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFA26A3D),
      foregroundColor: Colors.white,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFF1E1E1E),
    hintStyle: TextStyle(color: Colors.grey.shade500),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade700),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFA26A3D)),
    ),
  ),
);

final lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  primaryColor: const Color(0xFFA26A3D),
  cardColor: const Color(0xFFF5F5F5),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFA26A3D),
    foregroundColor: Colors.white,
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.black),
    headlineSmall: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFA26A3D),
      foregroundColor: Colors.white,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey.shade100,
    hintStyle: TextStyle(color: Colors.grey.shade600),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFA26A3D)),
    ),
  ),
);

/* ======================================================
   SPLASH SCREEN
====================================================== */

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const SignInPage(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: Image(
                    image: AssetImage("assets/images/logo.jpg"),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                "CoffeeCup",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "One Tap. One Cup. Pure Comfort.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* ======================================================
   AUTH LAYOUT (enhanced + guest mode + animations)
====================================================== */

Widget authLayout(
  BuildContext context,
  String title,
  String btnText,
  VoidCallback onTap,
  String subText,
  VoidCallback onSubTap,
) {
  final dark = Theme.of(context).brightness == Brightness.dark;
  final size = MediaQuery.of(context).size;

  return Scaffold(
    body: SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated logo & app title (Hero + subtle scale)
              Hero(
                tag: "auth-logo",
                child: Column(
                  children: [
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.9, end: 1.0),
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeOutBack,
                      builder: (context, value, child) {
                        return Transform.scale(scale: value, child: child);
                      },
                      child: Container(
                        width: size.width * 0.26,
                        height: size.width * 0.26,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(
                            context,
                          ).primaryColor.withValues(alpha: 0.1),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 18,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(16),
                          child: Image(
                            image: AssetImage("assets/images/logo.jpg"),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "CoffeeCup",
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Brew your mood in one tap.",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Animated auth card (fields + primary button)
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.94, end: 1.0),
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeOutBack,
                builder: (context, value, child) {
                  return Transform.scale(scale: value, child: child);
                },
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 22, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            title,
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          decoration: const InputDecoration(
                            hintText: "Email",
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                          style: TextStyle(
                            color: dark ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: "Password",
                            prefixIcon: Icon(Icons.lock_outline),
                          ),
                          style: TextStyle(
                            color: dark ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: onTap,
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              elevation: 4,
                            ),
                            child: Text(
                              btnText,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Guest button (unchanged logic, just visually separated)
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  onPressed: () {
                    mainTabIndex = 0;
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const MainLayout()),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text("Continue as Guest"),
                ),
              ),
              const SizedBox(height: 12),

              // Switch to SignIn/SignUp with a small fade
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: TextButton(
                  key: ValueKey(subText),
                  onPressed: onSubTap,
                  child: Text(subText),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

/* ======================================================
   SIGN IN / SIGN UP
====================================================== */

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return authLayout(
      context,
      "Welcome Back",
      "Sign In",
      () {
        final navigator = Navigator.of(context);
        showSuccessPopup(context, "Signed in successfully ☕");
        Future.delayed(const Duration(milliseconds: 800), () {
          mainTabIndex = 0;
          navigator.pushReplacement(
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => const MainLayout(),
              transitionsBuilder: (_, animation, __, child) {
                final offsetAnimation =
                    Tween<Offset>(
                      begin: const Offset(0, 0.05),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(parent: animation, curve: Curves.easeOut),
                    );
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  ),
                );
              },
            ),
          );
        });
      },
      "Don't have an account? Sign Up",
      () => Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const SignUpPage(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),
    );
  }
}

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return authLayout(
      context,
      "Create Account",
      "Sign Up",
      () {
        final navigator = Navigator.of(context);
        showSuccessPopup(context, "Account created successfully ☕");
        Future.delayed(const Duration(milliseconds: 800), () {
          mainTabIndex = 0;
          navigator.pushReplacement(
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => const MainLayout(),
              transitionsBuilder: (_, animation, __, child) {
                final offsetAnimation =
                    Tween<Offset>(
                      begin: const Offset(0, 0.05),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(parent: animation, curve: Curves.easeOut),
                    );
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  ),
                );
              },
            ),
          );
        });
      },
      "Already have an account? Sign In",
      () => Navigator.pop(context),
    );
  }
}

/* ======================================================
   MAIN LAYOUT
====================================================== */

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int index = mainTabIndex;

  final pages = const [
    HomePage(),
    CartPage(),
    WishlistPage(),
    OrdersPage(), // new tab
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: index,
        onTap: (i) => setState(() => index = i),
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        backgroundColor: Theme.of(context).cardColor,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Wishlist",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            label: "Orders",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

/* ======================================================
   HOME PAGE (search + filter + responsive grid)
====================================================== */

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchQuery = "";
  String selectedCategory = "All";

  List<Map<String, dynamic>> get filteredProducts {
    return products.where((p) {
      final name = (p["name"] as String).toLowerCase();
      final category = (p["category"] as String).toLowerCase();
      final query = searchQuery.toLowerCase();
      final matchesSearch = name.contains(query);
      final matchesCategory = selectedCategory == "All"
          ? true
          : category.contains(selectedCategory.toLowerCase());
      return matchesSearch && matchesCategory;
    }).toList();
  }

  void _toggleTheme() {
    isDark = !isDark;
    appKey.currentState?.setState(() {}); // rebuild whole app
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bannerHeight = size.height * 0.25;

    return Scaffold(
      appBar: AppBar(
        title: const Text("CoffeeCup"),
        actions: [
          IconButton(
            icon: const Icon(Icons.grid_view_rounded),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CategoryPage()),
              );
            },
          ),
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: _toggleTheme,
          ),
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.shopping_cart),
                if (cart.isNotEmpty)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        '${cart.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            onPressed: () {
              if (cart.isEmpty) {
                snack(context, "Your cart is empty");
                return;
              }

              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CheckoutPage()),
              );
            },
          ),
        ],
      ),

      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final isPhone = width < 600;
          final crossAxisCount = isPhone ? 2 : 3;
          final childAspectRatio = isPhone ? 0.7 : 0.8;

          final data = filteredProducts;

          return CustomScrollView(
            slivers: [
              // Slogan + search + hero + filter row
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Good Morning, Coffee Lover ☕",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "One Tap. One Cup. Pure Comfort.",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        onChanged: (value) {
                          setState(() => searchQuery = value);
                        },
                        decoration: const InputDecoration(
                          hintText: "Search your favorite coffee...",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(24)),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 0),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: bannerHeight,
                        width: double.infinity,
                        child: Image.asset(
                          "assets/images/hero1.jpg",
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            height: bannerHeight,
                            color: Colors.grey.shade300,
                            child: const Icon(
                              Icons.coffee,
                              size: 60,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildFilterChip("All"),
                            const SizedBox(width: 8),
                            _buildFilterChip("Hot"),
                            const SizedBox(width: 8),
                            _buildFilterChip("Cold"),
                            const SizedBox(width: 8),
                            _buildFilterChip("Desserts"),
                            const SizedBox(width: 8),
                            _buildFilterChip("Specialty"),
                            const SizedBox(width: 8),
                            _buildFilterChip("Pastries"),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),

              // Product grid
              if (data.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Text(
                      "No items found.",
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate((context, i) {
                      final p = data[i];
                      final liked = wishlist.any((w) => w["id"] == p["id"]);
                      final userRating = userRatings[p["id"]] ?? 0.0;
                      return ProductCard(
                        product: p,
                        isLiked: liked,
                        userRating: userRating,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductDetailPage(product: p),
                          ),
                        ),
                        onLikeToggle: () {
                          final existingIndex = wishlist.indexWhere(
                            (w) => w["id"] == p["id"],
                          );
                          if (existingIndex != -1) {
                            wishlist.removeAt(existingIndex);
                          } else {
                            wishlist.add(p);
                          }
                          (context as Element).markNeedsBuild();
                        },
                        onRate: (rating) {
                          userRatings[p["id"]] = rating;
                        },
                      );
                    }, childCount: data.length),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: childAspectRatio,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final selected = selectedCategory == label;
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) {
        setState(() {
          selectedCategory = label;
        });
      },
    );
  }
}

class ProductCard extends StatefulWidget {
  final Map<String, dynamic> product;
  final bool isLiked;
  final double userRating;
  final VoidCallback onTap;
  final VoidCallback onLikeToggle;
  final Function(double) onRate;

  const ProductCard({
    super.key,
    required this.product,
    required this.isLiked,
    required this.userRating,
    required this.onTap,
    required this.onLikeToggle,
    required this.onRate,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard>
    with SingleTickerProviderStateMixin {
  bool _showRating = false;
  double _scale = 1.0;

  void _onTapDown(_) => setState(() => _scale = 0.97);
  void _onTapUp(_) => setState(() => _scale = 1.0);
  void _onTapCancel() => setState(() => _scale = 1.0);

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final price = product["price"] as double;
    final image = product["image"] as String;
    final rating = product["rating"] as double;

    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image + wishlist + rating badge
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(18),
                    ),
                    child: AspectRatio(
                      aspectRatio: 4 / 3,
                      child: Image.asset(
                        image,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: Colors.grey.shade200,
                          child: const Icon(
                            Icons.coffee,
                            size: 40,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: widget.onLikeToggle,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.35),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          widget.isLiked
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.redAccent,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.45),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.star, size: 14, color: Colors.amber),
                          const SizedBox(width: 3),
                          Text(
                            rating.toStringAsFixed(1),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // Info + price + add to cart
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                child: Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        product["name"] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Signature blend",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Text(
                            "\$${price.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              cart.add({
                                ...product,
                                "qty": 1,
                                "size": "Medium",
                                "total": price,
                              });
                              snack(context, "Added to cart");
                              setState(() {});
                            },
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.add_shopping_cart_rounded,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            "Tap to rate",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _showRating = !_showRating;
                              });
                            },
                            child: Icon(
                              _showRating ? Icons.star : Icons.star_border,
                              size: 16,
                              color: Colors.amber,
                            ),
                          ),
                        ],
                      ),
                      if (_showRating) ...[
                        const SizedBox(height: 4),
                        Row(
                          children: List.generate(5, (i) {
                            return IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              icon: Icon(
                                i < widget.userRating
                                    ? Icons.star
                                    : Icons.star_border,
                                size: 18,
                                color: Colors.amber,
                              ),
                              onPressed: () {
                                widget.onRate(i + 1.0);
                                setState(() {});
                              },
                            );
                          }),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


/* ======================================================
   PRODUCT DETAIL – enhanced UI
====================================================== */

class ProductDetailPage extends StatefulWidget {
  final Map<String, dynamic> product;
  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int qty = 1;
  String size = "Medium";
  double userRating = 0;

  @override
  void initState() {
    super.initState();
    userRating = userRatings[widget.product["id"]] ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final price = widget.product["price"] as double;
    final total = price * qty;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product["name"] as String),
        actions: [
          IconButton(
            icon: Icon(
              wishlist.any((w) => w["id"] == widget.product["id"])
                  ? Icons.favorite
                  : Icons.favorite_border,
            ),
            onPressed: () {
              final existingIndex = wishlist.indexWhere(
                (w) => w["id"] == widget.product["id"],
              );
              if (existingIndex != -1) {
                wishlist.removeAt(existingIndex);
              } else {
                wishlist.add(widget.product);
              }
              setState(() {});
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Top image + gradient background
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 260,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).primaryColor.withAlpha(60),
                            Colors.brown.withAlpha(40),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(40),
                            blurRadius: 25,
                            offset: const Offset(0, 12),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Image.asset(
                            widget.product["image"],
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              color: Colors.grey.shade200,
                              child: const Icon(
                                Icons.coffee,
                                size: 80,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Name + rating row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          widget.product["name"] as String,
                          style: Theme.of(
                            context,
                          ).textTheme.headlineSmall?.copyWith(fontSize: 24),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber.withAlpha(40),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star,
                              size: 18,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              (widget.product["rating"] as double)
                                  .toStringAsFixed(1),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.product["description"] as String,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 15),
                  ),
                  const SizedBox(height: 16),

                  // User star rating row
                  Row(
                    children: [
                      Text(
                        "Your rating:",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(width: 8),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(5, (i) {
                          return IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: Icon(
                              i < userRating ? Icons.star : Icons.star_border,
                              color: Colors.amber,
                              size: 24,
                            ),
                            onPressed: () {
                              setState(() {
                                userRating = i + 1.0;
                                userRatings[widget.product["id"]] = userRating;
                              });
                            },
                          );
                        }),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Price + qty card (incremental total feeling)
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "\$${price.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                "/ cup",
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Theme.of(
                                    context,
                                  ).primaryColor.withAlpha(30),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.local_fire_department,
                                      size: 16,
                                      color: Colors.orange,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      "Best seller",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade800,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _roundQtyButton(
                                icon: Icons.remove,
                                enabled: qty > 1,
                                onTap: () =>
                                    setState(() => qty = qty > 1 ? qty - 1 : 1),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                children: [
                                  Text(
                                    "$qty",
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "cups",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 10),
                              _roundQtyButton(
                                icon: Icons.add,
                                enabled: true,
                                onTap: () => setState(() => qty++),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Size selector card
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Size",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: ["Small", "Medium", "Large"].map((s) {
                              final selected = size == s;
                              return Expanded(
                                child: GestureDetector(
                                  onTap: () => setState(() => size = s),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 180),
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: selected
                                          ? Theme.of(context).primaryColor
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: selected
                                            ? Theme.of(context).primaryColor
                                            : Colors.grey.shade400,
                                      ),
                                    ),
                                    child: Text(
                                      s,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: selected ? Colors.white : null,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 90), // space for bottom bar
                ],
              ),
            ),
          ),

          // Bottom bar with incremental total and button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(20),
                  blurRadius: 20,
                  offset: const Offset(0, -6),
                ),
              ],
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Total",
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "\$${total.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    Text(
                      "$qty x \$${price.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      cart.add({
                        ...widget.product,
                        "qty": qty,
                        "size": size,
                        "total": total,
                      });
                      showSuccessPopup(context, "Added to cart ☕");
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 26),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add_shopping_cart),
                        SizedBox(width: 8),
                        Text(
                          "Add to Cart",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _roundQtyButton({
    required IconData icon,
    required bool enabled,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: enabled ? onTap : null,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: enabled
              ? Theme.of(context).primaryColor
              : Colors.grey.shade400,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 22, color: Colors.white),
      ),
    );
  }
}

/* ======================================================
   CART PAGE (Checkout)
====================================================== */

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double getTotal() {
    double total = 0;
    for (var c in cart) {
      total += c["total"] as double;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final total = getTotal();

    if (cart.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text("Checkout")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.shopping_cart_outlined,
                size: 80,
                color: Colors.grey,
              ),
              const SizedBox(height: 16),
              Text(
                "Your cart is empty",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                "Add some delicious items!",
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Continue Shopping"),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("Checkout (${cart.length})")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: cart.length,
              itemBuilder: (_, i) {
                final c = cart[i];
                final itemTotal = c["total"] as double;
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        c["image"],
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          width: 60,
                          height: 60,
                          color: Colors.grey.shade200,
                          child: const Icon(Icons.coffee, color: Colors.grey),
                        ),
                      ),
                    ),
                    title: Text(c["name"]),
                    subtitle: Text(
                      "Qty: ${c["qty"]} | ${c["size"]}\n\$${itemTotal.toStringAsFixed(2)}",
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        cart.removeAt(i);
                        setState(() {});
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 20,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "\$${total.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      if (cart.isEmpty) return;

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CheckoutPage()),
                      );
                    },

                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Place Order",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/* ======================================================
   CHECKOUT PAGE (address + payment)
====================================================== */

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();

  String fullName = "";
  String phone = "";
  String address = "";
  String city = "";
  String note = "";
  String paymentMethod = "Cash on Delivery";

  double getTotal() {
    double total = 0;
    for (var c in cart) {
      total += c["total"] as double;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final total = getTotal();

    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Order summary card
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Order Summary",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  "${cart.length} item${cart.length > 1 ? 's' : ''}",
                                  style: TextStyle(color: Colors.grey.shade700),
                                ),
                                const Spacer(),
                                Text(
                                  "\$${total.toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Shipping address
                    Text(
                      "Delivery Details",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Full Name",
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      validator: (v) =>
                          v == null || v.trim().isEmpty ? "Required" : null,
                      onSaved: (v) => fullName = v!.trim(),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Phone Number",
                        prefixIcon: Icon(Icons.phone_outlined),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (v) =>
                          v == null || v.trim().isEmpty ? "Required" : null,
                      onSaved: (v) => phone = v!.trim(),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Address",
                        prefixIcon: Icon(Icons.location_on_outlined),
                      ),
                      maxLines: 2,
                      validator: (v) =>
                          v == null || v.trim().isEmpty ? "Required" : null,
                      onSaved: (v) => address = v!.trim(),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "City",
                        prefixIcon: Icon(Icons.location_city_outlined),
                      ),
                      validator: (v) =>
                          v == null || v.trim().isEmpty ? "Required" : null,
                      onSaved: (v) => city = v!.trim(),
                    ),
                    const SizedBox(height: 16),

                    // Payment method
                    // Payment method
                    Text(
                      "Payment Method",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            _PaymentChoiceChip(
                              label: "Cash on Delivery",
                              description:
                                  "Pay with cash when your order arrives",
                              selected: paymentMethod == "Cash on Delivery",
                              icon: Icons.payments_outlined,
                              onTap: () {
                                setState(
                                  () => paymentMethod = "Cash on Delivery",
                                );
                              },
                            ),
                            const Divider(height: 16),
                            _PaymentChoiceChip(
                              label: "Credit / Debit Card",
                              description: "Demo only (no real payment)",
                              selected: paymentMethod == "Card (mock)",
                              icon: Icons.credit_card,
                              onTap: () {
                                setState(() => paymentMethod = "Card (mock)");
                              },
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Order note (optional)",
                        prefixIcon: Icon(Icons.notes_outlined),
                      ),
                      maxLines: 2,
                      onSaved: (v) => note = v?.trim() ?? "",
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ),

          // Bottom bar: total + place order
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(25),
                  blurRadius: 16,
                  offset: const Offset(0, -6),
                ),
              ],
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Total",
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "\$${total.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      final formState = _formKey.currentState;
                      if (formState == null) return;
                      if (!formState.validate()) {
                        snack(context, "Please fill all required fields");
                        return;
                      }

                      formState.save();
                      if (cart.isEmpty) {
                        snack(context, "Your cart is empty");
                        return;
                      }

                      final total = getTotal();
                      final orderId = DateTime.now().millisecondsSinceEpoch
                          .toString();
                      final orderItems = cart
                          .map((c) => Map<String, dynamic>.from(c))
                          .toList();

                      int totalItems = 0;
                      final buffer = StringBuffer();
                      for (var i = 0; i < cart.length; i++) {
                        final c = cart[i];
                        final name = c["name"] as String;
                        final q = c["qty"] as int? ?? 1;
                        totalItems += q;
                        buffer.write("${q}x $name");
                        if (i != cart.length - 1) buffer.write(" • ");
                      }

                      orders.add({
                        "id": orderId,
                        "items": orderItems,
                        "total": total,
                        "createdAt": DateTime.now(),
                        "summary": buffer.toString(),
                        "itemCount": totalItems,
                        "paymentMethod": paymentMethod,
                        "address": address,
                        "city": city,
                        "fullName": fullName,
                        "phone": phone,
                        "note": note,
                      });

                      showSuccessPopup(
                        context,
                        "Order placed successfully! 🎉",
                        onContinue: () {
                          cart.clear();
                          mainTabIndex = 0;
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const MainLayout(),
                            ),
                            (route) => false,
                          );
                        },
                      );
                    },

                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 26),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check_circle_outline),
                        SizedBox(width: 8),
                        Text(
                          "Confirm Order",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/* ======================================================
   Helper functions for payment 
====================================================== */

class _PaymentChoiceChip extends StatelessWidget {
  final String label;
  final String description;
  final bool selected;
  final IconData icon;
  final VoidCallback onTap;

  const _PaymentChoiceChip({
    required this.label,
    required this.description,
    required this.selected,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? color : Colors.grey.shade400,
                  width: 2,
                ),
                color: selected
                    ? color.withValues(alpha: 0.15)
                    : Colors.transparent,
              ),
              child: Icon(
                icon,
                size: 18,
                color: selected ? color : Colors.grey.shade600,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: selected ? color : null,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? color : Colors.grey.shade400,
                  width: 2,
                ),
              ),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selected ? color : Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ======================================================
   WISHLIST PAGE
====================================================== */

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Wishlist (${wishlist.length})")),
      body: wishlist.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.favorite_border,
                    size: 80,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Your wishlist is empty",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Save items you love!",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: wishlist.length,
              itemBuilder: (_, i) {
                final w = wishlist[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        w["image"],
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          width: 60,
                          height: 60,
                          color: Colors.grey.shade200,
                          child: const Icon(Icons.coffee, color: Colors.grey),
                        ),
                      ),
                    ),
                    title: Text(w["name"]),
                    subtitle: Text(
                      "\$${(w["price"] as double).toStringAsFixed(2)}",
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        wishlist.removeAt(i);
                        (context as Element).markNeedsBuild();
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
/* ======================================================
   CATEGORY Page - Fixed with withValues() & scroll safe
====================================================== */

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  // Unique category names from products list
  List<String> get categories {
    final set = <String>{};
    for (final p in products) {
      set.add(p["category"] as String);
    }
    return set.toList();
  }

  @override
  Widget build(BuildContext context) {
    final cats = categories;

    return Scaffold(
      appBar: AppBar(title: const Text("Categories"), centerTitle: true),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Find your mood",
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 8),
          // Wrap ListView in Expanded to prevent overflow
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: cats.length,
              itemBuilder: (context, i) {
                final cat = cats[i];

                IconData icon = Icons.local_cafe_outlined;
                if (cat.toLowerCase().contains("cold")) {
                  icon = Icons.ac_unit_rounded;
                } else if (cat.toLowerCase().contains("pastries")) {
                  icon = Icons.cookie_outlined;
                } else if (cat.toLowerCase().contains("special")) {
                  icon = Icons.star_outline_rounded;
                }

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CategoryProductsPage(category: cat),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(
                            context,
                          ).primaryColor.withValues(alpha: 0.10),
                          Theme.of(context).cardColor.withValues(alpha: 0.90),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 10,
                      ),
                      leading: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          icon,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      title: Text(
                        cat,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        "Explore $cat delights",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 16,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/* ======================================================
   CATEGORY ProductsPage - Fixed for overflow
====================================================== */

class CategoryProductsPage extends StatelessWidget {
  final String category;
  const CategoryProductsPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    // Filter products by category
    final data = products
        .where(
          (p) => (p["category"] as String).toLowerCase().contains(
            category.toLowerCase(),
          ),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text(category), centerTitle: true),
      body: data.isEmpty
          ? Center(
              child: Text(
                "No products found.",
                style: TextStyle(color: Colors.grey.shade600),
              ),
            )
          : Column(
              children: [
                // Optional header or info
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Explore $category delights",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                // GridView must be wrapped in Expanded
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 14,
                          crossAxisSpacing: 14,
                          childAspectRatio: 0.78,
                        ),
                    itemCount: data.length,
                    itemBuilder: (context, i) {
                      final p = data[i];
                      final liked = wishlist.any((w) => w["id"] == p["id"]);
                      final userRating = userRatings[p["id"]] ?? 0.0;

                      return ProductCard(
                        product: p,
                        isLiked: liked,
                        userRating: userRating,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductDetailPage(product: p),
                          ),
                        ),
                        onLikeToggle: () {
                          final existingIndex = wishlist.indexWhere(
                            (w) => w["id"] == p["id"],
                          );
                          if (existingIndex != -1) {
                            wishlist.removeAt(existingIndex);
                          } else {
                            wishlist.add(p);
                          }
                          (context as Element).markNeedsBuild();
                        },
                        onRate: (rating) {
                          userRatings[p["id"]] = rating;
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

/* ======================================================
   PROFILE PAGE (enhanced with actions)
====================================================== */

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Avatar
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
              ),
              child: const Icon(
                Icons.person,
                size: 60,
                color: Color(0xFFA26A3D),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Coffee Lover ☕",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              "coffee@email.com",
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            ),
            const SizedBox(height: 24),

            // Stats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                _ProfileStat(label: "Orders", value: "12"),
                _ProfileStat(label: "Wishlist", value: "7"),
                _ProfileStat(label: "Rating", value: "4.8"),
              ],
            ),
            const SizedBox(height: 24),

            // Main actions card
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.list_alt_outlined),
                    title: const Text("My Orders"),
                    subtitle: const Text("View your order history"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const OrdersPage()),
                      );
                    },
                  ),
                  const Divider(height: 0),
                  ListTile(
                    leading: const Icon(Icons.settings_outlined),
                    title: const Text("Settings"),
                    subtitle: const Text("Theme, notifications, language"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SettingsPage()),
                      );
                    },
                  ),
                  const Divider(height: 0),
                  ListTile(
                    leading: const Icon(Icons.lock_reset_outlined),
                    title: const Text("Forgot Password"),
                    subtitle: const Text("Reset your account password"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ForgotPasswordPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class _ProfileStat extends StatelessWidget {
  final String label;
  final String value;
  const _ProfileStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
      ],
    );
  }
}

/* ======================================================
   ORDERS PAGE (connected to cart)
====================================================== */

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text("My Orders")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.receipt_long_outlined,
                size: 80,
                color: Colors.grey,
              ),
              const SizedBox(height: 16),
              Text(
                "No orders yet",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                "Place an order from your cart.",
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("My Orders")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        itemBuilder: (_, i) {
          final order = orders[orders.length - 1 - i]; // latest first
          final id = order["id"] as String;
          final total = order["total"] as double;
          final items = order["items"] as List<dynamic>;

          // first product image for thumbnail
          final firstItem = items.isNotEmpty
              ? items[0] as Map<String, dynamic>
              : null;
          final imagePath = firstItem?["image"] as String?;
          final createdAt = order["createdAt"] as DateTime;

          // build a short summary like "2 items" or "3x Cappuccino, 1x Latte"
          final itemCount = items.length;
          final summary = "$itemCount item${itemCount > 1 ? 's' : ''}";

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: imagePath == null
                    ? Container(
                        width: 60,
                        height: 60,
                        color: Colors.grey.shade200,
                        child: const Icon(Icons.coffee, color: Colors.grey),
                      )
                    : Image.asset(
                        imagePath,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          width: 60,
                          height: 60,
                          color: Colors.grey.shade200,
                          child: const Icon(Icons.coffee, color: Colors.grey),
                        ),
                      ),
              ),
              title: Text("Order #$id"),
              subtitle: Text("$summary\n${_formatDate(createdAt)}"),
              isThreeLine: true,
              trailing: Text(
                "\$${total.toStringAsFixed(2)}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => OrderDetailPage(order: order),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  String _formatDate(DateTime dt) {
    return "${dt.day.toString().padLeft(2, '0')}/"
        "${dt.month.toString().padLeft(2, '0')}/"
        "${dt.year}";
  }
}
/* ======================================================
   ORDER DETAIL PAGE
====================================================== */

class OrderDetailPage extends StatelessWidget {
  final Map<String, dynamic> order;
  const OrderDetailPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final items = order["items"] as List<dynamic>;
    final total = order["total"] as double;
    final id = order["id"] as String;

    return Scaffold(
      appBar: AppBar(title: Text("Order #$id")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              itemBuilder: (_, i) {
                final item = items[i] as Map<String, dynamic>;
                final name = item["name"] as String;
                final image = item["image"] as String;
                final qty = item["qty"] ?? 1;
                final size = item["size"] ?? "";
                final itemTotal = item["total"] as double? ?? 0;

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        image,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          width: 60,
                          height: 60,
                          color: Colors.grey.shade200,
                          child: const Icon(Icons.coffee, color: Colors.grey),
                        ),
                      ),
                    ),
                    title: Text(name),
                    subtitle: Text("Qty: $qty  ${size.toString()}"),
                    trailing: Text(
                      "\$${itemTotal.toStringAsFixed(2)}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.centerRight,
            child: Text(
              "Total: \$${total.toStringAsFixed(2)}",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/* ======================================================
   SETTINGS PAGE
====================================================== */

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            value: isDark,
            title: const Text("Dark Mode"),
            onChanged: (val) {
              isDark = val;
              themeNotifier.value = !themeNotifier.value; // trigger rebuild
            },
          ),

          const ListTile(
            leading: Icon(Icons.notifications_outlined),
            title: Text("Notifications"),
            subtitle: Text("Order updates, offers"),
          ),
          const ListTile(
            leading: Icon(Icons.language),
            title: Text("Language"),
            subtitle: Text("English"),
          ),
        ],
      ),
    );
  }
}

/* ======================================================
   FORGOT PASSWORD PAGE
====================================================== */

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Forgot Password")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text(
              "Enter your email to reset your password.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                hintText: "Email",
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  showSuccessPopup(
                    context,
                    "Password reset link sent to your email",
                  );
                  Navigator.pop(context);
                },
                child: const Text("Send reset link"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ... all your pages above (HomePage, CartPage, CheckoutPage, OrdersPage, etc.)

/* ======================================================
   HELPERS
====================================================== */

void showSuccessPopup(
  BuildContext context,
  String message, {
  VoidCallback? onContinue,
}) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext dialogContext) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle,
                color: Color(0xFFA26A3D),
                size: 40,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(); // close dialog
                if (onContinue != null) {
                  onContinue();
                }
              },
              child: const Text("Continue"),
            ),
          ],
        ),
      ),
    ),
  );
}

void snack(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg),
      behavior: SnackBarBehavior.floating,
      backgroundColor: const Color(0xFFA26A3D),
    ),
  );
}
