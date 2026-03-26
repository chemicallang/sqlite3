// Modern SQLite3 API for Chemical
// This module provides a high-level, performant wrapper around the SQLite3 C library.

// Export all public components
// (In Chemical, anything public in the module is accessible to importers)

public namespace sqlite {

public func libversion() : std::string_view {
    return std::string_view(ffi::sqlite3_libversion())
}

}