import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF0058A3),
      elevation: 2,
      title: Row(
        children: [
          Image.asset('assets/logo.png', height: 32),
          const SizedBox(width: 8),
          const Text('IKEA Assembly',
              style: TextStyle(fontSize: 20, color: Colors.white)),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          tooltip: 'Notifications',
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.chat_bubble_outline),
          tooltip: 'Chatbot',
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.info_outline),
          tooltip: 'Informations',
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.account_circle),
          tooltip: 'Profil',
          onPressed: () {},
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IKEA Assembly Guide',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0058A3),
          primary: const Color(0xFF0058A3),
          secondary: const Color(0xFFFFDA1A),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      ),
      home: const HomeScreen(),
    );
  }
}

// MODELS
class Furniture {
  final String id;
  final String name;
  final String category;
  final String description;
  final String model3DPath;
  final String imageUrl;
  final int difficultyLevel;
  final int estimatedTime;
  final List<FurnitureMaterial> materials;
  final List<AssemblyStep> steps;

  Furniture({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.model3DPath,
    required this.difficultyLevel,
    required this.estimatedTime,
    required this.materials,
    required this.steps,
  });
}

class FurnitureMaterial {
  final String name;
  final int quantity;
  final String type;
  final String icon;

  FurnitureMaterial({
    required this.name,
    required this.quantity,
    required this.type,
    required this.icon,
  });
}

class AssemblyStep {
  final int stepNumber;
  final String title;
  final String description;
  final String icon;

  AssemblyStep({
    required this.stepNumber,
    required this.title,
    required this.description,
    required this.icon,
  });
}

class FurnitureCategory {
  final String id;
  final String name;
  final IconData icon;
  final Color color;

  FurnitureCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });
}

// DEMO DATA AVEC CHEMINS CORRECTS
class DemoData {
  static List<FurnitureCategory> categories = [
    FurnitureCategory(
      id: 'all',
      name: 'All',
      icon: Icons.grid_view_rounded,
      color: const Color(0xFF0058A3),
    ),
    FurnitureCategory(
      id: 'beds',
      name: 'Beds',
      icon: Icons.bed_rounded,
      color: const Color(0xFF6B4226),
    ),
    FurnitureCategory(
      id: 'desks',
      name: 'Desks',
      icon: Icons.desk_rounded,
      color: const Color(0xFF2E7D32),
    ),
    FurnitureCategory(
      id: 'chairs',
      name: 'Chairs',
      icon: Icons.chair_rounded,
      color: const Color(0xFFD32F2F),
    ),
    FurnitureCategory(
      id: 'wardrobes',
      name: 'Wardrobes',
      icon: Icons.checkroom_rounded,
      color: const Color(0xFF7B1FA2),
    ),
    FurnitureCategory(
      id: 'shelves',
      name: 'Shelves',
      icon: Icons.shelves,
      color: const Color(0xFFF57C00),
    ),
    FurnitureCategory(
      id: 'tables',
      name: 'Tables',
      icon: Icons.table_restaurant_rounded,
      color: const Color(0xFF0097A7),
    ),
  ];

