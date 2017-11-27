#include <pthread.h>

/**
  int pthread_setspecific(pthread_key_t key, const void *value); 
  
  Description

  The pthread_getspecific() function shall return the value currently 
  bound to the specified key on behalf of the calling thread.
  

  int pthread_setspecific(pthread_key_t key, const void *value);

  Description

  The pthread_setspecific() function shall associate a thread-specific 
  value with a key obtained via a previous call to pthread_key_create(). 
  Different threads may bind different values to the same key. These values 
  are typically pointers to blocks of dynamically allocated memory that 
  have been reserved for use by the calling thread.

   pthread_main_np --	identify the initial thread

   DESCRIPTION
     The pthread_main_np() function is used in userland	threads	environment to
     identify the initial thread.  Its semantics is similar to the Solaris's
     thr_main()	function.
   
   RETURN VALUES
     The pthread_main_np() function returns 1 if the calling thread is the
     initial thread, 0 if the calling thread is	not the	initial	thread,	and -1
     if	the thread's initialization has	not yet	completed.
*/

@implementation CATransaction

+ (void)begin {
    int current_thread = pthread_getspecific(0x48);
    if (current_thread == 0x0) {
            int current_transaction = CA::Transaction::create();
            if (current_transaction != 0x0) {
                    CA::Transaction::push(current_transaction);
            }
    }
    else {
            CA::Transaction::push(current_thread);
    }
    return;
}

+ (void)commit { 
   CA::Transaction::commit_transaction();
   return;
}

+ (void)flush {
   CA::Transaction::flush_transaction();
   return;
}

+ (void)lock {
    rax = CA::Transaction::ensure_compat();
    rcx = *(int32_t *)(rax + 0x20);
    *(int32_t *)(rax + 0x20) = rcx + 0x1;
    if (rcx == 0x0) {
        os_unfair_lock_lock(*(rax + 0x18));
    }
    return;
}


+ (void)unlock {
    CA::Transaction::ensure_compat();
    CA::Transaction::unlock();
    return;
}

@end