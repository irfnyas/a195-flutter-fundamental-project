import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/model/restaurant_model.dart';
import '../../data/service/api_service.dart';
import '../../util/view_result_state.dart';
import 'wishlist_provider.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      context.read<WishlistProvider>().fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
      ),
      body: Center(
        child: Consumer<WishlistProvider>(
          builder: (_, provider, __) {
            return switch (provider.resultState) {
              ViewNoneState() => const WishlistNoneView(),
              ViewErrorState(error: var message) => WishlistErrorView(
                  message: message,
                ),
              ViewLoadedState(restaurants: var restaurants) =>
                WishlistLoadedView(
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

class WishlistNoneView extends StatelessWidget {
  const WishlistNoneView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.food_bank_rounded,
            size: 40,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
          const SizedBox(height: 16),
          const Text(
            'You have no wishlist.\nLet\'s add one into your list now!',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class WishlistErrorView extends StatelessWidget {
  const WishlistErrorView({super.key, this.message});
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

class WishlistLoadedView extends StatelessWidget {
  const WishlistLoadedView({super.key, required this.restaurants});
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
        alignment: Alignment.bottomRight,
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                '${ApiService.imageUrl}/small/${restaurant.pictureId}',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const SizedBox(),
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
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            restaurant.name ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade50,
                                ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            restaurant.city ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Colors.grey.shade50,
                                ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: kToolbarHeight),
                  ],
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
                    .read<WishlistProvider>()
                    .navToDetail(context, restaurant),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            alignment: Alignment.bottomRight,
            child: FloatingActionButton.small(
              heroTag: null,
              onPressed: () => context
                  .read<WishlistProvider>()
                  .removeFromWishlist(context, restaurant),
              elevation: 0,
              shape: const CircleBorder(),
              child: const Icon(Icons.delete_rounded),
            ),
          ),
        ],
      ),
    );
  }
}
