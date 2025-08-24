import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../data/greetings_data.dart';

class GreetingsDisplay extends StatefulWidget {
  final List<String> languages;
  
  const GreetingsDisplay({super.key, required this.languages});

  @override
  State<GreetingsDisplay> createState() => _GreetingsDisplayState();
}

class _GreetingsDisplayState extends State<GreetingsDisplay> {
  final FlutterTts flutterTts = FlutterTts();
  String? currentlyPlaying;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _initTts();
  }

  void _initTts() async {
    try {
      // Wait for TTS engine to initialize
      await Future.delayed(const Duration(milliseconds: 100));
      
      // Check if TTS is available
      var engines = await flutterTts.getEngines;
      if (engines != null && engines.isNotEmpty) {
        await flutterTts.setLanguage('en-US');
        await flutterTts.setPitch(1.0);
        await flutterTts.setSpeechRate(0.5);
      }
    } catch (e) {
      debugPrint('TTS initialization error: $e');
    }
    
    flutterTts.setStartHandler(() {
      if (mounted) {
        setState(() {
          isPlaying = true;
        });
      }
    });

    flutterTts.setCompletionHandler(() {
      if (mounted) {
        setState(() {
          isPlaying = false;
          currentlyPlaying = null;
        });
      }
    });

    flutterTts.setErrorHandler((msg) {
      if (mounted) {
        setState(() {
          isPlaying = false;
          currentlyPlaying = null;
        });
      }
      debugPrint('TTS error: $msg');
    });
  }

  Future<void> _speakGreeting(String language, String greeting) async {
    if (isPlaying && currentlyPlaying == language) {
      await flutterTts.stop();
      return;
    }

    try {
      await flutterTts.stop();
      
      String ttsLanguage = _getTtsLanguageCode(language);
      await flutterTts.setLanguage(ttsLanguage);
      await flutterTts.setVolume(1.0);
      
      if (mounted) {
        setState(() {
          currentlyPlaying = language;
        });
      }
      
      await flutterTts.speak(greeting);
    } catch (e) {
      debugPrint('Error speaking greeting: $e');
      if (mounted) {
        setState(() {
          isPlaying = false;
          currentlyPlaying = null;
        });
      }
    }
  }

  String _getTtsLanguageCode(String language) {
    const languageMap = {
      'English': 'en-US',
      'Spanish': 'es-ES',
      'French': 'fr-FR',
      'German': 'de-DE',
      'Italian': 'it-IT',
      'Portuguese': 'pt-PT',
      'Russian': 'ru-RU',
      'Chinese': 'zh-CN',
      'Japanese': 'ja-JP',
      'Korean': 'ko-KR',
      'Arabic': 'ar-SA',
      'Hindi': 'hi-IN',
      'Dutch': 'nl-NL',
      'Swedish': 'sv-SE',
      'Norwegian': 'nb-NO',
      'Danish': 'da-DK',
      'Finnish': 'fi-FI',
      'Polish': 'pl-PL',
      'Turkish': 'tr-TR',
      'Greek': 'el-GR',
      'Hebrew': 'he-IL',
      'Thai': 'th-TH',
      'Vietnamese': 'vi-VN',
      'Indonesian': 'in-ID',
      'Malay': 'ms-MY',
      'Swahili': 'sw-KE',
    };
    return languageMap[language] ?? 'en-US';
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final greetings = GreetingsData.getGreetingForCountry(widget.languages);
    
    if (greetings.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Greetings in Local Languages',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 80,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: greetings.length,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final language = greetings.keys.elementAt(index);
              final greeting = greetings[language]!;
              final isCurrentlyPlaying = currentlyPlaying == language;
              
              return GestureDetector(
                onTap: () => _speakGreeting(language, greeting),
                child: Container(
                  width: 120,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isCurrentlyPlaying 
                        ? theme.colorScheme.primary.withValues(alpha: 0.2)
                        : theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isCurrentlyPlaying 
                          ? theme.colorScheme.primary
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            GreetingsData.getFlag(language),
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            GreetingsData.getLanguageName(language),
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        greeting,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontSize: 11,
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                        ),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Icon(
                        isCurrentlyPlaying ? Icons.stop : Icons.volume_up,
                        size: 16,
                        color: isCurrentlyPlaying 
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}