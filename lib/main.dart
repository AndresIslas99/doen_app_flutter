import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Servicio a Domicilio',
    home: WorkersList(),
  ));
}

class Worker {
  final String name;
  final String job;

  Worker(this.name, this.job);
}

class WorkersList extends StatelessWidget {
  final List<Worker> workers = [
    Worker('Juan', 'Plomero'),
    Worker('Carlos', 'Albañil'),
    // Agrega más trabajadores aquí
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecciona un trabajador'),
      ),
      body: ListView.builder(
        itemCount: workers.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(workers[index].name),
            subtitle: Text(workers[index].job),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => JobDescription(worker: workers[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class JobDescription extends StatefulWidget {
  final Worker worker;

  JobDescription({Key? key, required this.worker}) : super(key: key);

  @override
  _JobDescriptionState createState() => _JobDescriptionState();
}

class _JobDescriptionState extends State<JobDescription> {
  final _formKey = GlobalKey<FormState>();
  late String description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Describe tu problema'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Text('Contratando a ${widget.worker.name}, ${widget.worker.job}'),
            TextFormField(
              decoration: InputDecoration(labelText: 'Descripción del problema'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor describe tu problema.';
                }
                description = value;
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Aquí puedes manejar la contratación del trabajador
                  print('Contratando a ${widget.worker.name} para: $description');
                }
              },
              child: Text('Contratar'),
            ),
          ],
        ),
      ),
    );
  }
}
