import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_profile_model.dart';
import '../viewmodels/auth_viewmodel.dart';
import '../../../core/utils/currency_store.dart';

/// Provider para obtener el perfil completo del usuario desde Firestore
final currentUserProfileProvider = FutureProvider<UserProfileModel?>((
  ref,
) async {
  final currentUser = ref.watch(currentUserProvider);

  if (currentUser == null) {
    return null;
  }

  try {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.id)
        .get();

    if (doc.exists && doc.data() != null) {
    final profile = UserProfileModel.fromMap(doc.data()!);
    // Mantener sincronizado el símbolo de moneda en memoria para widgets
    // que no usan Riverpod directamente.
    CurrencyStore.set(profile.currency);
    return profile;
    }

    return null;
  } catch (e) {
    print('Error loading user profile: $e');
    return null;
  }
});
