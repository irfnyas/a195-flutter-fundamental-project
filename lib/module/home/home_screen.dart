import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/api/api_service.dart';
import '../../data/model/restaurant_model.dart';
import '../../main_provider.dart';
import '../../util/view_result_state.dart';
import 'home_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      context.read<HomeProvider>().fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Restaurant'),
        actions: [
          Consumer<MainProvider>(
            builder: (_, provider, __) {
              return IconButton(
                onPressed: () => provider.switchThemeMode(context),
                icon: Icon(
                  provider.themeMode == ThemeMode.dark
                      ? Icons.dark_mode_rounded
                      : Icons.dark_mode_outlined,
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Consumer<HomeProvider>(
          builder: (_, provider, __) {
            return switch (provider.resultState) {
              ViewErrorState(error: var message) => HomeErrorView(
                  message: message,
                ),
              ViewLoadedState(restaurants: var restaurants) => HomeLoadedView(
                  restaurants: restaurants ?? [],
                ),
              _ => const CircularProgressIndicator(),
            };
          },
        ),
      ),
    );
  }
}

class HomeErrorView extends StatelessWidget {
  const HomeErrorView({super.key, this.message});
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline_rounded,
            size: 40,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
          const SizedBox(height: 16),
          Text(
            message?.replaceFirst('Exception: ', '') ?? '',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class HomeLoadedView extends StatelessWidget {
  const HomeLoadedView({super.key, required this.restaurants});
  final List<Restaurant> restaurants;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 32),
      itemCount: restaurants.length,
      itemBuilder: (_, i) => RestaurantCard(restaurant: restaurants[i]),
    );
  }
}

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantCard({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Hero(
                tag: restaurant.id ?? '',
                child: Image.network(
                  '${ApiService.imageUrl}/small/${restaurant.pictureId}',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const SizedBox(),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black38,
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Chip(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    avatar: CircleAvatar(
                      backgroundColor: Colors.orange.shade400,
                      child: Icon(
                        Icons.star_rounded,
                        color: Colors.grey.shade50,
                        size: 16,
                      ),
                    ),
                    label: Text(
                      '${restaurant.rating?.toDouble()}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade50,
                          ),
                    ),
                  ),
                ),
                const SizedBox(height: 100),
                Text(
                  restaurant.name ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade50,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  restaurant.city ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey.shade50,
                      ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () => context
                    .read<HomeProvider>()
                    .navToDetail(context, restaurant),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
