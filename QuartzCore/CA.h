namespace CA {


class Transaction {
public:
    int create();
    
    int ensure();
    int ensure_compat();
    int unlock();
    
}

class Render {
public:
    int memory_once;
}


}