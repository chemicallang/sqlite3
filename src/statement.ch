using std::Result;

public namespace sqlite {

public struct Statement {
    private var handle : *mut sqlite3_stmt = null;

    @constructor
    func make(h : *mut sqlite3_stmt) {
        return Statement { handle : h }
    }

    public func step(&self) : Result<bool, Error> {
        const res = ffi::sqlite3_step(self.handle);
        if(res == ResultCode.ROW as int) {
            return Result.Ok<bool, Error>(true)
        } else if(res == ResultCode.DONE as int) {
            return Result.Ok<bool, Error>(false)
        } else {
            return Result.Err<bool, Error>(Error.Code(res as ResultCode))
        }
    }

    public func reset(&self) : Result<Unit, Error> {
        const res = ffi::sqlite3_reset(self.handle);
        if(res != ResultCode.OK as int) {
            return Result.Err<Unit, Error>(Error.Code(res as ResultCode))
        }
        return Result.Ok<Unit, Error>(Unit{})
    }

    public func clear_bindings(&self) : Result<Unit, Error> {
        const res = ffi::sqlite3_clear_bindings(self.handle);
        if(res != ResultCode.OK as int) {
            return Result.Err<Unit, Error>(Error.Code(res as ResultCode))
        }
        return Result.Ok<Unit, Error>(Unit{})
    }

    // --- Bindings ---

    public func bind_int(&self, index : int, value : int) : Result<Unit, Error> {
        const res = ffi::sqlite3_bind_int(self.handle, index, value);
        if(res != ResultCode.OK as int) {
            return Result.Err<Unit, Error>(Error.Code(res as ResultCode))
        }
        return Result.Ok<Unit, Error>(Unit{})
    }

    public func bind_int64(&self, index : int, value : i64) : Result<Unit, Error> {
        const res = ffi::sqlite3_bind_int64(self.handle, index, value);
        if(res != ResultCode.OK as int) {
            return Result.Err<Unit, Error>(Error.Code(res as ResultCode))
        }
        return Result.Ok<Unit, Error>(Unit{})
    }

    public func bind_double(&self, index : int, value : double) : Result<Unit, Error> {
        const res = ffi::sqlite3_bind_double(self.handle, index, value);
        if(res != ResultCode.OK as int) {
            return Result.Err<Unit, Error>(Error.Code(res as ResultCode))
        }
        return Result.Ok<Unit, Error>(Unit{})
    }

    public func bind_text(&self, index : int, value : std::string_view) : Result<Unit, Error> {
        // Use SQLITE_TRANSIENT to ensure SQLite copies the string
        const res = ffi::sqlite3_bind_text(self.handle, index, value.data(), value.size() as int, SQLITE_TRANSIENT);
        if(res != ResultCode.OK as int) {
            return Result.Err<Unit, Error>(Error.Code(res as ResultCode))
        }
        return Result.Ok<Unit, Error>(Unit{})
    }

    public func bind_null(&self, index : int) : Result<Unit, Error> {
        const res = ffi::sqlite3_bind_null(self.handle, index);
        if(res != ResultCode.OK as int) {
            return Result.Err<Unit, Error>(Error.Code(res as ResultCode))
        }
        return Result.Ok<Unit, Error>(Unit{})
    }

    // --- Columns ---

    public func column_count(&self) : int {
        return ffi::sqlite3_column_count(self.handle)
    }

    public func column_name(&self, index : int) : std::string_view {
        return std::string_view(ffi::sqlite3_column_name(self.handle, index))
    }

    public func column_type(&self, index : int) : Type {
        return ffi::sqlite3_column_type(self.handle, index) as Type
    }

    public func column_int(&self, index : int) : int {
        return ffi::sqlite3_column_int(self.handle, index)
    }

    public func column_int64(&self, index : int) : i64 {
        return ffi::sqlite3_column_int64(self.handle, index)
    }

    public func column_double(&self, index : int) : double {
        return ffi::sqlite3_column_double(self.handle, index)
    }

    public func column_text(&self, index : int) : std::string_view {
        const ptr = ffi::sqlite3_column_text(self.handle, index);
        const bytes = ffi::sqlite3_column_bytes(self.handle, index);
        return std::string_view(ptr, bytes as size_t)
    }

    @delete
    func delete(&mut self) {
        if(self.handle != null) {
            ffi::sqlite3_finalize(self.handle);
            self.handle = null;
        }
    }
}

}
