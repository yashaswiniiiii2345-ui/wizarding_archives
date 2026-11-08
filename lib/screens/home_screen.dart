import 'package:flutter/material.dart';
import '../services/magic_audio.dart';
import 'login_screen.dart';

const Color kGold = Color(0xFFD4AF65);
const Color kDark = Color(0xFF160F18);
const Color kBurgundy = Color(0xFF4A1728);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _housesKey = GlobalKey();

  void _scrollToHouses() {
    final context = _housesKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  Widget _navItem(String label, VoidCallback onTap, {bool isAccent = false}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Text(
            label,
            style: TextStyle(
              color: isAccent ? kGold : Colors.white70,
              fontSize: 12,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDark,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            // Navigation Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              color: const Color(0xFF211722),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: _scrollToTop,
                    child: const MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Text(
                        'THE WIZARDING ARCHIVES',
                        style: TextStyle(
                          color: kGold,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      _navItem('HOME', _scrollToTop),
                      _navItem('HOUSES', _scrollToHouses),
                      _navItem('SPELLBOOK', () {
                        showDialog(
                          context: context,
                          builder: (_) => const SpellbookDialog(),
                        );
                      }),
                      _navItem('CREATURES', () {
                        showDialog(
                          context: context,
                          builder: (_) => const CreaturesDialog(),
                        );
                      }),
                      const SizedBox(width: 8),
                      OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: kGold,
                          side: const BorderSide(color: Color(0xFF92703B)),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        onPressed: () {
                          MagicAudio.playChime();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.logout, size: 14),
                        label: const Text(
                          'LOGOUT',
                          style: TextStyle(
                            fontSize: 11,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Hero Section
            Container(
              width: double.infinity,
              height: 420,
              padding: const EdgeInsets.all(30),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/hogwarts_bg.png'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Color(0x99000000),
                    BlendMode.darken,
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'THE MAGIC BEGINS HERE',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: kGold,
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Discover the secrets, stories and wonders\nof the Wizarding World.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton(
                    onPressed: _scrollToHouses,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kGold,
                      foregroundColor: kDark,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: const Text(
                      'DISCOVER THE HOUSES',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Hogwarts Houses Section
            SizedBox(key: _housesKey, height: 45),
            const Text(
              'THE FOUR HOUSES',
              style: TextStyle(
                color: kGold,
                fontSize: 27,
                fontWeight: FontWeight.bold,
                letterSpacing: 3,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Where will your story begin?',
              style: TextStyle(color: Colors.white70, fontSize: 15),
            ),
            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 20,
                runSpacing: 20,
                children: const [
                  HouseCard(
                    name: 'GRYFFINDOR',
                    quality: 'Courage • Bravery • Determination',
                    color: Color(0xFF8B1E2D),
                    icon: Icons.local_fire_department,
                  ),
                  HouseCard(
                    name: 'SLYTHERIN',
                    quality: 'Ambition • Cunning • Pride',
                    color: Color(0xFF1D593B),
                    icon: Icons.water,
                  ),
                  HouseCard(
                    name: 'RAVENCLAW',
                    quality: 'Wisdom • Intelligence • Wit',
                    color: Color(0xFF243B70),
                    icon: Icons.auto_awesome,
                  ),
                  HouseCard(
                    name: 'HUFFLEPUFF',
                    quality: 'Loyalty • Patience • Fairness',
                    color: Color(0xFF92701D),
                    icon: Icons.wb_sunny,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 55),

            // Explore The Archives Section
            const Text(
              'EXPLORE THE ARCHIVES',
              style: TextStyle(
                color: kGold,
                fontSize: 27,
                fontWeight: FontWeight.bold,
                letterSpacing: 3,
              ),
            ),
            const SizedBox(height: 25),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 20,
                runSpacing: 20,
                children: const [
                  ExploreCard(
                    icon: Icons.menu_book,
                    title: 'THE SPELLBOOK',
                    description: 'Discover spells and enchantments.',
                  ),
                  ExploreCard(
                    icon: Icons.pets,
                    title: 'MAGICAL CREATURES',
                    description: 'Meet the extraordinary beings.',
                  ),
                  ExploreCard(
                    icon: Icons.school,
                    title: 'SORTING HAT',
                    description: 'Discover which house you belong to.',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 60),

            // Footer
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              color: const Color(0xFF211722),
              child: const Text(
                'THE WIZARDING ARCHIVES • A WORLD OF MAGIC AND MYSTERY',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kGold,
                  letterSpacing: 1.5,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// House Card Widget
class HouseCard extends StatelessWidget {
  final String name;
  final String quality;
  final Color color;
  final IconData icon;

  const HouseCard({
    super.key,
    required this.name,
    required this.quality,
    required this.color,
    required this.icon,
  });

  void _showHouseDetails(BuildContext context) {
    MagicAudio.playWandCast();

    final Map<String, Map<String, String>> houseDetails = {
      'GRYFFINDOR': {
        'founder': 'Godric Gryffindor',
        'element': 'Fire',
        'ghost': 'Nearly Headless Nick',
        'values': 'Bravery, nerve, and chivalry.',
      },
      'SLYTHERIN': {
        'founder': 'Salazar Slytherin',
        'element': 'Water',
        'ghost': 'The Bloody Baron',
        'values': 'Ambition, cunning, leadership, and resourcefulness.',
      },
      'RAVENCLAW': {
        'founder': 'Rowena Ravenclaw',
        'element': 'Air',
        'ghost': 'The Grey Lady',
        'values': 'Intelligence, creativity, learning, and wit.',
      },
      'HUFFLEPUFF': {
        'founder': 'Helga Hufflepuff',
        'element': 'Earth',
        'ghost': 'The Fat Friar',
        'values': 'Patience, justice, loyalty, and hard work.',
      },
    };

    final details = houseDetails[name] ?? {};

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF211722),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: color, width: 2),
        ),
        title: Row(
          children: [
            Icon(icon, color: kGold, size: 28),
            const SizedBox(width: 10),
            Text(
              name,
              style: const TextStyle(
                color: kGold,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Founder: ${details['founder'] ?? 'Unknown'}',
                style: const TextStyle(color: Colors.white)),
            const SizedBox(height: 8),
            Text('Element: ${details['element'] ?? 'Unknown'}',
                style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 8),
            Text('House Ghost: ${details['ghost'] ?? 'Unknown'}',
                style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 12),
            Text(
              details['values'] ?? '',
              style: const TextStyle(
                color: Colors.white60,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close', style: TextStyle(color: kGold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _showHouseDetails(context),
        child: Container(
          width: 240,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: color.withOpacity(0.25),
            border: Border.all(color: color, width: 1.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(icon, color: kGold, size: 38),
              const SizedBox(height: 15),
              Text(
                name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: kGold,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                quality,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Explore Card Widget
class ExploreCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const ExploreCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  void _onTap(BuildContext context) {
    MagicAudio.playWandCast();

    final cleaned = title.toUpperCase().trim();
    if (cleaned.contains('SORT')) {
      showDialog(
        context: context,
        builder: (context) => const SortingHatDialog(),
      );
    } else if (cleaned.contains('SPELL')) {
      showDialog(
        context: context,
        builder: (context) => const SpellbookDialog(),
      );
    } else if (cleaned.contains('CREATURE')) {
      showDialog(
        context: context,
        builder: (context) => const CreaturesDialog(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _onTap(context),
        child: Container(
          width: 240,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF29202B),
            border: Border.all(color: kGold.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(icon, color: kGold, size: 36),
              const SizedBox(height: 15),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: kGold,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Sorting Hat Models & Dialog
class QuestionOption {
  final String text;
  final String house;
  const QuestionOption(this.text, this.house);
}

class QuizQuestion {
  final String question;
  final List<QuestionOption> answers;
  const QuizQuestion(this.question, this.answers);
}

class SortingHatDialog extends StatefulWidget {
  const SortingHatDialog({super.key});

  @override
  State<SortingHatDialog> createState() => _SortingHatDialogState();
}

class _SortingHatDialogState extends State<SortingHatDialog> {
  int _currentQuestionIndex = 0;
  final Map<String, int> _houseScores = {
    'Gryffindor': 0,
    'Slytherin': 0,
    'Ravenclaw': 0,
    'Hufflepuff': 0,
  };

  String? _sortedHouse;

  final List<QuizQuestion> _questions = const [
    QuizQuestion(
      'Which quality do you value most in yourself?',
      [
        QuestionOption('Bravery and nerve', 'Gryffindor'),
        QuestionOption('Ambition and cunning', 'Slytherin'),
        QuestionOption('Wisdom and intellect', 'Ravenclaw'),
        QuestionOption('Loyalty and fairness', 'Hufflepuff'),
      ],
    ),
    QuizQuestion(
      'Facing a difficult challenge, what is your approach?',
      [
        QuestionOption('Charge forward without hesitation', 'Gryffindor'),
        QuestionOption('Find the most strategic advantage', 'Slytherin'),
        QuestionOption('Research and analyze every detail', 'Ravenclaw'),
        QuestionOption('Work steadily alongside trusted allies', 'Hufflepuff'),
      ],
    ),
    QuizQuestion(
      'Which magical artifact would you choose?',
      [
        QuestionOption('The Sword of Gryffindor', 'Gryffindor'),
        QuestionOption('The Resurrection Stone', 'Slytherin'),
        QuestionOption('The Lost Diadem', 'Ravenclaw'),
        QuestionOption('The Golden Cup', 'Hufflepuff'),
      ],
    ),
  ];

  void _answerQuestion(String house) {
    _houseScores[house] = (_houseScores[house] ?? 0) + 1;

    if (_currentQuestionIndex < _questions.length - 1) {
      MagicAudio.playChime();
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      String winner = 'Gryffindor';
      int maxScore = -1;
      _houseScores.forEach((h, score) {
        if (score > maxScore) {
          maxScore = score;
          winner = h;
        }
      });

      MagicAudio.playSortingFanfare();

      setState(() {
        _sortedHouse = winner;
      });
    }
  }

  Color _getHouseColor(String? house) {
    switch (house) {
      case 'Gryffindor':
        return const Color(0xFF8B1E2D);
      case 'Slytherin':
        return const Color(0xFF1D593B);
      case 'Ravenclaw':
        return const Color(0xFF243B70);
      case 'Hufflepuff':
        return const Color(0xFF92701D);
      default:
        return const Color(0xFFD4AF65);
    }
  }

  @override
  Widget build(BuildContext context) {
    final houseColor = _getHouseColor(_sortedHouse);

    return AlertDialog(
      backgroundColor: const Color(0xFF1B1017),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: houseColor, width: 2),
      ),
      title: Row(
        children: [
          Icon(Icons.school, color: houseColor, size: 30),
          const SizedBox(width: 12),
          const Text(
            'THE SORTING HAT',
            style: TextStyle(
              color: Color(0xFFD4AF65),
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              fontSize: 18,
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: 420,
        child: _sortedHouse == null
            ? Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Question ${_currentQuestionIndex + 1} of ${_questions.length}',
                    style: const TextStyle(color: Colors.white54, fontSize: 13),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _questions[_currentQuestionIndex].question,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ..._questions[_currentQuestionIndex].answers.map((option) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFFD4AF65),
                          side: const BorderSide(color: Color(0xFF765C3A)),
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 16,
                          ),
                          alignment: Alignment.centerLeft,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () => _answerQuestion(option.house),
                        child: Text(
                          option.text,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    );
                  }),
                ],
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'The Sorting Hat has decided...',
                    style: TextStyle(
                      color: Colors.white70,
                      fontStyle: FontStyle.italic,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    _sortedHouse!.toUpperCase(),
                    style: TextStyle(
                      color: houseColor,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Welcome to your new home in $_sortedHouse!',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'CLOSE',
            style: TextStyle(color: Color(0xFFD4AF65)),
          ),
        ),
      ],
    );
  }
}

// Spellbook Dialog Widget
class SpellItem {
  final String incantation;
  final String type;
  final String effect;
  const SpellItem(this.incantation, this.type, this.effect);
}

class SpellbookDialog extends StatefulWidget {
  const SpellbookDialog({super.key});

  @override
  State<SpellbookDialog> createState() => _SpellbookDialogState();
}

class _SpellbookDialogState extends State<SpellbookDialog> {
  final List<SpellItem> _allSpells = const [
    SpellItem('Expecto Patronum', 'Charm', 'Conjures a protective silver spirit animal against dark entities.'),
    SpellItem('Expelliarmus', 'Charm', 'Disarms an opponent by forcing their wand out of reach.'),
    SpellItem('Lumos Maxima', 'Charm', 'Produces a blinding flash of bright white illumination from the wand tip.'),
    SpellItem('Avada Kedavra', 'Unforgivable Curse', 'Inflicts instant and painless death; impossible to block by normal shields.'),
    SpellItem('Wingardium Leviosa', 'Charm', 'Levitates and maneuvers target objects through the air.'),
    SpellItem('Sectumsempra', 'Dark Magic', 'Lacerates the target as if struck by an invisible sword blade.'),
    SpellItem('Accio', 'Charm', 'Summons an object across great distances straight into the caster\'s hand.'),
    SpellItem('Obliviate', 'Charm', 'Erases specific memories from the subject\'s mind.'),
  ];

  String _filter = '';

  @override
  Widget build(BuildContext context) {
    final filtered = _allSpells
        .where((s) =>
            s.incantation.toLowerCase().contains(_filter.toLowerCase()) ||
            s.type.toLowerCase().contains(_filter.toLowerCase()) ||
            s.effect.toLowerCase().contains(_filter.toLowerCase()))
        .toList();

    return AlertDialog(
      backgroundColor: const Color(0xFF1B1017),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: kGold, width: 1.5),
      ),
      title: Row(
        children: const [
          Icon(Icons.menu_book, color: kGold, size: 28),
          SizedBox(width: 12),
          Text(
            'THE STANDARD BOOK OF SPELLS',
            style: TextStyle(
              color: kGold,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              fontSize: 16,
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: 480,
        height: 440,
        child: Column(
          children: [
            TextField(
              style: const TextStyle(color: Colors.white, fontSize: 14),
              onChanged: (val) => setState(() => _filter = val),
              decoration: InputDecoration(
                hintText: 'Search spells, charms, curses...',
                hintStyle: const TextStyle(color: Colors.white38),
                prefixIcon: const Icon(Icons.search, color: kGold),
                filled: true,
                fillColor: const Color(0xFF281924),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF765C3A)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF765C3A)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: filtered.isEmpty
                  ? const Center(
                      child: Text(
                        'No enchantments found in the archives.',
                        style: TextStyle(color: Colors.white54, fontStyle: FontStyle.italic),
                      ),
                    )
                  : ListView.separated(
                      itemCount: filtered.length,
                      separatorBuilder: (_, __) => const Divider(color: Color(0xFF382333), height: 16),
                      itemBuilder: (context, index) {
                        final spell = filtered[index];
                        final isDark = spell.type.contains('Dark') || spell.type.contains('Unforgivable');
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  spell.incantation,
                                  style: const TextStyle(
                                    color: kGold,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: isDark ? const Color(0xFF4A1017) : const Color(0xFF1E3A5F),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    spell.type,
                                    style: TextStyle(
                                      color: isDark ? Colors.redAccent : Colors.lightBlueAccent,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              spell.effect,
                              style: const TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
                            ),
                          ],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('CLOSE', style: TextStyle(color: kGold)),
        ),
      ],
    );
  }
}

// Creatures Dialog Widget
class CreatureItem {
  final String name;
  final String rating;
  final String habitat;
  final String details;
  const CreatureItem(this.name, this.rating, this.habitat, this.details);
}

class CreaturesDialog extends StatelessWidget {
  const CreaturesDialog({super.key});

  final List<CreatureItem> _creatures = const [
    CreatureItem(
      'Hungarian Horntail',
      'XXXXX (Known Wizard Killer)',
      'Highlands of Hungary',
      'Considered the most perilous dragon breed, wielding bronze horns, yellow eyes, and flame reach up to fifty feet.',
    ),
    CreatureItem(
      'Thestral',
      'XXXX (Dangerous / Specialist Handling)',
      'Forbidden Forest, Hogwarts',
      'Winged skeletal horses visible only to individuals who have witnessed and comprehended death firsthand.',
    ),
    CreatureItem(
      'Phoenix',
      'XXXX (Domestication Rare)',
      'Mountain Peaks of Egypt & India',
      'Immortal crimson bird whose tears possess potent restorative healing properties and bursts into flame when dying.',
    ),
    CreatureItem(
      'Niffler',
      'XXX (Harmless if Unprovoked)',
      'Britain / Underground burrows',
      'Fluffy, long-snouted burrowers obsessive about gathering shimmering treasures and gold coins into deep belly pouches.',
    ),
    CreatureItem(
      'Hippogriff (Buckbeak)',
      'XXX (Requires Formal Etiquette)',
      'European Pastures',
      'Magnificent creature bearing the forelegs, wings, and head of an eagle with the body, hind legs, and tail of a horse.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF1B1017),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFF92701D), width: 1.5),
      ),
      title: Row(
        children: const [
          Icon(Icons.pets, color: kGold, size: 28),
          SizedBox(width: 12),
          Text(
            'FANTASTIC BEASTS & COMPENDIUM',
            style: TextStyle(
              color: kGold,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              fontSize: 16,
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: 480,
        height: 440,
        child: ListView.separated(
          itemCount: _creatures.length,
          separatorBuilder: (_, __) => const Divider(color: Color(0xFF382333), height: 22),
          itemBuilder: (context, index) {
            final creature = _creatures[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      creature.name,
                      style: const TextStyle(
                        color: kGold,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      creature.habitat,
                      style: const TextStyle(color: Colors.white38, fontSize: 11, fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Ministry Classification: ${creature.rating}',
                  style: const TextStyle(
                    color: Color(0xFFD6B46A),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  creature.details,
                  style: const TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
                ),
              ],
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('CLOSE', style: TextStyle(color: kGold)),
        ),
      ],
    );
  }
}