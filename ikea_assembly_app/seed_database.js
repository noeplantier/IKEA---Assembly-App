

const admin = require('firebase-admin');
const serviceAccount = require('./serviceAccountKey.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const db = admin.firestore();

// Sample Furniture Data
const furnitureData = [
  {
    name: 'MALM Bed Frame',
    category: 'Beds',
    description: 'Queen size bed frame with adjustable sides and storage',
    imageUrl: 'https://www.ikea.com/us/en/images/products/malm-bed-frame__0638608_pe699032_s5.jpg',
    model3dUrl: 'https://storage.googleapis.com/your-bucket/models/malm-bed.glb',
    difficulty: 'Medium',
    estimatedTime: 45,
    rating: 4.5,
    reviewCount: 127,
    tags: ['bedroom', 'storage', 'modern', 'queen'],
    isActive: true,
    materials: [
      {
        id: 'mat_001',
        name: 'Side Panel Left',
        description: 'Main side panel with pre-drilled holes',
        quantity: 1,
        imageUrl: 'https://example.com/side-panel-left.jpg',
        model3dUrl: 'https://example.com/side-panel-left.glb',
        type: 'panel',
        dimensions: { length: 2100, width: 300, height: 20 },
        material: 'wood',
        color: 'white',
        notes: ['Handle with care', 'Check for damage before assembly']
      },
      {
        id: 'mat_002',
        name: 'Side Panel Right',
        description: 'Main side panel with pre-drilled holes',
        quantity: 1,
        imageUrl: 'https://example.com/side-panel-right.jpg',
        model3dUrl: 'https://example.com/side-panel-right.glb',
        type: 'panel',
        dimensions: { length: 2100, width: 300, height: 20 },
        material: 'wood',
        color: 'white',
        notes: ['Handle with care', 'Mirror of left panel']
      },
      {
        id: 'mat_003',
        name: 'Wood Screws',
        description: 'Phillips head screws for frame assembly',
        quantity: 16,
        imageUrl: 'https://example.com/wood-screw.jpg',
        model3dUrl: '',
        type: 'screw',
        dimensions: { length: 40, diameter: 4 },
        material: 'metal',
        color: 'silver',
        notes: ['Use provided screwdriver', 'Do not overtighten']
      },
      {
        id: 'mat_004',
        name: 'Cam Lock Nuts',
        description: 'Metal cam lock nuts for secure joints',
        quantity: 8,
        imageUrl: 'https://example.com/cam-lock.jpg',
        model3dUrl: 'https://example.com/cam-lock.glb',
        type: 'bracket',
        dimensions: { diameter: 15, height: 8 },
        material: 'metal',
        color: 'brass',
        notes: ['Turn clockwise to lock', 'Ensure full engagement']
      },
      {
        id: 'mat_005',
        name: 'Wooden Dowels',
        description: 'Hardwood dowels for alignment',
        quantity: 12,
        imageUrl: 'https://example.com/dowel.jpg',
        model3dUrl: '',
        type: 'dowel',
        dimensions: { length: 30, diameter: 8 },
        material: 'wood',
        color: 'natural',
        notes: ['Insert fully into holes', 'Light tap with mallet if needed']
      }
    ],
    steps: [
      {
        stepNumber: 1,
        title: 'Prepare Workspace',
        description: 'Clear a large flat area (at least 3m x 2m). Lay down a blanket or cardboard to protect the floor and furniture parts. Unpack all components and verify against the parts list.',
        imageUrl: 'https://example.com/malm-step1.jpg',
        model3dUrl: '',
        requiredMaterials: [],
        tools: [],
        estimatedTime: 5,
        difficulty: 'Easy',
        warnings: ['Ensure all parts are present before starting assembly'],
        tips: ['Sort screws by size in small containers', 'Keep instructions nearby', 'Have a second person available for heavy lifting'],
        videoUrl: ''
      },
      {
        stepNumber: 2,
        title: 'Insert Dowels and Cam Locks',
        description: 'Insert all wooden dowels into the pre-drilled holes on the headboard and footboard. Install cam lock nuts into designated slots. Ensure all pieces are pressed in fully.',
        imageUrl: 'https://example.com/malm-step2.jpg',
        model3dUrl: 'https://example.com/malm-step2.glb',
        requiredMaterials: ['mat_004', 'mat_005'],
        tools: ['rubber mallet'],
        estimatedTime: 10,
        difficulty: 'Easy',
        warnings: ['Do not force dowels', 'Cam locks should sit flush with surface'],
        tips: ['Tap dowels gently with mallet if tight', 'Orient cam locks with arrow pointing up'],
        videoUrl: ''
      },
      {
        stepNumber: 3,
        title: 'Attach Side Panels',
        description: 'With help, stand the headboard upright. Align the left side panel with the dowels and cam locks. Press firmly to engage all connections. Rotate cam locks 90° clockwise to lock. Repeat for right side panel.',
        imageUrl: 'https://example.com/malm-step3.jpg',
        model3dUrl: 'https://example.com/malm-step3.glb',
        requiredMaterials: ['mat_001', 'mat_002'],
        tools: ['screwdriver'],
        estimatedTime: 15,
        difficulty: 'Medium',
        warnings: ['Requires 2 people', 'Ensure panels are level before locking'],
        tips: ['Have helper support panel while aligning', 'Check that all dowels engage before locking'],
        videoUrl: ''
      },
      {
        stepNumber: 4,
        title: 'Secure with Screws',
        description: 'Using the provided screws, secure all joints where panels meet the headboard and footboard. Tighten in a cross pattern to ensure even pressure. Do not overtighten.',
        imageUrl: 'https://example.com/malm-step4.jpg',
        model3dUrl: 'https://example.com/malm-step4.glb',
        requiredMaterials: ['mat_003'],
        tools: ['screwdriver', 'drill (optional)'],
        estimatedTime: 15,
        difficulty: 'Medium',
        warnings: ['Do not overtighten screws', 'Stop if wood begins to crack'],
        tips: ['Use low torque setting on drill', 'Tighten gradually in multiple passes'],
        videoUrl: ''
      }
    ],
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
    updatedAt: admin.firestore.FieldValue.serverTimestamp()
  },
  {
    name: 'BILLY Bookcase',
    category: 'Shelves',
    description: 'Classic bookcase with adjustable shelves',
    imageUrl: 'https://www.ikea.com/us/en/images/products/billy-bookcase__0644757_pe702458_s5.jpg',
    model3dUrl: 'https://storage.googleapis.com/your-bucket/models/billy-bookcase.glb',
    difficulty: 'Easy',
    estimatedTime: 30,
    rating: 4.7,
    reviewCount: 543,
    tags: ['storage', 'classic', 'adjustable', 'office'],
    isActive: true,
    materials: [
      {
        id: 'mat_101',
        name: 'Back Panel',
        description: 'Fiberboard back panel',
        quantity: 1,
        imageUrl: 'https://example.com/billy-back.jpg',
        model3dUrl: '',
        type: 'panel',
        dimensions: { length: 2020, width: 800, height: 3 },
        material: 'fiberboard',
        color: 'white',
        notes: ['Fragile - handle carefully']
      },
      {
        id: 'mat_102',
        name: 'Side Panels',
        description: 'Particleboard sides with veneer',
        quantity: 2,
        imageUrl: 'https://example.com/billy-side.jpg',
        model3dUrl: 'https://example.com/billy-side.glb',
        type: 'panel',
        dimensions: { length: 2020, width: 280, height: 18 },
        material: 'particleboard',
        color: 'white',
        notes: ['Pre-drilled for shelf pins']
      },
      {
        id: 'mat_103',
        name: 'Adjustable Shelves',
        description: 'Can be positioned at any height',
        quantity: 4,
        imageUrl: 'https://example.com/billy-shelf.jpg',
        model3dUrl: '',
        type: 'panel',
        dimensions: { length: 760, width: 260, height: 18 },
        material: 'particleboard',
        color: 'white',
        notes: ['Each shelf can hold 30kg']
      },
      {
        id: 'mat_104',
        name: 'Shelf Pins',
        description: 'Metal support pins for shelves',
        quantity: 20,
        imageUrl: 'https://example.com/shelf-pin.jpg',
        model3dUrl: '',
        type: 'bracket',
        dimensions: { length: 5, diameter: 5 },
        material: 'metal',
        color: 'silver',
        notes: ['Use 4 pins per shelf']
      },
      {
        id: 'mat_105',
        name: 'Nails',
        description: 'Small nails for back panel',
        quantity: 30,
        imageUrl: 'https://example.com/nail.jpg',
        model3dUrl: '',
        type: 'screw',
        dimensions: { length: 15, diameter: 1.5 },
        material: 'metal',
        color: 'silver',
        notes: ['Secure back panel to frame']
      }
    ],
    steps: [
      {
        stepNumber: 1,
        title: 'Assemble Frame',
        description: 'Connect the two side panels to the top and bottom panels using the provided hardware. Make sure all corners are square.',
        imageUrl: 'https://example.com/billy-step1.jpg',
        model3dUrl: 'https://example.com/billy-step1.glb',
        requiredMaterials: ['mat_102'],
        tools: ['screwdriver'],
        estimatedTime: 10,
        difficulty: 'Easy',
        warnings: ['Check alignment before tightening'],
        tips: ['Assemble on soft surface to avoid scratches'],
        videoUrl: ''
      },
      {
        stepNumber: 2,
        title: 'Attach Back Panel',
        description: 'Position the back panel and secure with nails around the perimeter. Space nails about 15cm apart.',
        imageUrl: 'https://example.com/billy-step2.jpg',
        model3dUrl: '',
        requiredMaterials: ['mat_101', 'mat_105'],
        tools: ['hammer'],
        estimatedTime: 10,
        difficulty: 'Easy',
        warnings: ['Panel is fragile - support while nailing'],
        tips: ['Start from one corner and work around'],
        videoUrl: ''
      },
      {
        stepNumber: 3,
        title: 'Install Shelves',
        description: 'Insert shelf pins at desired heights (use 4 pins per shelf). Place shelves on pins.',
        imageUrl: 'https://example.com/billy-step3.jpg',
        model3dUrl: 'https://example.com/billy-step3.glb',
        requiredMaterials: ['mat_103', 'mat_104'],
        tools: [],
        estimatedTime: 10,
        difficulty: 'Easy',
        warnings: ['Ensure pins are fully inserted'],
        tips: ['Mark pin positions with pencil first', 'Space shelves according to your needs'],
        videoUrl: ''
      }
    ],
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
    updatedAt: admin.firestore.FieldValue.serverTimestamp()
  }
];

// Categories Data
const categoriesData = [
  { name: 'Beds', icon: 'bed', order: 1 },
  { name: 'Desks', icon: 'desk', order: 2 },
  { name: 'Chairs', icon: 'chair', order: 3 },
  { name: 'Storage', icon: 'storage', order: 4 },
  { name: 'Tables', icon: 'table', order: 5 },
  { name: 'Shelves', icon: 'shelves', order: 6 }
];

// Seeding Function
async function seedDatabase() {
  try {
    console.log('🌱 Starting database seeding...');

    // Seed Furniture
    console.log('📦 Adding furniture items...');
    for (const furniture of furnitureData) {
      const docRef = await db.collection('furniture').add(furniture);
      console.log(`✅ Added furniture: ${furniture.name} (ID: ${docRef.id})`);
    }

    // Seed Categories
    console.log('📁 Adding categories...');
    for (const category of categoriesData) {
      await db.collection('categories').add(category);
      console.log(`✅ Added category: ${category.name}`);
    }

    console.log('
🎉 Database seeding completed successfully!');
    console.log('
📊 Summary:');
    console.log(`   - Furniture items: ${furnitureData.length}`);
    console.log(`   - Categories: ${categoriesData.length}`);
    
  } catch (error) {
    console.error('❌ Error seeding database:', error);
  } finally {
    process.exit();
  }
}

// Run the seeding
seedDatabase();

// To run this script:
// 1. Install firebase-admin: npm install firebase-admin
// 2. Download serviceAccountKey.json from Firebase Console
// 3. Run: node seed_database.js
