module perfect_numbers
  implicit none

contains

  character(len=9) function classify(num)
    integer, intent(in) :: num
    integer :: i, sum, limit

    ! Handle invalid input (non-positive numbers)
    if (num <= 0) then
      classify = "ERROR"
      return
    end if

    sum = 0
    limit = int(sqrt(real(num)))

    do i = 1, limit
      if (mod(num, i) == 0) then
        ! Add the divisor i if it is not the number itself
        if (i < num) sum = sum + i

        ! Add the complementary divisor if it is different from i and not the number itself
        if (i /= num / i .and. num / i < num) sum = sum + num / i
      end if
    end do

    if (sum == num) then
      classify = "perfect"
    else if (sum > num) then
      classify = "abundant"
    else
      classify = "deficient"
    end if
  end function classify

end module perfect_numbers