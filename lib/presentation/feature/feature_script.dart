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
  void onViewReady({${pascalCase}Argument? argument});
  
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
    updateState(state.copyWith(
      counter: state.counter + 1,
    ));
  }

  void _decrementCounter() {
    if (state.counter > 0) {
      updateState(state.copyWith(
        counter: state.counter - 1,
      ));
    }
  }

  void _resetCounter() {
    updateState(state.copyWith(counter: 0));
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
  try {
    final routeConfigFile = File('${projectRoot}/lib/presentation/navigation/routes_config.dart');
    final routesFile = File('${projectRoot}/lib/presentation/navigation/routes.dart');

    // Check if the files exist
    bool routeConfigExists = await routeConfigFile.exists();
    bool routesExists = await routesFile.exists();

    print('Checking navigation files:');
    print('- routes_config.dart exists: $routeConfigExists');
    print('- routes.dart exists: $routesExists');

    if (!routeConfigExists || !routesExists) {
      print('One or both navigation files are missing. Creating them...');
      await _createInitialRouteFiles(
          path.dirname(routeConfigFile.path), featureName, pascalCase, projectName);
      return;
    }

    // First, update the routes.dart file to add the route path
    String routesContent = await routesFile.readAsString();

    // Look for the RoutePaths class in routes.dart
    if (routesContent.contains('class RoutePaths')) {
      print('Found RoutePaths class in routes.dart, adding new route path...');

      // Check if the route constant already exists
      if (!routesContent.contains("static const String $featureName =")) {
        final routePathConstant = "  static const String $featureName = '/${featureName}';";

        // Find the end of the RoutePaths class to add the new route
        final routePathsStart = routesContent.indexOf('class RoutePaths');
        final routePathsEnd = routesContent.indexOf('}', routePathsStart);

        // Add the new route constant
        routesContent = routesContent.replaceRange(
            routePathsEnd, routePathsEnd, '\n$routePathConstant\n');

        await routesFile.writeAsString(routesContent);
        print('✓ Added route path to RoutePaths class in routes.dart');
      } else {
        print('ℹ️ Route path for $featureName already exists in RoutePaths');
      }
    } else {
      print('⚠️ Could not find RoutePaths class in routes.dart');
      return;
    }

    // Now update routes_config.dart to add the imports and route configuration
    String routeConfigContent = await routeConfigFile.readAsString();

    // Add imports for the new feature if they don't exist
    final importStatement =
        "import 'package:$projectName/presentation/feature/${featureName}_page/argument/${featureName}_argument.dart';\n" +
            "import 'package:$projectName/presentation/feature/${featureName}_page/view/${featureName}_screen.dart';";

    if (!routeConfigContent.contains("${featureName}_page")) {
      final lastImportIndex = routeConfigContent.lastIndexOf('import');
      if (lastImportIndex >= 0) {
        final lastImportEndIndex = routeConfigContent.indexOf(';', lastImportIndex) + 1;
        routeConfigContent = routeConfigContent.replaceRange(
            lastImportEndIndex, lastImportEndIndex, '\n$importStatement');
      } else {
        // No imports found, add at the beginning
        routeConfigContent = importStatement + '\n\n' + routeConfigContent;
      }

      print('✓ Added imports for $featureName to routes_config.dart');
    }

    // Check if the route already exists to avoid duplicates
    if (!routeConfigContent.contains("path: RoutePaths.$featureName")) {
      // Create the new route entry
      final routeConfig = '''
    GoRoute(
      path: RoutePaths.$featureName,
      builder: (context, state) {
        final arguments = state.extra as ${pascalCase}Argument;
        return ${pascalCase}Screen(arguments: arguments);
      },
    ),''';

      // Find where to insert the new route
      final routesArrayStart = routeConfigContent.indexOf('routes: [');
      if (routesArrayStart >= 0) {
        final routesArrayEnd = routeConfigContent.indexOf(']', routesArrayStart);
        if (routesArrayEnd >= 0) {
          // Add before the closing bracket of the routes array
          routeConfigContent = routeConfigContent.replaceRange(
              routesArrayEnd, routesArrayEnd, '\n$routeConfig\n  ');
        } else {
          print('⚠️ Could not find end of routes array. Trying alternative approach...');

          // Try to find the last route and add after it
          final lastRouteIndex = routeConfigContent.lastIndexOf('GoRoute(');
          if (lastRouteIndex >= 0) {
            final lastClosingParen = routeConfigContent.indexOf('),', lastRouteIndex);
            if (lastClosingParen >= 0) {
              routeConfigContent = routeConfigContent.replaceRange(
                  lastClosingParen + 2, lastClosingParen + 2, '\n$routeConfig');
            } else {
              print('⚠️ Could not find a good place to insert the route. Adding at the end.');
              routeConfigContent += '\n$routeConfig';
            }
          }
        }

        await routeConfigFile.writeAsString(routeConfigContent);
        print('✓ Added route for $featureName to routes_config.dart');
      } else {
        print('⚠️ Could not find routes array in routes_config.dart.');
      }
    } else {
      print('ℹ️ Route for $featureName already exists in routes_config.dart');
    }
  } catch (e) {
    print('⚠️ Error while updating route configuration: $e');
    print('You may need to manually add the route for $featureName');
  }
}

Future<void> _createInitialRouteFiles(String navigationDirPath, String featureName,
    String pascalCase, String projectName) async {
  try {
    // Ensure the directory exists
    final directory = Directory(navigationDirPath);
    if (!await directory.exists()) {
      await directory.create(recursive: true);
      print('✓ Created navigation directory: $navigationDirPath');
    }

    // Create routes.dart with RoutePaths class
    final routesFile = File('$navigationDirPath/routes.dart');
    final routesContent = '''
part of 'routes_config.dart';

class RoutePaths {
  RoutePaths._();
  
  static const String $featureName = '/${featureName}';
}
''';

    await routesFile.writeAsString(routesContent);
    print('✓ Created routes.dart with RoutePaths class');

    // Create routes_config.dart with router configuration
    final routeConfigFile = File('$navigationDirPath/routes_config.dart');
    final routeConfigContent = '''
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:$projectName/presentation/feature/${featureName}_page/argument/${featureName}_argument.dart';
import 'package:$projectName/presentation/feature/${featureName}_page/view/${featureName}_screen.dart';

part 'routes.dart';

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

    await routeConfigFile.writeAsString(routeConfigContent);
    print('✓ Created routes_config.dart with router configuration');
  } catch (e) {
    print('⚠️ Error creating navigation files: $e');
    print('You may need to manually create the navigation files');
  }
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