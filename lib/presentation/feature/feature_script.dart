import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:yaml/yaml.dart';

void main() async {
  try {
    final projectRoot = await findProjectRoot();
    if (projectRoot == null) {
      print('Error: Could not find project root (no pubspec.yaml found)');
      exit(1);
    }

    final projectName = await getProjectName(projectRoot);
    if (projectName == null) {
      print('Error: Could not find project name in pubspec.yaml');
      exit(1);
    }

    stdout.write('Enter feature name: ');
    final featureName = stdin.readLineSync()?.trim().toLowerCase();

    if (featureName == null || featureName.isEmpty) {
      print('Feature name cannot be empty');
      exit(1);
    }

    print('\nGenerating feature structure for: $featureName');
    final pascalCaseFeatureName = _toPascalCase(featureName);

    final baseDir = Directory(
        '${projectRoot}/lib/presentation/feature/${featureName}_page');
    final directories = [
      '${baseDir.path}/view',
      '${baseDir.path}/view_model',
      '${baseDir.path}/components',
      '${baseDir.path}/argument',
    ];

    print('\nCreating directories...');
    for (final dir in directories) {
      Directory(dir).createSync(recursive: true);
      print('✓ Created directory: $dir');
    }

    print('\nGenerating files...');
    _createArgumentFile(
        baseDir.path, featureName, pascalCaseFeatureName, projectName);
    _createScreenFile(
        baseDir.path, featureName, pascalCaseFeatureName, projectName);
    _createIntentFile(
        baseDir.path, featureName, pascalCaseFeatureName, projectName);
    _createViewModelFile(
        baseDir.path, featureName, pascalCaseFeatureName, projectName);
    _createStateFile(
        baseDir.path, featureName, pascalCaseFeatureName, projectName);
    _createCounterComponentFile(
        baseDir.path, featureName, pascalCaseFeatureName, projectName);

    print('\nUpdating route configuration...');
    await _updateRouteConfiguration(
        projectRoot, featureName, pascalCaseFeatureName, projectName);

    print('\nUpdating view model registration...');
    await _updateViewModelRegistration(
        projectRoot, featureName, pascalCaseFeatureName, projectName);

    print('\n✓ Feature generation completed successfully!');
    print('Location: ${baseDir.path}');
  } catch (e) {
    print('Error: $e');
    exit(1);
  }
}

Future<String?> findProjectRoot() async {
  Directory current = Directory.current;

  while (true) {
    final pubspecFile = File(path.join(current.path, 'pubspec.yaml'));
    if (await pubspecFile.exists()) {
      return current.path;
    }

    final parent = current.parent;
    if (parent.path == current.path) {
      return null;
    }
    current = parent;
  }
}

Future<String?> getProjectName(String projectRoot) async {
  final pubspecFile = File(path.join(projectRoot, 'pubspec.yaml'));
  final content = await pubspecFile.readAsString();
  final yaml = loadYaml(content);
  return yaml['name'] as String?;
}

void _createArgumentFile(String basePath, String featureName, String pascalCase,
    String projectName) {
  final file = File('$basePath/argument/${featureName}_argument.dart');
  file.writeAsStringSync('''
import 'package:$projectName/presentation/base/base_argument.dart';

class ${pascalCase}Argument extends BaseArgument {}
''');
  print('✓ Created file: ${file.path}');
}

void _createIntentFile(String basePath, String featureName, String pascalCase,
    String projectName) {
  final file = File('$basePath/view_model/${featureName}_intent.dart');
  file.writeAsStringSync('''
abstract class ${pascalCase}Intent {
  const ${pascalCase}Intent();
}

class IncrementCounterIntent extends ${pascalCase}Intent {
  const IncrementCounterIntent();
}

class DecrementCounterIntent extends ${pascalCase}Intent {
  const DecrementCounterIntent();
}

class ResetCounterIntent extends ${pascalCase}Intent {
  const ResetCounterIntent();
}
''');
  print('✓ Created file: ${file.path}');
}

void _createScreenFile(String basePath, String featureName, String pascalCase,
    String projectName) {
  final file = File('$basePath/view/${featureName}_screen.dart');
  file.writeAsStringSync('''
import 'package:flutter/material.dart';
import 'package:$projectName/presentation/base/base_adaptive_screen.dart';
import '../argument/${featureName}_argument.dart';
import '../view_model/${featureName}_view_model.dart';
import '../components/${featureName}_counter.dart';

class ${pascalCase}Screen extends BaseAdaptiveScreen<${pascalCase}ViewModel, ${pascalCase}Argument> {
  const ${pascalCase}Screen({super.key, required super.arguments});

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('${pascalCase}'),
      ),
      body: const ${pascalCase}Counter(),
    );
  }
}
''');
  print('✓ Created file: ${file.path}');
}

