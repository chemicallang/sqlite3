public namespace sqlite {

protected struct ffi {
    @extern
    func sqlite3_libversion() : *char;

    @extern
    func sqlite3_open(filename : *char, ppDb : *mut *mut sqlite3) : int;

    @extern
    func sqlite3_open_v2(filename : *char, ppDb : *mut *mut sqlite3, flags : int, zVfs : *char) : int;

    @extern
    func sqlite3_close(db : *mut sqlite3) : int;

    @extern
    func sqlite3_close_v2(db : *mut sqlite3) : int;

    @extern
    func sqlite3_prepare_v2(db : *mut sqlite3, zSql : *char, nByte : int, ppStmt : *mut *mut sqlite3_stmt, pzTail : *mut *char) : int;

    @extern
    func sqlite3_finalize(pStmt : *mut sqlite3_stmt) : int;

    @extern
    func sqlite3_step(pStmt : *mut sqlite3_stmt) : int;

    @extern
    func sqlite3_reset(pStmt : *mut sqlite3_stmt) : int;

    @extern
    func sqlite3_clear_bindings(pStmt : *mut sqlite3_stmt) : int;

    @extern
    func sqlite3_exec(db : *mut sqlite3, sql : *char, callback : *void, arg : *void, errmsg : *mut *char) : int;

    @extern
    func sqlite3_last_insert_rowid(db : *mut sqlite3) : i64;

    @extern
    func sqlite3_changes(db : *mut sqlite3) : int;

    @extern
    func sqlite3_total_changes(db : *mut sqlite3) : int;

    @extern
    func sqlite3_busy_timeout(db : *mut sqlite3, ms : int) : int;

    @extern
    func sqlite3_interrupt(db : *mut sqlite3) : void;

    @extern
    func sqlite3_get_autocommit(db : *mut sqlite3) : int;

    @extern
    func sqlite3_errcode(db : *mut sqlite3) : int;

    @extern
    func sqlite3_extended_errcode(db : *mut sqlite3) : int;

    @extern
    func sqlite3_errmsg(db : *mut sqlite3) : *char;

    @extern
    func sqlite3_free(ptr : *void) : void;

    @extern
    func sqlite3_bind_blob(pStmt : *mut sqlite3_stmt, index : int, value : *void, n : int, destructor : *void) : int;

    @extern
    func sqlite3_bind_double(pStmt : *mut sqlite3_stmt, index : int, value : double) : int;

    @extern
    func sqlite3_bind_int(pStmt : *mut sqlite3_stmt, index : int, value : int) : int;

    @extern
    func sqlite3_bind_int64(pStmt : *mut sqlite3_stmt, index : int, value : i64) : int;

    @extern
    func sqlite3_bind_null(pStmt : *mut sqlite3_stmt, index : int) : int;

    @extern
    func sqlite3_bind_text(pStmt : *mut sqlite3_stmt, index : int, value : *char, n : int, destructor : *void) : int;

    @extern
    func sqlite3_bind_value(pStmt : *mut sqlite3_stmt, index : int, value : *sqlite3_value) : int;

    @extern
    func sqlite3_bind_parameter_count(pStmt : *mut sqlite3_stmt) : int;

    @extern
    func sqlite3_bind_parameter_name(pStmt : *mut sqlite3_stmt, index : int) : *char;

    @extern
    func sqlite3_bind_parameter_index(pStmt : *mut sqlite3_stmt, zName : *char) : int;

    @extern
    func sqlite3_column_blob(pStmt : *mut sqlite3_stmt, iCol : int) : *void;

    @extern
    func sqlite3_column_bytes(pStmt : *mut sqlite3_stmt, iCol : int) : int;

    @extern
    func sqlite3_column_double(pStmt : *mut sqlite3_stmt, iCol : int) : double;

    @extern
    func sqlite3_column_int(pStmt : *mut sqlite3_stmt, iCol : int) : int;

    @extern
    func sqlite3_column_int64(pStmt : *mut sqlite3_stmt, iCol : int) : i64;

    @extern
    func sqlite3_column_text(pStmt : *mut sqlite3_stmt, iCol : int) : *char;

    @extern
    func sqlite3_column_type(pStmt : *mut sqlite3_stmt, iCol : int) : int;

    @extern
    func sqlite3_column_value(pStmt : *mut sqlite3_stmt, iCol : int) : *sqlite3_value;

    @extern
    func sqlite3_column_count(pStmt : *mut sqlite3_stmt) : int;

    @extern
    func sqlite3_column_name(pStmt : *mut sqlite3_stmt, iCol : int) : *char;
}

// Opaque types
public struct sqlite3 {}
public struct sqlite3_stmt {}
public struct sqlite3_value {}

}
