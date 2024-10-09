import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idoctusapp/feat/network_image/presentation/providers/network_image_provider.dart';

class NetworkImageScreen extends ConsumerWidget {
  const NetworkImageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catImageState = ref.watch(networkImageStateProvider);

    return Scaffold(
      body: catImageState.when(
        data: (catImage) => Stack(
          fit: StackFit.expand,
          children: [
            GestureDetector(
              onTap: () =>
                  ref.read(networkImageStateProvider.notifier).fetchImage(),
              child: Image.network(
                catImage.url,
                fit: BoxFit.cover,
                color: Colors.black.withOpacity(0.3),
                colorBlendMode: BlendMode.darken,
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Text(
                    "Error al cargar la imagen",
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.white.withOpacity(0.1),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          return ScaleTransition(
                              scale: animation, child: child);
                        },
                        child: GestureDetector(
                          onTap: () => ref
                              .read(networkImageStateProvider.notifier)
                              .fetchImage(),
                          child: Image.network(
                            catImage.url,
                            key: ValueKey<String>(catImage.url),
                            height: 300,
                            width: 300,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                              Icons.error,
                              size: 100,
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 12),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () => ref
                        .read(networkImageStateProvider.notifier)
                        .fetchImage(),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.refresh, size: 24),
                        SizedBox(width: 8),
                        Text("Nueva Imagen", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                  FloatingActionButton(
                    mini: true,
                    splashColor: Colors.blue,
                    backgroundColor: Colors.white,
                    child: const Icon(Icons.logout),
                    onPressed: () async {
                      final shouldLogout = await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Cerrar sesión"),
                            content: const Text("¿Vas a cerrar sesión?"),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: const Text("No"),
                              ),
                              ElevatedButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black38,
                                ),
                                child: const Text(
                                  "Sí",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          );
                        },
                      );

                      if (shouldLogout == true && context.mounted) {
                        Navigator.pushReplacementNamed(context, '/');
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Error al cargar la imagen",
              style: TextStyle(color: Colors.red, fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
              onPressed: () =>
                  ref.read(networkImageStateProvider.notifier).fetchImage(),
              child: const Text("Reintentar"),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.amberAccent.shade100,
    );
  }
}
