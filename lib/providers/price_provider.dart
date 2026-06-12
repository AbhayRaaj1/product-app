import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final priceRangeProvider =
StateProvider<RangeValues>(
      (ref) => const RangeValues(
    0,
    5000,
  ),
);