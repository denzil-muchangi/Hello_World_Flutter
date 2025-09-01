import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hello_world/root/data/greetings.dart';
import 'package:hello_world/root/data/language_codes.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:responsive_framework/responsive_framework.dart';

class GreetingsList extends StatelessWidget {
  const GreetingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      crossAxisCount: ResponsiveValue(
        context,
        defaultValue: 2,
        conditionalValues: [
          const Condition.smallerThan(name: MOBILE, value: 1),
          const Condition.largerThan(name: TABLET, value: 3),
        ],
      ).value,
      itemCount: greetings.length,
      itemBuilder: (context, index) {
        final language = greetings.keys.elementAt(index);
        final greeting = greetings[language];
        final countryCode = languageCodes[language];

        return Card(
          margin: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: SizedBox(
              width: 40,
              height: 40,
              child: countryCode != null
                  ? SvgPicture.asset(
                      'icons/flags/svg/${countryCode.toLowerCase()}.svg',
                      package: 'country_icons',
                    )
                  : const Icon(Icons.flag),
            ),
            title: Text(
              language,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              greeting!,
              style: TextStyle(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ),
        );
      },
    );
  }
}
