using namespace sqlite;

func main() : int {
    var db_res = Database.open(":memory:");
    var Ok(db) = db_res else return 1;

    db.execute("CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT);") else {
        return 1
    }

    var stmt_res = db.prepare("INSERT INTO users (name) VALUES (?);");
    var Ok(stmt) = stmt_res else return 1

    stmt.bind_text(1, "Alice") else return 1
    stmt.step() else return 1

    stmt.reset() else return 1
    stmt.bind_text(1, "Bob") else return 1
    stmt.step() else return 1

    var query_res = db.prepare("SELECT id, name FROM users;");
    var Ok(query) = query_res else return 1

    while(var Ok(has_row) = query.step() && has_row) {
        const id = query.column_int(0);
        const name = query.column_text(1);
        // use id and name
    }

    return 0
}
