module collatz_conjecture
  implicit none
contains

  integer function steps(i)
    integer, intent(in) :: i
    integer :: n, count
    
    ! Handle edge case: input must be positive
    if (i <= 0) then
      steps = -1
      return
    end if
    
    n = i
    count = 0
    
    ! Apply Collatz rules until we reach 1
    do while (n > 1)
      if (mod(n, 2) == 0) then
        ! n is even: n = n / 2
        n = n / 2
      else
        ! n is odd: n = 3 * n + 1
        n = 3 * n + 1
      end if
      count = count + 1
    end do
    
    steps = count
  end function

end module