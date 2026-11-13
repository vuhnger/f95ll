module linked_list
    implicit none
    private

    type :: node_t
        integer :: value
        type(node_t), pointer :: next => null()
    end type node_t

    type :: list_t
        type(node_t), pointer :: head => null()
        type(node_t), pointer :: tail => null()
        integer :: count = 0
    end type list_t

    public :: node_t, list_t
    public :: init, is_empty, push_front, push_back
    public :: pop_front, find, remove_value, list_size, clear, print_list

contains

    subroutine init(list)
        type(list_t), intent(inout) :: list
        list%head => null()
        list%tail => null()
        list%count = 0
    end subroutine init

    logical function is_empty(list)
        type(list_t), intent(in) :: list
        is_empty = (list%count == 0) .or. (.not. associated(list%head))
    end function is_empty

    subroutine push_front(list, value)
        type(list_t), intent(inout) :: list
        integer, intent(in) :: value
        type(node_t), pointer :: new_node

        allocate(new_node)
        new_node%value = value
        new_node%next => list%head
        list%head => new_node

        if (.not. associated(list%tail)) then
            list%tail => new_node
        end if

        list%count = list%count + 1
    end subroutine push_front

    subroutine push_back(list, value)
        type(list_t), intent(inout) :: list
        integer, intent(in) :: value
        type(node_t), pointer :: new_node

        allocate(new_node)
        new_node%value = value
        new_node%next => null()

        if (.not. associated(list%head)) then
            list%head => new_node
            list%tail => new_node
        else
            list%tail%next => new_node
            list%tail => new_node
        end if

        list%count = list%count + 1
    end subroutine push_back

    subroutine pop_front(list, value, ok)
        type(list_t), intent(inout) :: list
        integer, intent(out) :: value
        logical, intent(out) :: ok
        type(node_t), pointer :: old_head

        if (.not. associated(list%head)) then
            ok = .false.
            value = 0
            return
        end if

        old_head => list%head
        value = old_head%value
        list%head => old_head%next

        if (.not. associated(list%head)) then
            list%tail => null()
        end if

        deallocate(old_head)
        list%count = list%count - 1
        ok = .true.
    end subroutine pop_front

    logical function find(list, value)
        type(list_t), intent(in) :: list
        integer, intent(in) :: value
        type(node_t), pointer :: current

        current => list%head
        do while (associated(current))
            if (current%value == value) then
                find = .true.
                return
            end if
            current => current%next
        end do
        find = .false.
    end function find

    subroutine remove_value(list, value, ok)
        type(list_t), intent(inout) :: list
        integer, intent(in) :: value
        logical, intent(out) :: ok
        type(node_t), pointer :: current, prev, to_remove

        if (.not. associated(list%head)) then
            ok = .false.
            return
        end if

        if (list%head%value == value) then
            to_remove => list%head
            list%head => list%head%next
            if (.not. associated(list%head)) then
                list%tail => null()
            end if
            deallocate(to_remove)
            list%count = list%count - 1
            ok = .true.
            return
        end if

        prev => list%head
        current => list%head%next

        do while (associated(current))
            if (current%value == value) then
                prev%next => current%next
                if (.not. associated(current%next)) then
                    list%tail => prev
                end if
                deallocate(current)
                list%count = list%count - 1
                ok = .true.
                return
            end if
            prev => current
            current => current%next
        end do

        ok = .false.
    end subroutine remove_value

    integer function list_size(list)
        type(list_t), intent(in) :: list
        list_size = list%count
    end function list_size

    subroutine clear(list)
        type(list_t), intent(inout) :: list
        type(node_t), pointer :: current, next_node

        current => list%head
        do while (associated(current))
            next_node => current%next
            deallocate(current)
            current => next_node
        end do

        list%head => null()
        list%tail => null()
        list%count = 0
    end subroutine clear

    subroutine print_list(list)
        type(list_t), intent(in) :: list
        type(node_t), pointer :: current

        write(*, '(A)', advance='no') '['
        current => list%head
        do while (associated(current))
            write(*, '(I0)', advance='no') current%value
            if (associated(current%next)) then
                write(*, '(A)', advance='no') ' '
            end if
            current => current%next
        end do
        write(*, '(A)') ']'
    end subroutine print_list

end module linked_list
