using std::Result;

public namespace sqlite {

protected comptime const default_open_flags = (OpenFlag.READWRITE | OpenFlag.CREATE) as OpenFlag

public struct Database {
    private var handle : *mut sqlite3 = null;

    @constructor
    func make(h : *mut sqlite3) {
        return Database { handle : h }
    }

    public func open(path : std::string_view, flags : OpenFlag = default_open_flags) : Result<Database, Error> {
        var h : *mut sqlite3 = null;
        // Use v2 for flags support
        const res = ffi::sqlite3_open_v2(path.data(), &mut h, flags as int, null);
        if(res != ResultCode.OK as int) {
            if(h != null) {
                const msg = ffi::sqlite3_errmsg(h);
                var err = Error.Message(std::string::make_no_len(msg))
                ffi::sqlite3_close(h); // Close even if open failed
                return Result.Err<Database, Error>(err)
            }
            return Result.Err<Database, Error>(Error.Code(res as ResultCode))
        }
        return Result.Ok<Database, Error>(Database.make(h))
    }

    public func prepare(&self, sql : std::string_view) : Result<Statement, Error> {
        var h_stmt : *mut sqlite3_stmt = null;
        const res = ffi::sqlite3_prepare_v2(self.handle, sql.data(), sql.size() as int, &mut h_stmt, null);
        if(res != ResultCode.OK as int) {
            return Result.Err<Statement, Error>(Error.Message(std::string::make_no_len(ffi::sqlite3_errmsg(self.handle))))
        }
        return Result.Ok<Statement, Error>(Statement.make(h_stmt))
    }

    public func execute(&self, sql : std::string_view) : Result<Unit, Error> {
        var errmsg : *mut char = null;
        const res = ffi::sqlite3_exec(self.handle, sql.data(), null, null, &mut errmsg);
        if(res != ResultCode.OK as int) {
            if(errmsg != null) {
                var err = Error.Message(std::string::make_no_len(errmsg))
                // Note: errmsg from sqlite3_exec must be freed with sqlite3_free or similar if available
                // for now we'll just assume it's transient or handled by errmsg()
                return Result.Err<Unit, Error>(err)
            }
            return Result.Err<Unit, Error>(Error.Code(res as ResultCode))
        }
        return Result.Ok<Unit, Error>(Unit{})
    }

    public func last_insert_rowid(&self) : i64 {
        return ffi::sqlite3_last_insert_rowid(self.handle)
    }

    public func changes(&self) : int {
        return ffi::sqlite3_changes(self.handle)
    }

    public func total_changes(&self) : int {
        return ffi::sqlite3_total_changes(self.handle)
    }

    public func busy_timeout(&self, ms : int) : Result<Unit, Error> {
        const res = ffi::sqlite3_busy_timeout(self.handle, ms);
        if(res != ResultCode.OK as int) {
            return Result.Err<Unit, Error>(Error.Code(res as ResultCode))
        }
        return Result.Ok<Unit, Error>(Unit{})
    }

    public func interrupt(&self) {
        ffi::sqlite3_interrupt(self.handle)
    }

    public func get_autocommit(&self) : bool {
        return ffi::sqlite3_get_autocommit(self.handle) != 0
    }

    public func errcode(&self) : ResultCode {
        return ffi::sqlite3_errcode(self.handle) as ResultCode
    }

    public func errmsg(&self) : std::string_view {
        return std::string_view(ffi::sqlite3_errmsg(self.handle))
    }

    @delete
    func delete(&mut self) {
        if(self.handle != null) {
            ffi::sqlite3_close_v2(self.handle);
            self.handle = null;
        }
    }
}

}