void _createViewModelFile(String basePath, String featureName,
    String pascalCase, String projectName) {
  final file = File('$basePath/view_model/${featureName}_view_model.dart');
  file.writeAsStringSync('''
import 'package:$projectName/presentation/base/base_view_model.dart';
import '../argument/${featureName}_argument.dart';
import '${featureName}_state.dart';
import '${featureName}_intent.dart';

class ${pascalCase}ViewModel extends BaseViewModel<${pascalCase}Argument, ${pascalCase}State> {
  ${pascalCase}ViewModel() : super(${pascalCase}State.initial());

  @override
  void onViewReady({${pascalCase}Argument? argument}) {
    _initialize();
  }

  Future<void> _initialize() async {
    updateState(currentState.copyWith(counter: 0));
  }

  void dispatchIntent(${pascalCase}Intent intent) {
    if (intent is IncrementCounterIntent) {
      _incrementCounter();
    } else if (intent is DecrementCounterIntent) {
      _decrementCounter();
    } else if (intent is ResetCounterIntent) {
      _resetCounter();
    }
  }

  void _incrementCounter() {
    updateState(currentState.copyWith(
      counter: currentState.counter + 1,
    ));
  }

  void _decrementCounter() {
    if (currentState.counter > 0) {
      updateState(currentState.copyWith(
        counter: currentState.counter - 1,
      ));
    }
  }

  void _resetCounter() {
    updateState(currentState.copyWith(counter: 0));
  }
}
''');
  print('✓ Created file: ${file.path}');
}

void _createStateFile(String basePath, String featureName, String pascalCase,
    String projectName) {
  final file = File('$basePath/view_model/${featureName}_state.dart');
  file.writeAsStringSync('''
import 'package:$projectName/presentation/base/base_state.dart';

class ${pascalCase}State extends BaseState<${pascalCase}State> {
  final int counter;
  
  ${pascalCase}State({
    required this.counter,
  });

  factory ${pascalCase}State.initial() {
    return ${pascalCase}State(
      counter: 0,
    );
  }

  @override
  ${pascalCase}State copyWith({
    int? counter,
  }) {
    return ${pascalCase}State(
      counter: counter ?? this.counter,
    );
  }
}
''');
  print('✓ Created file: ${file.path}');
}

void _createCounterComponentFile(String basePath, String featureName,
    String pascalCase, String projectName) {
  final file = File('$basePath/components/${featureName}_counter.dart');
  file.writeAsStringSync('''
import 'package:flutter/material.dart';
import 'package:$projectName/presentation/common/extension/context_ext.dart';
import 'package:$projectName/presentation/common/extension/build_for_ext.dart';
import '../view_model/${featureName}_view_model.dart';
import '../view_model/${featureName}_intent.dart';

class ${pascalCase}Counter extends StatelessWidget {
  const ${pascalCase}Counter({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.getViewModel<${pascalCase}ViewModel>();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          viewModel.stateListener.buildFor(
            select: (state) => state.counter,
            builder: (context, state) {
              return Text(
                'Count: \${state.counter}',
                style: Theme.of(context).textTheme.headlineMedium,
              );
            },
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  viewModel.dispatchIntent(const DecrementCounterIntent());
                },
                child: const Text('-'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  viewModel.dispatchIntent(const IncrementCounterIntent());
                },
                child: const Text('+'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              viewModel.dispatchIntent(const ResetCounterIntent());
            },
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}
''');
  print('✓ Created file: ${file.path}');
}

