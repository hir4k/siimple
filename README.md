# Siimple
Simple but powerful, easy to use and fast NoSQL database for flutter.


## Usage:

```dart
// Initialize database
final db = Siimple();
await db.initialize();

// Create or get todo collection
final todoCollection = db.collection('todos');

// Create new todo
todoCollection.create({'text': 'This is a dummy todo.'});

// Get all todos
todoCollection.query().findAll();

// Get todos by some conditions
todoCollection.query().where("text__contains", "t").limit(5).findAll();
```

See `/example` for better understanding.