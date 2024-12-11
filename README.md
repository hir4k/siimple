
![Siimple Logo](assets/siimple-logo-x180.png)


# Siimple ✨


Siimple is a lightweight, file-based NoSQL database built for Flutter and Dart applications. It is designed to be simple, efficient, and easy to integrate into your projects. Perfect for offline-first apps or single-user environments.

> ⚠️ **Warning:** This package is not ready for production use yet. The API may change at any time.

---

## Features 🌟

- **Lightweight**: No unnecessary overhead; optimized for simplicity.
- **CRUD Operations**: Create, Read, Update, and Delete data with ease.
- **File-Based Storage**: Stores data in a JSON file on the filesystem.
- **Multi-Process Safety**: Includes a lightweight file-locking mechanism for safe writes.

---

## Installation ⚙️

Add Siimple to your `pubspec.yaml`:

```yaml
dependencies:
  siimple: ^0.0.6
```

Then run:

```sh
dart pub get
```

---

## Getting Started ⚡


```dart
import 'package:siimple/siimple.dart';

void main() async {
  final db = Siimple();

  await db.load();
  
  final todos = db.collection('todos');

  // Add some data
  todos.create({'id': '1', 'text': 'Learn Siimple', 'completed': false});

  // Query data
  final allTodos = todos.getAll();
  print(allTodos);

  // Get todos by some conditions
  todoCollection.query().where("text__contains", "t").limit(5).findAll();
}
```

### Example CRUD Operations 📊

#### Create
```dart
final todos = db.collection('todos');
todos.create({'id': '2', 'text': 'Build an app', 'completed': false});
```

#### Read
```dart
// Get todo by id
final todo = todos.get('2');
print(todo);
```

#### Update
```dart
todos.update('2', {'completed': true});
```

#### Delete
```dart
todos.delete('2');
```

---

## Contributing ❤️

We welcome contributions! Feel free to fork the repo and submit a pull request. Ensure your code follows Dart best practices.
