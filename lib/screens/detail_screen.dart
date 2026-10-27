import 'package:flutter/material.dart';

import '../data/monsters.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.monster});
  final Monster monster;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 360,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(monster.name),
              background: Hero(
                tag: monster.id,
                child: Image.asset(monster.image,
                    fit: BoxFit.cover, alignment: Alignment.topCenter),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList.list(children: [
              Text(monster.english,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: scheme.primary)),
              const SizedBox(height: 4),
              Text('起源：${monster.origin}',
                  style: const TextStyle(color: Colors.white60)),
              const SizedBox(height: 16),
              Row(children: [
                const Text('恐怖指數  '),
                for (var i = 1; i <= 5; i++)
                  Text(i <= monster.scare ? '🎃' : '🕸️',
                      style: const TextStyle(fontSize: 20)),
              ]),
              const SizedBox(height: 16),
              Text(monster.description,
                  style: const TextStyle(fontSize: 16, height: 1.6)),
              const SizedBox(height: 20),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final t in monster.traits) Chip(label: Text(t)),
                ],
              ),
              const SizedBox(height: 20),
              Card(
                margin: EdgeInsets.zero,
                child: ListTile(
                  leading: const Icon(Icons.shield_outlined),
                  title: const Text('弱點'),
                  subtitle: Text(monster.weakness),
                ),
              ),
              const SizedBox(height: 20),
              Text('圖片來源：${monster.imageCredit}（Wikimedia Commons，公有領域）',
                  style: const TextStyle(fontSize: 12, color: Colors.white38)),
            ]),
          ),
        ],
      ),
    );
  }
}