  static List<Furniture> furnitureList = [
    // MALM BED
    Furniture(
      id: '1',
      name: 'MALM Bed Frame',
      category: 'beds',
      description: 'Queen size bed frame with adjustable bed sides',
      imageUrl:
          'https://www.ikea.com/ca/en/images/products/malm-bed-frame-high-white-luroey__0749130_pe745499_s5.jpg',
      model3DPath: 'assets/models/malm_bed.glb',
      difficultyLevel: 3,
      estimatedTime: 45,
      materials: [
        FurnitureMaterial(
            name: 'Wooden Panels', quantity: 8, type: 'Main', icon: '🪵'),
        FurnitureMaterial(
            name: 'Screws (M6)', quantity: 24, type: 'Fastener', icon: '🔩'),
        FurnitureMaterial(
            name: 'Allen Key', quantity: 1, type: 'Tool', icon: '🔧'),
        FurnitureMaterial(
            name: 'Dowels', quantity: 16, type: 'Fastener', icon: '📌'),
      ],
      steps: [
        AssemblyStep(
            stepNumber: 1,
            title: 'Prepare workspace',
            description: 'Clear a large area and lay out all parts',
            icon: '📦'),
        AssemblyStep(
            stepNumber: 2,
            title: 'Assemble side panels',
            description: 'Connect side panels using dowels and screws',
            icon: '🔨'),
        AssemblyStep(
            stepNumber: 3,
            title: 'Attach headboard',
            description: 'Secure headboard to side panels',
            icon: '🪛'),
        AssemblyStep(
            stepNumber: 4,
            title: 'Install bed base',
            description: 'Place and secure the slatted bed base',
            icon: '✅'),
      ],
    ),

    // BILLY BOOKCASE
    Furniture(
      id: '2',
      name: 'BILLY Bookcase',
      category: 'shelves',
      description: 'Classic bookcase with adjustable shelves',
      imageUrl:
          'https://www.ikea.com/us/en/images/products/billy-bookcase-white__0625599_pe692385_s5.jpg',
      model3DPath: 'assets/models/billy_bookcase.glb',
      difficultyLevel: 2,
      estimatedTime: 30,
      materials: [
        FurnitureMaterial(
            name: 'Side Panels', quantity: 2, type: 'Main', icon: '📏'),
        FurnitureMaterial(
            name: 'Shelves', quantity: 5, type: 'Main', icon: '📚'),
        FurnitureMaterial(
            name: 'Back Panel', quantity: 1, type: 'Main', icon: '🪵'),
        FurnitureMaterial(
            name: 'Nails', quantity: 30, type: 'Fastener', icon: '📌'),
      ],
      steps: [
        AssemblyStep(
            stepNumber: 1,
            title: 'Lay side panels',
            description: 'Position side panels on the floor',
            icon: '📐'),
        AssemblyStep(
            stepNumber: 2,
            title: 'Insert shelf pins',
            description: 'Place shelf pins at desired heights',
            icon: '🔘'),
        AssemblyStep(
            stepNumber: 3,
            title: 'Add shelves',
            description: 'Rest shelves on the pins',
            icon: '📚'),
        AssemblyStep(
            stepNumber: 4,
            title: 'Attach back panel',
            description: 'Nail the back panel to secure structure',
            icon: '🔨'),
      ],
    ),

    // PÅHL DESK
    Furniture(
      id: '3',
      name: 'PÅHL Desk',
      category: 'desks',
      description: 'Height adjustable desk for growing children',
      imageUrl:
          'https://www.ikea.com/us/en/images/products/pahl-desk-white__0735967_pe740301_s5.jpg',
      model3DPath: 'assets/models/pahl_desk.glb',
      difficultyLevel: 2,
      estimatedTime: 25,
      materials: [
        FurnitureMaterial(
            name: 'Desktop', quantity: 1, type: 'Main', icon: '🪵'),
        FurnitureMaterial(name: 'Legs', quantity: 4, type: 'Main', icon: '🦵'),
        FurnitureMaterial(
            name: 'Screws', quantity: 16, type: 'Fastener', icon: '🔩'),
      ],
      steps: [
        AssemblyStep(
            stepNumber: 1,
            title: 'Attach legs',
            description: 'Screw legs to desktop underside',
            icon: '🔧'),
        AssemblyStep(
            stepNumber: 2,
            title: 'Install adjusters',
            description: 'Add height adjustment mechanism',
            icon: '⚙️'),
        AssemblyStep(
            stepNumber: 3,
            title: 'Flip desk',
            description: 'Turn desk right-side up carefully',
            icon: '🔄'),
      ],
    ),

    // POÄNG ARMCHAIR
    Furniture(
      id: '4',
      name: 'POÄNG Armchair',
      category: 'chairs',
      description: 'Comfortable armchair with bentwood frame',
      imageUrl:
          'https://www.ikea.com/ca/en/images/products/poaeng-armchair-brown-gunnared-beige__1192128_pe900849_s5.jpg',
      model3DPath: 'assets/models/poang_armchair.glb',
      difficultyLevel: 1,
      estimatedTime: 15,
      materials: [
        FurnitureMaterial(
            name: 'Bentwood Frame', quantity: 1, type: 'Main', icon: '🪑'),
        FurnitureMaterial(
            name: 'Cushion', quantity: 1, type: 'Main', icon: '🛋️'),
        FurnitureMaterial(
            name: 'Screws', quantity: 8, type: 'Fastener', icon: '🔩'),
      ],
      steps: [
        AssemblyStep(
            stepNumber: 1,
            title: 'Unpack frame',
            description: 'Remove frame from packaging',
            icon: '📦'),
        AssemblyStep(
            stepNumber: 2,
            title: 'Connect frame parts',
            description: 'Bolt frame sections together',
            icon: '🔧'),
        AssemblyStep(
            stepNumber: 3,
            title: 'Attach seat base',
            description: 'Screw seat base to frame',
            icon: '🪛'),
      ],
    ),

    // PAX WARDROBE
    Furniture(
      id: '5',
      name: 'PAX Wardrobe',
      category: 'wardrobes',
      description: 'Customizable wardrobe system with doors',
      imageUrl:
          'https://www.ikea.com/ca/en/images/products/pax-wardrobe-combination-white__1381984_pe962091_s5.jpg',
      model3DPath: 'assets/models/pax_wardrobe.glb',
      difficultyLevel: 5,
      estimatedTime: 120,
      materials: [
        FurnitureMaterial(
            name: 'Side Panels', quantity: 2, type: 'Main', icon: '🪵'),
        FurnitureMaterial(name: 'Doors', quantity: 2, type: 'Main', icon: '🚪'),
        FurnitureMaterial(
            name: 'Hinges', quantity: 8, type: 'Hardware', icon: '⚙️'),
        FurnitureMaterial(
            name: 'Screws', quantity: 50, type: 'Fastener', icon: '🔩'),
      ],
      steps: [
        AssemblyStep(
            stepNumber: 1,
            title: 'Assemble frame',
            description: 'Connect side, top and bottom panels',
            icon: '🏗️'),
        AssemblyStep(
            stepNumber: 2,
            title: 'Install back panels',
            description: 'Attach back panels with nails',
            icon: '🔨'),
        AssemblyStep(
            stepNumber: 3,
            title: 'Add shelves',
            description: 'Install adjustable shelves',
            icon: '📚'),
        AssemblyStep(
            stepNumber: 4,
            title: 'Mount doors',
            description: 'Attach doors with hinges',
            icon: '🚪'),
      ],
    ),

    // LACK COFFEE TABLE
    Furniture(
      id: '6',
      name: 'LACK Coffee Table',
      category: 'tables',
      description: 'Simple and modern coffee table',
      imageUrl:
          'https://www.ikea.com/ca/en/images/products/lack-coffee-table-white__0750651_pe746801_s5.jpg',
      model3DPath: 'assets/models/lack_table.glb',
      difficultyLevel: 1,
      estimatedTime: 20,
      materials: [
        FurnitureMaterial(
            name: 'Tabletop', quantity: 1, type: 'Main', icon: '🪵'),
        FurnitureMaterial(name: 'Legs', quantity: 4, type: 'Main', icon: '🦵'),
        FurnitureMaterial(
            name: 'Screws', quantity: 12, type: 'Fastener', icon: '🔩'),
      ],
      steps: [
        AssemblyStep(
            stepNumber: 1,
            title: 'Flip tabletop',
            description: 'Turn tabletop upside down',
            icon: '🔄'),
        AssemblyStep(
            stepNumber: 2,
            title: 'Attach legs',
            description: 'Screw legs into corner brackets',
            icon: '🔧'),
        AssemblyStep(
            stepNumber: 3,
            title: 'Tighten screws',
            description: 'Ensure all screws are secure',
            icon: '🪛'),
      ],
    ),

    Furniture(
      id: '7',
      name: 'EKET Cabinet',
      category: 'shelves',
      description: 'Modular cabinet with doors and shelves',
      imageUrl:
          'https://www.ikea.com/ca/en/images/products/eket-storage-combination-with-legs-white-wood__0915074_pe784547_s5.jpg',
      model3DPath: 'assets/models/eket_cabinet.glb',
      difficultyLevel: 2,
      estimatedTime: 35,
      materials: [
        FurnitureMaterial(
            name: 'Cabinet Panels', quantity: 4, type: 'Main', icon: '🪵'),
        FurnitureMaterial(name: 'Doors', quantity: 2, type: 'Main', icon: '🚪'),
        FurnitureMaterial(
            name: 'Hinges', quantity: 4, type: 'Hardware', icon: '⚙️'),
        FurnitureMaterial(
            name: 'Screws', quantity: 20, type: 'Fastener', icon: '🔩'),
      ],
      steps: [
        AssemblyStep(
            stepNumber: 1,
            title: 'Assemble cabinet frame',
            description: 'Connect side and top/bottom panels',
            icon: '🏗️'),
        AssemblyStep(
            stepNumber: 2,
            title: 'Install shelves',
            description: 'Place shelves at desired heights',
            icon: '📚'),
        AssemblyStep(
            stepNumber: 3,
            title: 'Attach doors',
            description: 'Mount doors using hinges',
            icon: '🚪'),
      ],
    ),

    Furniture(
      id: '8',
      name: 'LISABO Dining Table',
      category: 'tables',
      description: 'Solid wood dining table with a natural finish',
      imageUrl:
          'https://www.ikea.com/ca/en/images/products/lisabo-lisabo-table-and-4-chairs-ash-veneer-ash__1255299_pe924491_s5.jpg',
      model3DPath: 'assets/models/lisabo_table.glb',
      difficultyLevel: 3,
      estimatedTime: 40,
      materials: [
        FurnitureMaterial(
            name: 'Tabletop', quantity: 1, type: 'Main', icon: '🪵'),
        FurnitureMaterial(name: 'Legs', quantity: 4, type: 'Main', icon: '🦵'),
        FurnitureMaterial(
            name: 'Screws', quantity: 16, type: 'Fastener', icon: '🔩'),
      ],
      steps: [
        AssemblyStep(
            stepNumber: 1,
            title: 'Flip tabletop',
            description: 'Turn tabletop upside down',
            icon: '🔄'),
        AssemblyStep(
            stepNumber: 2,
            title: 'Attach legs',
            description: 'Screw legs into pre-drilled holes',
            icon: '🔧'),
        AssemblyStep(
            stepNumber: 3,
            title: 'Tighten screws',
            description: 'Ensure all screws are secure',
            icon: '🪛'),
      ],
    ),

    Furniture(
      id: '9',
      name: 'HEMNES Dresser',
      category: 'wardrobes',
      description: 'Classic dresser with multiple drawers',
      imageUrl:
          'https://www.ikea.com/ca/en/images/products/hemnes-glass-door-cabinet-with-3-drawers-white-stain-light-brown__0805255_pe769478_s5.jpg',
      model3DPath: 'assets/models/hemnes_dresser.glb',
      difficultyLevel: 4,
      estimatedTime: 60,
      materials: [
        FurnitureMaterial(
            name: 'Dresser Panels', quantity: 6, type: 'Main', icon: '🪵'),
        FurnitureMaterial(
            name: 'Drawers', quantity: 4, type: 'Main', icon: '🗄️'),
        FurnitureMaterial(
            name: 'Screws', quantity: 30, type: 'Fastener', icon: '🔩'),
      ],
      steps: [
        AssemblyStep(
            stepNumber: 1,
            title: 'Assemble frame',
            description: 'Connect side, top and bottom panels',
            icon: '🏗️'),
        AssemblyStep(
            stepNumber: 2,
            title: 'Install drawers',
            description: 'Slide drawers into place',
            icon: '🗄️'),
        AssemblyStep(
            stepNumber: 3,
            title: 'Tighten screws',
            description: 'Ensure all screws are secure',
            icon: '🪛'),
      ],
    ),

    Furniture(
      id: '10',
      name: 'FÄRLÖV Sofa',
      category: 'chairs',
      description: 'Comfortable sofa with removable covers',
      imageUrl:
          'https://www.ikea.com/ca/en/images/products/hyltarp-sofa-gransel-natural__1193814_pe901641_s5.jpg',
      model3DPath: 'assets/models/farlov_sofa.glb',
      difficultyLevel: 2,
      estimatedTime: 30,
      materials: [
        FurnitureMaterial(
            name: 'Sofa Frame', quantity: 1, type: 'Main', icon: '🛋️'),
        FurnitureMaterial(
            name: 'Cushions', quantity: 4, type: 'Main', icon: '🛏️'),
        FurnitureMaterial(
            name: 'Screws', quantity: 12, type: 'Fastener', icon: '🔩'),
      ],
      steps: [
        AssemblyStep(
            stepNumber: 1,
            title: 'Unpack sofa frame',
            description: 'Remove frame from packaging',
            icon: '📦'),
        AssemblyStep(
            stepNumber: 2,
            title: 'Attach legs',
            description: 'Screw legs into frame base',
            icon: '🔧'),
        AssemblyStep(
            stepNumber: 3,
            title: 'Add cushions',
            description: 'Place cushions on the sofa frame',
            icon: '🛏️'),
      ],
    )
  ];
}

