module difference_of_squares
  implicit none
contains

  ! Square of the sum of first n natural numbers
  integer function square_of_sum(n)
    integer, intent(in) :: n
    integer :: sum_n
    
    if (n <= 0) then
      square_of_sum = 0
      return
    end if
    
    ! Sum of first n natural numbers: n*(n+1)/2
    sum_n = n * (n + 1) / 2
    square_of_sum = sum_n * sum_n
  end function square_of_sum

  ! Sum of squares of first n natural numbers
  integer function sum_of_squares(n)
    integer, intent(in) :: n
    
    if (n <= 0) then
      sum_of_squares = 0
      return
    end if
    
    ! Sum of squares: n*(n+1)*(2n+1)/6
    sum_of_squares = n * (n + 1) * (2*n + 1) / 6
  end function sum_of_squares

  ! Difference between square of sum and sum of squares
  integer function difference(n)
    integer, intent(in) :: n
    
    difference = square_of_sum(n) - sum_of_squares(n)
  end function difference

end module difference_of_squares