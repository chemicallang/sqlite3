public namespace sqlite {

public struct Unit {}

public variant Error {
    Code(code : ResultCode)
    Message(msg : std::string)
    
    func to_string(&self) : std::string {
        switch(self) {
            Code(code) => {
                var s = std::string("SQLite Error: ")
                s.append_integer(code as bigint)
                return s
            }
            Message(msg) => {
                var s = std::string("SQLite Error: ")
                s.append_view(msg.to_view())
                return s
            }
        }
    }
}

}
