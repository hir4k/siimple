# simple
Simple But Powerful NoSQL Database For Flutter.


## Usage:

```dart
// Initialize database
final db = Database();
await db.initialize();

// Create todo collection
final todoCollection = db.collection('todos');

// Create new todo
todoCollection.create({'text': 'This is a dummy todo.'});

// Get all todos
todoCollection.getAll();
```

See `/example` for better understanding.