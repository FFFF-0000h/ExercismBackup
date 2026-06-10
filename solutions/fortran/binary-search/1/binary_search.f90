module binary_search
  implicit none

contains

  function find(array, val) result(idx)
    integer, dimension(:), intent(in) :: array
    integer, intent(in) :: val
    integer :: idx

    integer :: left, right, mid

    left = 1
    right = size(array)
    idx = -1                     ! default not found

    do while (left <= right)
      mid = (left + right) / 2
      if (array(mid) == val) then
        idx = mid
        return
      else if (array(mid) < val) then
        left = mid + 1
      else
        right = mid - 1
      end if
    end do
  end function

end module