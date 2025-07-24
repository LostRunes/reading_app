

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/book_card.dart';
import '../widgets/custom_drawer.dart';
import '../models/book_model.dart';
import '../main.dart' show themeNotifier;
import '../routes/app_routes.dart';
import '../data/library_manager.dart';
import '../widgets/book_search_delegate.dart';
import '../data/dummy_books.dart';
import '../widgets/peekaboo_cat.dart';







class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  // controls the animation ofthe sidedrawer thingie
  late final AnimationController _drawerCtrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 250),
  );

  // bookdata to be used by all three sections
  final List<BookModel> dummyBooks = [
    const BookModel(
      title: 'The Art of War',
      author: 'Sun Tzu',
      assetPath: 'assets/the_art_of_war.png',
      category: 'Genre',
    categoryValue: 'Treatise',
    chapters: 13,
    description:
        'Twenty-Five Hundred years ago, Sun Tzu wrote this classic book of military strategy based on Chinese warfare and military thought. Since that time, all levels of military have used the teaching on Sun Tzu to warfare and civilization have adapted these teachings for use in politics, business and everyday life. The Art of War is a book which should be used to gain advantage of opponents in the boardroom and battlefield alike.',
    pdfAssetPath: 'assets/pdfs/the_art_of_war.pdf',
    ),
    const BookModel(
       title: 'Crime and Punishment',
    author: 'Fyodor Dostoevsky',
    assetPath: 'assets/crime_and_punishment.png',
    category: 'Genre',
    categoryValue: 'Psychological Thriller',
    chapters: 39,
    description:
        'Raskolnikov, a destitute and desperate former student, wanders through the slums of St Petersburg and commits a random murder without remorse or regret. He imagines himself to be a great man, a Napoleon: acting for a higher purpose beyond conventional moral law. But as he embarks on a dangerous game of cat and mouse with a suspicious police investigator, Raskolnikov is pursued by the growing voice of his conscience and finds the noose of his own guilt tightening around his neck. Only Sonya, a downtrodden sex worker, can offer the chance of redemption.',
    pdfAssetPath: 'assets/pdfs/crime_and_punishment.pdf',
    ),
    const BookModel(
      title: 'Red, White & Royal Blue',
      author: 'Casey McQuiston',
      assetPath: 'assets/red_white_blue.png',
      category: 'Genre',
    categoryValue: 'RomCom',
    chapters: 15,
    description:
          'What happens when America\'s First Son falls in love with the Prince of Wales? \n When his mother became President, Alex Claremont-Diaz was promptly cast as the American equivalent of a young royal. Handsome, charismatic, genius―his image is pure millennial-marketing gold for the White House. Theres only one problem: Alex has a beef with the actual prince, Henry, across the pond. And when the tabloids get hold of a photo involving an Alex-Henry altercation, U.S./British relations take a turn for the worse. \n  Heads of family, state, and other handlers devise a plan for damage control: staging a truce between the two rivals. What at first begins as a fake, Instragramable friendship grows deeper, and more dangerous, than either Alex or Henry could have imagined. Soon Alex finds himself hurtling into a secret romance with a surprisingly unstuffy Henry that could derail the campaign and upend two nations and begs the question: Can love save the world after all? Where do we find the courage, and the power, to be the people we are meant to be? And how can we learn to let our true colors shine through? Casey McQuiston\'s Red, White & Royal Blue proves: true love isn\'t always diplomatic.',
    pdfAssetPath: 'assets/pdfs/red_white_royal_blue.pdf',
    ),
    const BookModel(
      title: 'The Summer Before the Dark',
      author: 'Doris Lessing',
      assetPath: 'assets/the_summer_before_the_dark.png',
      category: 'Genre',
    categoryValue: 'Domestic Fiction',
    chapters: 5,
    description:
        'The story of a middle-aged woman\'s search for freedom, from Doris Lessing, winner of the Nobel Prize for Literature. Her four children have flown, her husband is otherwise occupied, and after twenty years of being a good wife and mother, Kate Brown is free for a summer of adventure. She plunges into an affair with a younger man, travelling abroad with him, and, on her return to England, meets an extraordinary young woman whose charm and freedom of spirit encourages Kate in her own liberation. Kate\'s new life has brought her a strange unhappiness, but as the summer months unfold, a darker, disquieting journey begins, devastating in its consequences. A novel of self-discovery that bears the hallmarks of Lessing\'s brilliance, honesty and power to move the reader, \'The Summer Before the Dark\' has been hailed by some as Lessing\'s best book.',
    pdfAssetPath: 'assets/pdfs/the_summer_before_the_dark.pdf',
    ),
  ];

 
  // this is so that textstyle uses this particulr font  everywhere
  TextTheme get _textTheme =>
      GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme);


  @override
  Widget build(BuildContext context) {
   final bool isDark = Theme.of(context).brightness == Brightness.dark;
  final String bgPath =
      isDark ? 'assets/home_bg_dark.jpg' : 'assets/home_bg_light.jpg'; // to implement the light theme /dark theme bg image accordingly

  final double drawerWidth = MediaQuery.of(context).size.width * 0.75; // so that drawer takes around 3/4th of the scrren


  
  return Scaffold(
    body: Stack(
      fit: StackFit.expand,
      children: [
        // bg imagee
    Image.asset(bgPath, fit: BoxFit.cover),


Container(
  color: Theme.of(context).brightness == Brightness.dark
      ? Colors.black.withOpacity(0.25)
      : Colors.white.withOpacity(0.10),
),

        
    

    
    Scaffold(
      
      body: Stack(
        children: [
          
          _buildMainContent(drawerWidth),
          // DRAWER
          CustomDrawer(
  controller: _drawerCtrl,
  width: drawerWidth,
  onClose: () => _drawerCtrl.reverse(), // closes the drawer
 
  onToggleTheme: () {
    themeNotifier.value =
        themeNotifier.value == ThemeMode.light
            ? ThemeMode.dark
            : ThemeMode.light;
            
  },
),

        const PeekabooCat(), // ccccaaaattttttthehe
        ],
      ),
    ),
    ],
      ),
    );
  }

  //main content
  Widget _buildMainContent(double drawerWidth) {
    return AnimatedBuilder(
      animation: _drawerCtrl,
      builder: (context, child) {
        // slideffect, sliddes the content too
        final dx = drawerWidth * _drawerCtrl.value;
        return Transform.translate(
          offset: Offset(dx, 0),
          child: child,
        );
      },
      child: SafeArea(
        child: SingleChildScrollView(
    padding: const EdgeInsets.only(bottom: 24), 
    physics: const BouncingScrollPhysics(),     
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // app/top bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                children: [
                  // menu icon
                  IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () => _drawerCtrl.forward(),
                  ),
                  const SizedBox(width: 8),
                  // the title 
                  Text('Mystical Echoes',
                      style:
                          _textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                  const Spacer(),
                  // search button
                  IconButton(
  icon: const Icon(Icons.search),
  onPressed: () => showSearch(
    context: context,
    delegate: BookSearchDelegate(dummyBooks),
  ),
),
                  // profile button
                  IconButton(
                    icon: const CircleAvatar(
                      radius: 16,
                      backgroundImage: AssetImage('assets/profile_placeholder.png'),
                    ),
                    onPressed: () {
                      
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // currently reading
            _buildSectionHeader('Currently Reading'),
            _buildHorizontalList(dummyBooks.take(3).toList()),


            // updated books
            _buildSectionHeader('Updated Books'),
            _buildHorizontalList(dummyBooks.skip(1).take(2).toList()),

            // mybooks
           _buildSectionHeader('My Books',
    trailing: TextButton(
      onPressed: () {
        Navigator.pushNamed(context, AppRoutes.myBooks,
            arguments: dummyBooks); 
      },
      //showall button
      child: const Text('Show All'),
    )),
            _buildHorizontalList(dummyBooks.skip(2).take(3).toList(),
                squareCard: true),
          ],
        ),
      ),
    ),);
  }

  Widget _buildSectionHeader(String title, {Widget? trailing}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Text(title,
              style: _textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
          const Spacer(),
          if (trailing != null) trailing,
        ],
      ),
    );
  }

  Widget _buildHorizontalList(List<BookModel> books,
      {bool squareCard = false}) {
    return SizedBox(
      height: squareCard ? 170 : 220,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: books.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final book = books[index];
          return BookCard(
            book: book,
            square: squareCard,
            onBookmark: () {
  LibraryManager.instance.add(book);   
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Added "${book.title}" to your library')),
  );
},

            onTap: () => Navigator.pushNamed(
  context,
  AppRoutes.bookDetail,
  arguments: book,
),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _drawerCtrl.dispose();
    super.dispose();
  }
}
