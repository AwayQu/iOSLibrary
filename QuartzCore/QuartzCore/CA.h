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
        int32_t a; // 0x0
        int32_t b; // flag
        int16_t c; // 0x0
        void *layer; // CALayer *
        int16_t d; // 0x0
        int32_t e; // start 0x20
        int8_t *value0x2e;
//        rbx = malloc_zone_malloc(_get_malloc_zone(0x118, @selector(class)), 0x118);
//        *(rbx + 0x8) = 0x0;
//        *(rbx + 0x10) = self;
//        *(rbx + 0x20) = 0x0;
//        *(rbx + 0x18) = 0x0;
//        CA::Layer::State::State(rbx + 0x28, state);
//        *(int32_t *) (rbx + 0x98) = 0x0;
//        *(rbx + 0x90) = 0x0;
//        *(rbx + 0x88) = 0x0;
//        *(int32_t *) (rbx + 0x10c) = 0x0;
//        *(rbx + 0x110) = 0x0;
//        *(rbx + 0xf8) = 0x0;
//        *(rbx + 0xf0) = 0x0;
//        *(rbx + 0xe8) = 0x0;
//        *(rbx + 0xe0) = 0x0;
//        *(rbx + 0xd8) = 0x0;
//        *(rbx + 0xd0) = 0x0;
//        *(rbx + 0xc8) = 0x0;
//        *(rbx + 0xc0) = 0x0;
//        *(rbx + 0xb8) = 0x0;
//        *(rbx + 0xb0) = 0x0;
//        *(rbx + 0xa8) = 0x0;
//        *(rbx + 0xa0) = 0x0;
//        *(int32_t *) rbx = 0x1;
//        *(int32_t *) (rbx + 0x4) = value;
//        *(int32_t *) (rbx + 0x108) = 0x0;
//        *(rbx + 0x100) = 0x0;

        static int32_t *class_state(void *); // objc_class *
        static int32_t layout_if_needed(Transaction *transaction);
        static int32_t thread_flags_(Transaction *transaction);
        static int32_t invalidate_layout();
        static int set_bit(CA::Layer *arg0, unsigned int arg1, unsigned int arg2, bool arg3, void (CA::Layer::*arg4)(CA::Transaction*) );
    };


}