// HOME SCREEN
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  String selectedCategory = 'all';
  String searchQuery = '';
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<Furniture> get filteredFurniture {
    var furniture = DemoData.furnitureList;

    if (selectedCategory != 'all') {
      furniture =
          furniture.where((f) => f.category == selectedCategory).toList();
    }

    if (searchQuery.isNotEmpty) {
      furniture = furniture
          .where((f) =>
              f.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
              f.description.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }

    return furniture;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildAppBar(),
            _buildSearchBar(),
            _buildCategories(),
            _buildFurnitureGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      floating: true,
      backgroundColor: Colors.white,
      elevation: 0,
      expandedHeight: 140,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF0058A3),
                const Color(0xFF0058A3).withOpacity(0.8),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFDA1A),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.chair_rounded,
                          color: Color(0xFF0058A3),
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'IKEA Assembly',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Build with confidence',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
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
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Search furniture...',
              hintStyle: TextStyle(color: Colors.grey[400]),
              prefixIcon: const Icon(
                Icons.search_rounded,
                color: Color(0xFF0058A3),
                size: 24,
              ),
              suffixIcon: searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, color: Colors.grey),
                      onPressed: () {
                        setState(() {
                          searchQuery = '';
                        });
                      },
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: DemoData.categories.length,
          itemBuilder: (context, index) {
            final category = DemoData.categories[index];
            final isSelected = selectedCategory == category.id;

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedCategory = category.id;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.only(right: 16),
                width: 80,
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            category.color,
                            category.color.withOpacity(0.7),
                          ],
                        )
                      : null,
                  color: isSelected ? null : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: isSelected
                          ? category.color.withOpacity(0.3)
                          : Colors.black.withOpacity(0.05),
                      blurRadius: isSelected ? 15 : 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      category.icon,
                      color: isSelected ? Colors.white : category.color,
                      size: 32,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      category.name,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontSize: 12,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFurnitureGrid() {
    final furniture = filteredFurniture;

    if (furniture.isEmpty) {
      return SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search_off_rounded,
                size: 80,
                color: Colors.grey[300],
              ),
              const SizedBox(height: 16),
              Text(
                'No furniture found',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.all(20),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.75,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return FurnitureCard(furniture: furniture[index]);
          },
          childCount: furniture.length,
        ),
      ),
    );
  }
}

