


import 'package:budgify/features/expense_tracker/utils/filter_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final filterProvider= StateProvider<String>((ref) => FilterType.dateWise.stringValue);