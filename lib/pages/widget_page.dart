import 'package:flutter/material.dart';

class WidgetPage extends StatefulWidget {
  const WidgetPage({super.key});

  @override
  _WidgetPageState createState() => _WidgetPageState();
}

class _WidgetPageState extends State<WidgetPage> {
  // Controlador per controlar el zoom
  final TransformationController _controller = TransformationController();

  // Factor de zoom per al Slider
  double _zoomFactor = 1.0;

  // Color del DragTarget
  Color _dragTargetColor = Colors.green;

  // Missatge del DragTarget
  String _dragTargetMessage = 'Drop Here';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Widgets interactius')),
      body: Column(
        children: [
          // Interactive Viewer per mostrar una imatge amb zoom
          InteractiveViewer(
            transformationController:
                _controller, // Aplica el controlador per al zoom
            panEnabled: true, // Permetre fer pan de la imatge
            scaleEnabled: true, // Permetre fer zoom
            child: Image.network(
                'https://images.collectingcars.com/024157/-MG-0395.jpg?w=300&fit=fillmax&crop=edges&auto=format,compress&cs=srgb&q=85'),
          ),

          // Slider per controlar el zoom de la imatge
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Text('Zoom:', style: TextStyle(fontSize: 18)),
                Expanded(
                  child: Slider(
                    value: _zoomFactor,
                    min: 0.5,
                    max: 3.0,
                    onChanged: (double value) {
                      setState(() {
                        _zoomFactor = value; // Actualitzar el valor del zoom
                        _controller.value = Matrix4.identity()
                          ..scale(_zoomFactor); // Aplica el zoom
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

          // Draggable amb una animació de moviment
          Draggable(
            data: 1, // Dada que s'envia al DragTarget
            feedback: Container(
              width: 100,
              height: 100,
              color: Colors.blue,
              child: const Center(
                child: Icon(Icons.drag_indicator, color: Colors.white),
              ),
            ),
            childWhenDragging: Container(
              width: 100,
              height: 100,
              color: Colors.grey,
            ),
            child: Container(
              width: 100,
              height: 100,
              color: Colors.red,
              child: const Center(
                child: Icon(Icons.touch_app, color: Colors.white),
              ),
            ),
          ),

          // DragTarget per interactuar amb l'element Draggable
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: DragTarget<int>(
              onAccept: (data) {
                // Acció quan s'accepta el Draggable
                setState(() {
                  _dragTargetColor =
                      Colors.orange; // Canvia el color del requadre
                  _dragTargetMessage =
                      'Element acceptat!'; // Actualitza el missatge
                });

                // Torna a posar el requadre verd després d'un segon
                Future.delayed(const Duration(seconds: 1), () {
                  setState(() {
                    _dragTargetColor = Colors.green; // Torna al color inicial
                    _dragTargetMessage = 'Drop Here'; // Torna al text inicial
                  });
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Element acceptat!')),
                );
              },
              builder: (context, candidateData, rejectedData) {
                return Container(
                  width: 200,
                  height: 200,
                  color: _dragTargetColor,
                  child: Center(
                    child: Text(
                      _dragTargetMessage,
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),

          // Afegir un Gradient com fons
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.purple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
