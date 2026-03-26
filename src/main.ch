// Returns the version string (e.g., "3.45.1")
// Simple test: no arguments, returns a pointer to a string.
@extern
public func sqlite3_libversion() : *char;

// an arbitrary struct
public struct sqlite3 {}

// Opens a database connection.
// filename: UTF-8 path or ":memory:"
// ppDb: Out parameter (pointer to a pointer) where the handle is stored.
@extern
public func sqlite3_open(filename : *char, ppDb : *mut *mut sqlite3) : int;

// Closes the database connection.
// db: The handle obtained from sqlite3_open.
@extern
public func sqlite3_close(db : *mut sqlite3) : int;