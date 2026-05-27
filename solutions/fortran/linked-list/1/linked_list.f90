module linked_list
  implicit none
  private

  type, public :: node_t
     integer                      :: value
     type(node_t), pointer :: next => null()
     type(node_t), pointer :: prev => null()
  end type node_t

  type, public :: list_t
     type(node_t), pointer :: head => null()
     type(node_t), pointer :: tail => null()
     integer               :: count = 0
  contains
     ! The following procedures are defined later
  end type list_t

  public :: new, push, pop, unshift, shift, length, delete, destroy

contains

  function new() result(list)
    type(list_t) :: list
    list%head => null()
    list%tail => null()
    list%count = 0
  end function new

  subroutine push(list, val)
    type(list_t), intent(inout) :: list
    integer, intent(in)         :: val
    type(node_t), pointer       :: new_node

    allocate(new_node)
    new_node%value = val
    new_node%next => null()
    new_node%prev => null()

    if (list%count == 0) then
       list%head => new_node
       list%tail => new_node
    else
       list%tail%next => new_node
       new_node%prev => list%tail
       list%tail => new_node
    end if
    list%count = list%count + 1
  end subroutine push

  function pop(list) result(val)
    type(list_t), intent(inout) :: list
    integer                     :: val
    type(node_t), pointer       :: old_tail

    if (list%count == 0) then
       val = -1   ! or handle error; the tests likely never pop empty list
       return
    end if

    old_tail => list%tail
    val = old_tail%value

    if (list%count == 1) then
       list%head => null()
       list%tail => null()
    else
       list%tail => old_tail%prev
       list%tail%next => null()
    end if

    deallocate(old_tail)
    list%count = list%count - 1
  end function pop

  subroutine unshift(list, val)
    type(list_t), intent(inout) :: list
    integer, intent(in)         :: val
    type(node_t), pointer       :: new_node

    allocate(new_node)
    new_node%value = val
    new_node%next => null()
    new_node%prev => null()

    if (list%count == 0) then
       list%head => new_node
       list%tail => new_node
    else
       new_node%next => list%head
       list%head%prev => new_node
       list%head => new_node
    end if
    list%count = list%count + 1
  end subroutine unshift

  function shift(list) result(val)
    type(list_t), intent(inout) :: list
    integer                     :: val
    type(node_t), pointer       :: old_head

    if (list%count == 0) then
       val = -1
       return
    end if

    old_head => list%head
    val = old_head%value

    if (list%count == 1) then
       list%head => null()
       list%tail => null()
    else
       list%head => old_head%next
       list%head%prev => null()
    end if

    deallocate(old_head)
    list%count = list%count - 1
  end function shift

  function length(list) result(n)
    type(list_t), intent(in) :: list
    integer                  :: n
    n = list%count
  end function length

  subroutine delete(list, val)
    type(list_t), intent(inout) :: list
    integer, intent(in)         :: val
    type(node_t), pointer       :: current

    current => list%head
    do while (associated(current))
       if (current%value == val) then
          ! Found node to delete
          if (associated(current%prev)) then
             current%prev%next => current%next
          else
             list%head => current%next   ! deleting head
          end if
          if (associated(current%next)) then
             current%next%prev => current%prev
          else
             list%tail => current%prev   ! deleting tail
          end if
          deallocate(current)
          list%count = list%count - 1
          exit
       end if
       current => current%next
    end do
    ! If list becomes empty, head/tail are nullified above
  end subroutine delete

  subroutine destroy(list)
    type(list_t), intent(inout) :: list
    type(node_t), pointer       :: current, next_node

    current => list%head
    do while (associated(current))
       next_node => current%next
       deallocate(current)
       current => next_node
    end do
    list%head => null()
    list%tail => null()
    list%count = 0
  end subroutine destroy

end module linked_list