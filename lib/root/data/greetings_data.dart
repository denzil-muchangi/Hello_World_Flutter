class GreetingsData {
  static const Map<String, Map<String, String>> greetings = {
    'English': {
      'hello': 'Hello World',
      'language': 'English',
      'flag': '🇺🇸',
    },
    'Spanish': {
      'hello': 'Hola Mundo',
      'language': 'Español',
      'flag': '🇪🇸',
    },
    'French': {
      'hello': 'Bonjour le Monde',
      'language': 'Français',
      'flag': '🇫🇷',
    },
    'German': {
      'hello': 'Hallo Welt',
      'language': 'Deutsch',
      'flag': '🇩🇪',
    },
    'Italian': {
      'hello': 'Ciao Mondo',
      'language': 'Italiano',
      'flag': '🇮🇹',
    },
    'Portuguese': {
      'hello': 'Olá Mundo',
      'language': 'Português',
      'flag': '🇵🇹',
    },
    'Russian': {
      'hello': 'Привет Мир',
      'language': 'Русский',
      'flag': '🇷🇺',
    },
    'Chinese': {
      'hello': '你好世界',
      'language': '中文',
      'flag': '🇨🇳',
    },
    'Japanese': {
      'hello': 'こんにちは世界',
      'language': '日本語',
      'flag': '🇯🇵',
    },
    'Korean': {
      'hello': '안녕하세요 세계',
      'language': '한국어',
      'flag': '🇰🇷',
    },
    'Arabic': {
      'hello': 'مرحبا بالعالم',
      'language': 'العربية',
      'flag': '🇸🇦',
    },
    'Hindi': {
      'hello': 'नमस्ते दुनिया',
      'language': 'हिंदी',
      'flag': '🇮🇳',
    },
    'Bengali': {
      'hello': 'হ্যালো ওয়ার্ল্ড',
      'language': 'বাংলা',
      'flag': '🇧🇩',
    },
    'Dutch': {
      'hello': 'Hallo Wereld',
      'language': 'Nederlands',
      'flag': '🇳🇱',
    },
    'Swedish': {
      'hello': 'Hej Världen',
      'language': 'Svenska',
      'flag': '🇸🇪',
    },
    'Norwegian': {
      'hello': 'Hallo Verden',
      'language': 'Norsk',
      'flag': '🇳🇴',
    },
    'Danish': {
      'hello': 'Hej Verden',
      'language': 'Dansk',
      'flag': '🇩🇰',
    },
    'Finnish': {
      'hello': 'Hei Maailma',
      'language': 'Suomi',
      'flag': '🇫🇮',
    },
    'Polish': {
      'hello': 'Witaj Świecie',
      'language': 'Polski',
      'flag': '🇵🇱',
    },
    'Turkish': {
      'hello': 'Merhaba Dünya',
      'language': 'Türkçe',
      'flag': '🇹🇷',
    },
    'Greek': {
      'hello': 'Γεια σου Κόσμε',
      'language': 'Ελληνικά',
      'flag': '🇬🇷',
    },
    'Hebrew': {
      'hello': 'שלום עולם',
      'language': 'עברית',
      'flag': '🇮🇱',
    },
    'Thai': {
      'hello': 'สวัสดีชาวโลก',
      'language': 'ไทย',
      'flag': '🇹🇭',
    },
    'Vietnamese': {
      'hello': 'Xin chào Thế giới',
      'language': 'Tiếng Việt',
      'flag': '🇻🇳',
    },
    'Indonesian': {
      'hello': 'Halo Dunia',
      'language': 'Bahasa Indonesia',
      'flag': '🇮🇩',
    },
    'Malay': {
      'hello': 'Halo Dunia',
      'language': 'Bahasa Melayu',
      'flag': '🇲🇾',
    },
    'Swahili': {
      'hello': 'Habari Dunia',
      'language': 'Kiswahili',
      'flag': '🇰🇪',
    },
    'Zulu': {
      'hello': 'Sawubona Mhlaba',
      'language': 'isiZulu',
      'flag': '🇿🇦',
    },
  };

  static String getGreeting(String language) {
    return greetings[language]?['hello'] ?? 'Hello World';
  }

  static String getLanguageName(String language) {
    return greetings[language]?['language'] ?? language;
  }

  static String getFlag(String language) {
    return greetings[language]?['flag'] ?? '🌍';
  }

  static List<String> getAvailableLanguages() {
    return greetings.keys.toList();
  }

  static Map<String, String> getGreetingForCountry(List<String> languages) {
    final availableGreetings = <String, String>{};
    for (var lang in languages) {
      if (greetings.containsKey(lang)) {
        availableGreetings[lang] = greetings[lang]!['hello']!;
      }
    }
    return availableGreetings;
  }
}