import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../viewmodels/auth_viewmodel.dart';
import '../../../../core/constants/app_routes.dart';

class ChangePasswordPage extends ConsumerStatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  ConsumerState<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends ConsumerState<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _currentController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _currentController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    final current = _currentController.text.trim();
    final nuevo = _newController.text.trim();

    setState(() => _loading = true);
    final authVM = ref.read(authViewModelProvider.notifier);

    try {
      await authVM.changePassword(currentPassword: current, newPassword: nuevo);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Contraseña actualizada correctamente')),
        );
        // Volver a la pantalla anterior
        context.pop();
      }
    } catch (e) {
      final message = ref.read(authErrorProvider) ?? e.toString();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $message')),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cambiar contraseña'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              TextFormField(
                controller: _currentController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Contraseña actual',
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Ingresa tu contraseña actual';
                  if (v.length < 6) return 'Contraseña inválida';
                  return null;
                },
              ),

              const SizedBox(height: 12),

              TextFormField(
                controller: _newController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Nueva contraseña',
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Ingresa la nueva contraseña';
                  if (v.length < 6) return 'La contraseña debe tener al menos 6 caracteres';
                  return null;
                },
              ),

              const SizedBox(height: 12),

              TextFormField(
                controller: _confirmController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirmar nueva contraseña',
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Confirma la nueva contraseña';
                  if (v != _newController.text) return 'Las contraseñas no coinciden';
                  return null;
                },
              ),

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: _loading ? null : _onSubmit,
                child: _loading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Actualizar contraseña'),
              ),

              const SizedBox(height: 12),

              TextButton(
                onPressed: () {
                  // Navegar a recuperar contraseña por email
                  context.push(AppRoutes.forgotPassword);
                },
                child: const Text('¿Olvidaste tu contraseña? Recuperarla por email'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
