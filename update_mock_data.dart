import 'dart:io';

void main() {
  final file = File('lib/features/explore/data/mock_explore_repository.dart');
  var content = file.readAsStringSync();

  final Map<String, String> imageMap = {
    'sushi': 'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?q=80&w=1000',
    'sashimi': 'https://images.unsplash.com/photo-1534482421-64566f976cfa?q=80&w=1000',
    'ramen': 'https://images.unsplash.com/photo-1557872943-16a5ac26437e?q=80&w=1000',
    'tempura': 'https://images.unsplash.com/photo-1615361200141-f45040f367be?q=80&w=1000',
    'udon': 'https://images.unsplash.com/photo-1617093727343-374698b1b08d?q=80&w=1000',
    'soba': 'https://images.unsplash.com/photo-1585032226651-759b368d7246?q=80&w=1000',
    'yakitori': 'https://images.unsplash.com/photo-1528659135081-37d42cf38a0a?q=80&w=1000',
    'bibimbap': 'https://images.unsplash.com/photo-1564834724105-918b73d1b9e0?q=80&w=1000',
    'bulgogi': 'https://images.unsplash.com/photo-1558030006-450675393462?q=80&w=1000',
    'dim sum': 'https://images.unsplash.com/photo-1563245372-f21724e3856d?q=80&w=1000',
    'duck': 'https://images.unsplash.com/photo-1632315758250-9f170f05561a?q=80&w=1000',
    'tofu': 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?q=80&w=1000',
    'bao': 'https://images.unsplash.com/photo-1631515243349-e0cb75fb8d3a?q=80&w=1000',
    'hot pot': 'https://images.unsplash.com/photo-1605333396914-23136203138b?q=80&w=1000',
    'chicken': 'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?q=80&w=1000',
    'rice': 'https://images.unsplash.com/photo-1512058564366-18510be2db19?q=80&w=1000',
    'noodle': 'https://images.unsplash.com/photo-1585032226651-759b368d7246?q=80&w=1000',
    'tart': 'https://images.unsplash.com/photo-1563729784474-d77dbb933a9e?q=80&w=1000',
    'tea': 'https://images.unsplash.com/photo-1576092762791-dd9e2220abd4?q=80&w=1000',
    'pork': 'https://images.unsplash.com/photo-1626804475297-4c600109f0e1?q=80&w=1000',
    'curry': 'https://images.unsplash.com/photo-1604908176997-125f25cc6f3d?q=80&w=1000',
  };

  final List<String> fallbackImages = [
    'https://images.unsplash.com/photo-1580476262798-bddd9f4b7369?q=80&w=1000',
    'https://images.unsplash.com/photo-1541014741259-de529411b96a?q=80&w=1000',
    'https://images.unsplash.com/photo-1607301406259-dfb186e15ed8?q=80&w=1000',
    'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?q=80&w=1000',
    'https://images.unsplash.com/photo-1626804475297-4c600109f0e1?q=80&w=1000',
    'https://images.unsplash.com/photo-1564834724105-918b73d1b9e0?q=80&w=1000',
    'https://images.unsplash.com/photo-1558030006-450675393462?q=80&w=1000',
  ];

  int fallbackIndex = 0;

  final dishPattern = RegExp('name:\\s*"([^"]+)"[\\s\\S]*?imageUrl:\\s*\\\'([^\\\']+)\\\'');

  content = content.replaceAllMapped(dishPattern, (match) {
    String name = match.group(1)!;
    String nameLower = name.toLowerCase();
    
    String newImage = '';
    
    for (var key in imageMap.keys) {
      if (nameLower.contains(key)) {
        newImage = imageMap[key]!;
        break;
      }
    }
    
    if (newImage.isEmpty) {
      newImage = fallbackImages[fallbackIndex % fallbackImages.length];
      fallbackIndex++;
    }

    // Replace the URL
    String fullMatch = match.group(0)!;
    String replaced = fullMatch.replaceAll(match.group(2)!, newImage);

    // Give it a more unique description based on name
    replaced = replaced.replaceAll(
      "description: 'A classic and beloved dish from",
      "description: 'Experience the authentic and intricate flavors of \$name, a signature dish from",
    );

    return replaced;
  });

  file.writeAsStringSync(content);
}
