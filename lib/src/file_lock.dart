import "dart:io";

class FileLock {
  final String lockFilePath;

  FileLock(this.lockFilePath);

  /// Acquires the lock by creating a lock file. Waits if the lock is held.
  Future<void> lock() async {
    final lockFile = File(lockFilePath);

    while (await lockFile.exists()) {
      await Future.delayed(Duration(milliseconds: 100)); // Wait and retry
    }

    // Create the lock file
    await lockFile.create();
    await lockFile.writeAsString("locked");
  }

  /// Releases the lock by deleting the lock file.
  Future<void> unlock() async {
    final lockFile = File(lockFilePath);
    if (await lockFile.exists()) {
      await lockFile.delete();
    }
  }
}
