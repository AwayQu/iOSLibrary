#import <dispatch/once.h>
#import <cstdint>

namespace CA {


    class Transaction {
    public:
        static Transaction *create();

        static Transaction *ensure();

        static Transaction *ensure_compat();

        static int commit_transaction();

        static int flush_transaction();

        static int ensure_implicit();

        static int unlock();

        static int push(Transaction *);

    };

    class Render {
    public:
        static dispatch_once_t *memory_once;
    };

    class Layer {
    public:
        static int32_t *class_state(void *); // objc_class *
    };


}