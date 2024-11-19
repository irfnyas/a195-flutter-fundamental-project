import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/model/restaurant_model.dart';
import '../../data/service/api_service.dart';
import '../../util/view_result_state.dart';
import 'detail_provider.dart';

class DetailScreen extends StatefulWidget {
  final Restaurant restaurant;

  const DetailScreen({
    super.key,
    required this.restaurant,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      context.read<DetailProvider>().fetchData(widget.restaurant.id ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.restaurant.name ?? ''),
      ),
      body: ListView(
        children: [
          Hero(
            tag: widget.restaurant.id ?? '',
            child: Image.network(
              '${ApiService.imageUrl}/small/${widget.restaurant.pictureId}',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const SizedBox(),
            ),
          ),
          Consumer<DetailProvider>(
            builder: (_, provider, __) {
              return switch (provider.resultState) {
                ViewErrorState(error: var message) => DetailErrorView(
                    message: message,
                  ),
                ViewLoadedState(restaurant: var restaurant) => DetailLoadedView(
                    restaurant: restaurant,
                    isWishlisted: provider.isWishlisted,
                  ),
                _ => const LinearProgressIndicator(),
              };
            },
          ),
        ],
      ),
    );
  }
}

class DetailErrorView extends StatelessWidget {
  const DetailErrorView({super.key, this.message});
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
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
      ),
    );
  }
}

class DetailLoadedView extends StatelessWidget {
  const DetailLoadedView({
    super.key,
    required this.restaurant,
    required this.isWishlisted,
  });
  final Restaurant? restaurant;
  final bool isWishlisted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      restaurant?.name ?? '',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      restaurant?.categories?.map((e) => e.name).join(', ') ??
                          '',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => context.read<DetailProvider>().switchWishlist(
                      context,
                      restaurant,
                    ),
                icon: Icon(
                  isWishlisted
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                ),
                style: IconButton.styleFrom(
                  visualDensity: VisualDensity.compact,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(restaurant?.description ?? ''),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.location_on_rounded,
                size: 20,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 12),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Address',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${restaurant?.address}, ${restaurant?.city}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.restaurant_menu_rounded,
                size: 20,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 12),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Foods',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      restaurant?.menus?.foods
                              ?.map((e) => '${e.name}')
                              .join(', ') ??
                          '',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.coffee_rounded,
                size: 20,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 12),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Drinks',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      restaurant?.menus?.drinks
                              ?.map((e) => '${e.name}')
                              .join(', ') ??
                          '',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Customer Reviews',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 12),
              Chip(
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
                  '${restaurant?.rating?.toDouble()}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade50,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...(restaurant?.reviews ?? []).map(
            (e) => Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).focusColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    e.name ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    e.date ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    e.review ?? '',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
