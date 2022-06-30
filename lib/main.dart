import 'package:flutter/material.dart';
import 'package:themovedb/ui/widgets/app/my_app_model.dart';

import 'ui/widgets/app/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final model = MyAppModel();
  model.checkAuth;
  final app = MyApp(model: model);
  runApp(app);
}
