

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../routes/app_routes.dart';
import '../widgets/book_search_delegate.dart';
import '../data/dummy_books.dart';
import '../widgets/book_search_delegate.dart';
import '../models/book_model.dart';
import '../data/library_manager.dart';


List<BookModel> _allBooks(BuildContext ctx) =>
    {...dummyBooks, ...LibraryManager.instance.books.value}.toList();





class CustomDrawer extends StatelessWidget {
  final AnimationController controller;
  final double width;
  final VoidCallback onClose;
  final VoidCallback onToggleTheme; 
       

  const CustomDrawer({
    super.key,
    required this.controller,
    required this.width,
    required this.onClose,
    required this.onToggleTheme,
             
  });
  
  @override
  Widget build(BuildContext context) {
    
    final slideAnimation =
        Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero)
            .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
            

    final overlayOpacity =
        Tween<double>(begin: 0, end: 0.4).animate(controller);

    final textStyle = GoogleFonts.nunito(
        fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.4);

    return  AnimatedBuilder(
  animation: controller,
  builder: (context, child) {
    final bool closed = controller.value == 0;
    return IgnorePointer(
      ignoring: closed,      
      child: child,
    );
  },
  child: Stack(
    children: [
          
          AnimatedBuilder(
            animation: controller,
            builder: (_, __) => controller.value == 0
                ? const SizedBox.shrink()
                : GestureDetector(
                    onTap: onClose, // tap outside to close
                    child: Opacity(
                      opacity: overlayOpacity.value,
                      child: Container(color: Colors.black),
                    ),
                  ),
          ),

          //drawer content
          SlideTransition(
            position: slideAnimation,
            child: SizedBox(
              width: width,
              child: Drawer(
                elevation: 0,
                child: Column(
                  children: [
                    // headerr 
                    Container(
                      width: double.infinity,
                      padding:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 28,
                            backgroundImage:
                                AssetImage('assets/profile_placeholder.png'),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Random',
                                  style: textStyle.copyWith(fontSize: 18)),
                              const SizedBox(height: 4),
                              Text('TBR: 100 books',
                                  style: textStyle.copyWith(
                                      fontSize: 14, fontWeight: FontWeight.w400)),
                              Text('Read: 50 books',
                                  style: textStyle.copyWith(
                                      fontSize: 14, fontWeight: FontWeight.w400)),
                            ],
                          )
                        ],
                      ),
                    ),

                    // menu
                    _DrawerItem(
                      icon: Icons.home,
                      label: 'Home',
                      onTap: onClose,
                    ),

                    _DrawerItem(
  icon: Icons.brightness_6,
  label: 'Theme',
  onTap: () {
    onToggleTheme();
    onClose();
  },
),

                   _DrawerItem(
  icon: Icons.library_books,
  label: 'Library',
  onTap: () {
    Navigator.pushNamed(context, AppRoutes.library);
    onClose();
  },
),

                    _DrawerItem(
  icon: Icons.search,
  label: 'Search',
  onTap: () {
    onClose();
    showSearch(
      context: context,
      delegate: BookSearchDelegate(_allBooks(context)),
    );
  },
),

                    const Spacer(),
                    const Divider(height: 1),
                    _DrawerItem(
                      icon: Icons.logout,
                      label: 'Log Out',
                      onTap: () {},
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label, style: GoogleFonts.nunito(fontWeight: FontWeight.w600)),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