Future<void> _updateRouteConfiguration(String projectRoot, String featureName,
    String pascalCase, String projectName) async {
  final routeFile =
  File('${projectRoot}/lib/presentation/navigation/routes_config.dart');

  if (!await routeFile.exists()) {
    // Create new route file if it doesn't exist
    await _createInitialRouteFile(
        routeFile, featureName, pascalCase, projectName);
    print('✓ Created new route file: ${routeFile.path}');
    return;
  }

  // Read existing content
  String content = await routeFile.readAsString();

  // Add new imports
  final importStatement =
      "import 'package:$projectName/presentation/feature/${featureName}_page/argument/${featureName}_argument.dart';\n"
      "import 'package:$projectName/presentation/feature/${featureName}_page/view/${featureName}_screen.dart';";

  // Find the last import and add new imports after it
  final lastImportIndex = content.lastIndexOf('import');
  final lastImportEndIndex = content.indexOf(';', lastImportIndex) + 1;
  content = content.replaceRange(
      lastImportEndIndex, lastImportEndIndex, '\n$importStatement');

  // Add route path constant
  final routePathConstant = "  static const String ${featureName} = '/${featureName}';";
  final routePathsClassEnd =
  content.indexOf('}', content.indexOf('abstract class RoutePaths'));
  content = content.replaceRange(
      routePathsClassEnd, routePathsClassEnd, '\n$routePathConstant\n');

  // Add route configuration
  final routeConfig = '''
    GoRoute(
      path: RoutePaths.$featureName,
      builder: (context, state) {
        final arguments = state.extra as ${pascalCase}Argument;
        return ${pascalCase}Screen(
          arguments: arguments,
        );
      },
    ),''';

  final routesEnd = content.lastIndexOf(']');
  content = content.replaceRange(routesEnd, routesEnd, '$routeConfig\n');

  // Write updated content back to file
  await routeFile.writeAsString(content);
  print('✓ Updated route configuration in: ${routeFile.path}');
}

Future<void> _updateViewModelRegistration(String projectRoot, String featureName,
    String pascalCase, String projectName) async {
  final registerFile =
  File('${projectRoot}/lib/di/register_modules/view_model_register_module.dart');

  if (!await registerFile.exists()) {
    // Create new register file if it doesn't exist
    await _createInitialRegisterFile(
        registerFile, featureName, pascalCase, projectName);
    print('✓ Created new view model register file: ${registerFile.path}');
    return;
  }

  // Read existing content
  String content = await registerFile.readAsString();

  // Add new import
  final importStatement =
      "import 'package:$projectName/presentation/feature/${featureName}_page/view_model/${featureName}_view_model.dart';";
  final lastImportIndex = content.lastIndexOf('import');
  final lastImportEndIndex = content.indexOf(';', lastImportIndex) + 1;
  content = content.replaceRange(
      lastImportEndIndex, lastImportEndIndex, '\n$importStatement');

  // Add registration
  final registrationStatement =
      "\n    diModule.registerFactory<${pascalCase}ViewModel>(${pascalCase}ViewModel());";
  final lastRegistration = content.lastIndexOf('registerFactory');
  final lastSemicolon = content.indexOf(';', lastRegistration) + 1;
  content = content.replaceRange(
      lastSemicolon, lastSemicolon, registrationStatement);

  // Write updated content back to file
  await registerFile.writeAsString(content);
  print('✓ Updated view model registration in: ${registerFile.path}');
}

Future<void> _createInitialRouteFile(File routeFile, String featureName,
    String pascalCase, String projectName) async {
  final content = '''
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:$projectName/presentation/feature/${featureName}_page/argument/${featureName}_argument.dart';
import 'package:$projectName/presentation/feature/${featureName}_page/view/${featureName}_screen.dart';

abstract class RoutePaths {
  static const String ${featureName} = '/${featureName}';
}

final GoRouter routerConfig = GoRouter(
  initialLocation: RoutePaths.$featureName,
  routes: [
    GoRoute(
      path: RoutePaths.$featureName,
      builder: (context, state) {
        final arguments = state.extra as ${pascalCase}Argument;
        return ${pascalCase}Screen(
          arguments: arguments,
        );
      },
    ),
  ],
);
''';

  await routeFile.create(recursive: true);
  await routeFile.writeAsString(content);
}

Future<void> _createInitialRegisterFile(File registerFile, String featureName,
    String pascalCase, String projectName) async {
  final content = '''
import 'package:$projectName/di/di_module/di_module.dart';
import 'package:$projectName/presentation/feature/${featureName}_page/view_model/${featureName}_view_model.dart';

///This class will always be factory
class ViewModelRegisterModule {
  final diModule = DIModule();

  Future<void> registerViewModels() async {
    diModule.registerFactory<${pascalCase}ViewModel>(${pascalCase}ViewModel());
  }
}
''';

  await registerFile.create(recursive: true);
  await registerFile.writeAsString(content);
}

String _toPascalCase(String text) {
  final words = text.split('_');
  final capitalizedWords = words.map((word) {
    if (word.isEmpty) return '';
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }).toList();
  return capitalizedWords.join();
}