public namespace sqlite {

public enum ResultCode : int {
    OK = 0,
    ERROR = 1,
    INTERNAL = 2,
    PERM = 3,
    ABORT = 4,
    BUSY = 5,
    LOCKED = 6,
    NOMEM = 7,
    READONLY = 8,
    INTERRUPT = 9,
    IOERR = 10,
    CORRUPT = 11,
    NOTFOUND = 12,
    FULL = 13,
    CANTOPEN = 14,
    PROTOCOL = 15,
    EMPTY = 16,
    SCHEMA = 17,
    TOOBIG = 18,
    CONSTRAINT = 19,
    MISMATCH = 20,
    MISUSE = 21,
    NOLFS = 22,
    AUTH = 23,
    FORMAT = 24,
    RANGE = 25,
    NOTADB = 26,
    NOTICE = 27,
    WARNING = 28,
    ROW = 100,
    DONE = 101
}

public enum Type : int {
    INTEGER = 1,
    FLOAT = 2,
    TEXT = 3,
    BLOB = 4,
    NULL = 5
}

public enum OpenFlag : int {
    READONLY = 0x00000001,
    READWRITE = 0x00000002,
    CREATE = 0x00000004,
    DELETEONCLOSE = 0x00000008,
    EXCLUSIVE = 0x00000010,
    AUTOPROXY = 0x00000020,
    URI = 0x00000040,
    MEMORY = 0x00000080,
    MAIN_DB = 0x00000100,
    TEMP_DB = 0x00000200,
    TRANSIENT_DB = 0x00000400,
    MAIN_JOURNAL = 0x00000800,
    TEMP_JOURNAL = 0x00001000,
    SUBJOURNAL = 0x00002000,
    MASTER_JOURNAL = 0x00004000,
    NOMUTEX = 0x00008000,
    FULLMUTEX = 0x00010000,
    SHAREDCACHE = 0x00020000,
    PRIVATECACHE = 0x00040000,
    WAL = 0x00080000
}

// Destructor constants for bind_text/blob
protected const SQLITE_STATIC = null as *void;
protected const SQLITE_TRANSIENT = -1 as *void;

}