// FURNITURE CARD WITH 3D MODEL
class FurnitureCard extends StatefulWidget {
  final Furniture furniture;

  const FurnitureCard({super.key, required this.furniture});

  @override
  State<FurnitureCard> createState() => _FurnitureCardState();
}

class _FurnitureCardState extends State<FurnitureCard> {
  bool show3D = false;

  Color _getDifficultyColor(int level) {
    if (level <= 2) return Colors.green;
    if (level <= 4) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                FurnitureDetailScreen(furniture: widget.furniture),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE/3D VIEWER TOGGLE
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  // CONTENT (2D or 3D)
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                    child: show3D
                        ? ModelViewer(
                            src: widget.furniture.model3DPath,
                            alt: widget.furniture.name,
                            autoRotate: true,
                            rotationPerSecond: '30deg',
                            cameraControls: false,
                            disableZoom: true,
                            backgroundColor: const Color(0xFFF5F5F5),
                            shadowIntensity: 0.7,
                            exposure: 1.0,
                            loading: Loading.eager,
                            cameraOrbit: '0deg 75deg 105%',
                            fieldOfView: '30deg',
                          )
                        : Image.network(
                            widget.furniture.imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: const Color(0xFFF5F5F5),
                                child: const Center(
                                  child: Icon(
                                    Icons.image_not_supported,
                                    size: 48,
                                    color: Colors.grey,
                                  ),
                                ),
                              );
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                color: const Color(0xFFF5F5F5),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                    color: const Color(0xFF0058A3),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),

