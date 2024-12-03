# simple
Simple But Powerful Database For Flutter.


## Usage:

```dart
// Save something in the db
final db = await Simple.instance;
await db.set('counter', _counter.toString());
// Get the saved item from db using key
await db.get('counter');
// Delete from db
await db.delete('counter');
```

**Warning:**
This package is a hobby project for me. It is in a very early stage, use it in your apps at your own risk, i may change its api at any time with any version. Currently it works as a key-value database, but in future i am going to make it a full fledged no sql database for dart applications.
