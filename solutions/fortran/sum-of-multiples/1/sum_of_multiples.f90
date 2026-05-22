module sum_of_multiples
  implicit none

contains

  function sum_multiples(factors, limit) result(res)
    integer, intent(in) :: factors(:), limit
    integer :: res
    integer :: i, j
    logical :: is_multiple

    res = 0
    do i = 1, limit - 1
      is_multiple = .false.
      do j = 1, size(factors)
        if (factors(j) /= 0) then
          if (mod(i, factors(j)) == 0) then
            is_multiple = .true.
            exit
          end if
        end if
      end do
      if (is_multiple) res = res + i
    end do
  end function sum_multiples

end module sum_of_multiples