                  // 2D/3D TOGGLE BUTTON
                  Positioned(
                    top: 8,
                    left: 8,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          show3D = !show3D;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color:
                              show3D ? const Color(0xFF0058A3) : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              show3D ? Icons.threed_rotation : Icons.image,
                              size: 16,
                              color: show3D
                                  ? Colors.white
                                  : const Color(0xFF0058A3),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              show3D ? '3D' : '2D',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: show3D
                                    ? Colors.white
                                    : const Color(0xFF0058A3),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // DIFFICULTY BADGE
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star_rounded,
                            size: 16,
                            color: _getDifficultyColor(
                              widget.furniture.difficultyLevel,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${widget.furniture.difficultyLevel}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: _getDifficultyColor(
                                widget.furniture.difficultyLevel,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // INFO SECTION
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.furniture.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A1A),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.furniture.category.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF757575),
                        letterSpacing: 0.5,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time_rounded,
                          size: 16,
                          color: Color(0xFF0058A3),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${widget.furniture.estimatedTime} min',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF757575),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0058A3).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '${widget.furniture.materials.length} parts',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF0058A3),
                            ),
                          ),
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

// DETAIL SCREEN
class FurnitureDetailScreen extends StatefulWidget {
  final Furniture furniture;

  const FurnitureDetailScreen({super.key, required this.furniture});

