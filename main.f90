program main
    use linked_list
    implicit none

    type(list_t) :: list
    integer :: val
    logical :: ok

    call init(list)

    write(*, '(A)') 'Testing linked list operations'
    write(*, '(A)') '=============================='
    write(*, *)

    write(*, '(A,L1)') 'Empty after init: ', is_empty(list)
    write(*, '(A,I0)') 'Size after init: ', list_size(list)
    write(*, *)

    write(*, '(A)') 'push_back 10, 20, 30:'
    call push_back(list, 10)
    call push_back(list, 20)
    call push_back(list, 30)
    call print_list(list)
    write(*, '(A,I0)') 'Size: ', list_size(list)
    write(*, *)

    write(*, '(A)') 'push_front 5:'
    call push_front(list, 5)
    call print_list(list)
    write(*, '(A,I0)') 'Size: ', list_size(list)
    write(*, *)

    write(*, '(A,L1)') 'find 20: ', find(list, 20)
    write(*, '(A,L1)') 'find 99: ', find(list, 99)
    write(*, *)

    write(*, '(A)') 'remove_value 10:'
    call remove_value(list, 10, ok)
    write(*, '(A,L1)') 'Success: ', ok
    call print_list(list)
    write(*, '(A,I0)') 'Size: ', list_size(list)
    write(*, *)

    write(*, '(A)') 'pop_front:'
    call pop_front(list, val, ok)
    write(*, '(A,L1,A,I0)') 'Success: ', ok, ', Value: ', val
    call print_list(list)
    write(*, '(A,I0)') 'Size: ', list_size(list)
    write(*, *)

    write(*, '(A)') 'Testing edge cases:'
    write(*, '(A)') '-------------------'

    write(*, '(A)') 'remove_value 30 (tail):'
    call remove_value(list, 30, ok)
    write(*, '(A,L1)') 'Success: ', ok
    call print_list(list)
    write(*, *)

    write(*, '(A)') 'remove_value 20 (last element):'
    call remove_value(list, 20, ok)
    write(*, '(A,L1)') 'Success: ', ok
    call print_list(list)
    write(*, '(A,L1)') 'Empty: ', is_empty(list)
    write(*, *)

    write(*, '(A)') 'pop_front on empty list:'
    call pop_front(list, val, ok)
    write(*, '(A,L1)') 'Success: ', ok
    write(*, *)

    write(*, '(A)') 'remove_value on empty list:'
    call remove_value(list, 42, ok)
    write(*, '(A,L1)') 'Success: ', ok
    write(*, *)

    write(*, '(A)') 'Refill and clear:'
    call push_back(list, 100)
    call push_back(list, 200)
    call push_back(list, 300)
    call print_list(list)
    call clear(list)
    write(*, '(A)') 'After clear:'
    call print_list(list)
    write(*, '(A,L1)') 'Empty: ', is_empty(list)
    write(*, '(A,I0)') 'Size: ', list_size(list)

end program main
