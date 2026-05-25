import 'package:flutter/material.dart';
import 'package:project_nobody/day_1/expert_models/experts_models.dart';

class Tugas9Flutter extends StatefulWidget {
  const Tugas9Flutter({super.key});

  @override
  State<Tugas9Flutter> createState() => _Tugas9FlutterState();
}

class _Tugas9FlutterState extends State<Tugas9Flutter> {
  List<Map<String, dynamic>> listExpert = [
    {
      'profession_name': 'Software Engineer',
      'category': 'Technology',
      'description': 'Builds and maintains mobile and web applications.',
      'icon_name': 'code',
    },
    {
      'profession_name': 'General Practitioner',
      'category': 'Healthcare',
      'description': 'Provides primary medical care and diagnoses.',
      'icon_name': 'medical',
    },
    {
      'profession_name': 'Graphic Designer',
      'category': 'Creative',
      'description': 'Creates visual concepts and digital assets.',
      'icon_name': 'brush',
    },
    {
      'profession_name': 'Digital Marketer',
      'category': 'Business & Marketing',
      'description': 'Manages online campaigns and SEO strategy.',
      'icon_name': 'campaign',
    },
    {
      'profession_name': 'School Teacher',
      'category': 'Education',
      'description': 'Educates students and designs curriculums.',
      'icon_name': 'school',
    },
    {
      'profession_name': 'Accountant',
      'category': 'Finance',
      'description': 'Manages financial records and tax audits.',
      'icon_name': 'analytics',
    },
    {
      'profession_name': 'Cloud Engineer',
      'category': 'Technology',
      'description': 'Manages cloud infrastructure and pipelines.',
      'icon_name': 'cloud',
    },
    {
      'profession_name': 'Data Scientist',
      'category': 'Technology',
      'description': 'Analyzes complex data to extract insights.',
      'icon_name': 'storage',
    },
    {
      'profession_name': 'Cybersecurity Analyst',
      'category': 'Technology',
      'description': 'Protects networks and data from cyber threats.',
      'icon_name': 'security',
    },
    {
      'profession_name': 'Product Manager',
      'category': 'Management',
      'description': 'Guides the development and success of products.',
      'icon_name': 'assignment',
    },
  ];
  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'code':
        return Icons.code;
      case 'medical':
        return Icons.medical_services;
      case 'brush':
        return Icons.brush;
      case 'campaign':
        return Icons.campaign;
      case 'school':
        return Icons.school;
      case 'analytics':
        return Icons.analytics;
      case 'cloud':
        return Icons.cloud;
      case 'storage':
        return Icons.storage;
      case 'security':
        return Icons.security;
      case 'assignment':
        return Icons.assignment;
      default:
        return Icons.work;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Category'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 22, 1, 100),
        foregroundColor: Colors.white,
      ),
      //drawer
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(color: Color.fromARGB(255, 22, 1, 100)),
              child: Text(
                'Menu Utama',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ListTile(title: Text('Settings')),
            ListTile(title: Text('Profile')),
          ],
        ),
      ),
      // ListView.builder
      body: Column(
        children: [
          // Expanded(
          //   //  Expanded
          //   child: ListView.builder(
          //     shrinkWrap: true,
          //     itemCount: listExpert.length,
          //     itemBuilder: (BuildContext context, int index) {
          //       return ListTile(
          //         title: Text(listExpert[index]['profession_name']),
          //       );
          //     },
          //   ),
          // ),
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                childAspectRatio: 0.85,
              ),
              itemCount: listExpert.length,
              itemBuilder: (BuildContext context, int index) {
                final expert = ExpertsModels.fromMap(listExpert[index]);
                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: index % 2 == 0
                        ? const Color(0xFF2E302F)
                        : const Color.fromARGB(255, 13, 0, 61),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _getIconData(expert.iconName),
                        color: Colors.white,
                        size: 32,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        expert.professionName,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey[300], fontSize: 12),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        expert.description,
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey[400], fontSize: 11),
                      ),
                    ],
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