  @override
  State<FurnitureDetailScreen> createState() => _FurnitureDetailScreenState();
}

class _FurnitureDetailScreenState extends State<FurnitureDetailScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool show3D = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Color _getDifficultyColor(int level) {
    if (level <= 2) return Colors.green;
    if (level <= 4) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: CustomScrollView(
        slivers: [
          // HEADER WITH IMAGE/3D
          SliverAppBar(
            expandedHeight: 400,
            pinned: true,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: const Icon(Icons.arrow_back_rounded,
                    color: Color(0xFF0058A3)),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.favorite_border_rounded,
                      color: Color(0xFF0058A3)),
                ),
                onPressed: () {},
              ),
              const SizedBox(width: 8),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  show3D
                      ? ModelViewer(
                          src: widget.furniture.model3DPath,
                          alt: widget.furniture.name,
                          autoRotate: true,
                          rotationPerSecond: '20deg',
                          cameraControls: true,
                          backgroundColor: const Color(0xFFF5F5F5),
                          shadowIntensity: 1.0,
                          exposure: 1.0,
                          loading: Loading.eager,
                          ar: true,
                          arModes: const [
                            'scene-viewer',
                            'webxr',
                            'quick-look'
                          ],
                          cameraOrbit: 'auto auto 105%',
                          fieldOfView: '30deg',
                        )
                      : Image.network(
                          widget.furniture.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: const Color(0xFFF5F5F5),
                              child: const Center(
                                child: Icon(
                                  Icons.image_not_supported,
                                  size: 80,
                                  color: Colors.grey,
                                ),
                              ),
                            );
                          },
                        ),

                  // TOGGLE BUTTON
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          show3D = !show3D;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: show3D
                                ? [
                                    const Color(0xFF0058A3),
                                    const Color(0xFF003D82)
                                  ]
                                : [
                                    const Color(0xFFFFDA1A),
                                    const Color(0xFFFFC700)
                                  ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: (show3D
                                      ? const Color(0xFF0058A3)
                                      : const Color(0xFFFFDA1A))
                                  .withOpacity(0.4),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              show3D ? Icons.image : Icons.view_in_ar,
                              size: 20,
                              color: show3D
                                  ? Colors.white
                                  : const Color(0xFF0058A3),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              show3D ? 'View Photo' : 'View in 3D/AR',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: show3D
                                    ? Colors.white
                                    : const Color(0xFF0058A3),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // INFO SECTION
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 15,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.furniture.name,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A1A1A),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.furniture.description,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF757575),
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          _buildInfoChip(
                            Icons.access_time_rounded,
                            '${widget.furniture.estimatedTime} min',
                            Colors.blue,
                          ),
                          const SizedBox(width: 12),
                          _buildInfoChip(
                            Icons.star_rounded,
                            'Level ${widget.furniture.difficultyLevel}',
                            _getDifficultyColor(
                                widget.furniture.difficultyLevel),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // TABS
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 15,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      TabBar(
                        controller: _tabController,
                        labelColor: const Color(0xFF0058A3),
                        unselectedLabelColor: const Color(0xFF757575),
                        indicatorColor: const Color(0xFF0058A3),
                        tabs: const [
                          Tab(text: 'Materials'),
                          Tab(text: 'Steps'),
                          Tab(text: 'Parts'),
                        ],
                      ),
                      SizedBox(
                        height: 400,
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            _buildMaterialsList(),
                            _buildStepsList(),
                            _build3DPartsList(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMaterialsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: widget.furniture.materials.length,
      itemBuilder: (context, index) {
        final material = widget.furniture.materials[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFF0058A3).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    material.icon,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      material.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      material.type,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF757575),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF0058A3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'x${material.quantity}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStepsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: widget.furniture.steps.length,
      itemBuilder: (context, index) {
        final step = widget.furniture.steps[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(0xFF0058A3),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${step.stepNumber}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(step.icon, style: const TextStyle(fontSize: 24)),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              step.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        step.description,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF757575),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _build3DPartsList() {
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1,
      ),
      itemCount: widget.furniture.materials.length,
      itemBuilder: (context, index) {
        final material = widget.furniture.materials[index];
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFF0058A3).withOpacity(0.2),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: 2 * math.pi),
                duration: const Duration(seconds: 4),
                builder: (context, angle, child) {
                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(angle),
                    child: Text(
                      material.icon,
                      style: const TextStyle(fontSize: 48),
                    ),
                  );
                },
                onEnd: () => setState(() {}),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  material.name,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF0058A3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'x${material.quantity}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
