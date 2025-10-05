import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as legacy_provider;

import 'provider/online_users_notifier.dart';
import 'views/provider_view.dart';
import 'views/riverpod_view.dart';
// Estrutura MVVM: viewmodels + repositories

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return legacy_provider.MultiProvider(
      providers: [
        legacy_provider.ChangeNotifierProvider(
          create: (_) => OnlineUsersNotifier(),
        ),
      ],
      child: MaterialApp(
        title: 'Status Online',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ),
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simulador de Status Online')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: const [
            Text(
              'Usando Provider e Riverpod',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Expanded(child: ProviderView()),
            SizedBox(height: 20),
            Expanded(child: RiverpodView()),
          ],
        ),
      ),
    );
  }
}
