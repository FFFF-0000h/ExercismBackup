module sieve
  implicit none

contains

  function primes(limit) result(array)
    integer, intent(in) :: limit
    integer, allocatable :: array(:)

    integer :: i, j, num_primes
    logical, allocatable :: is_prime(:)
    real :: sqrt_limit

    if (limit < 2) then
      allocate(array(0))
      return
    end if

    allocate(is_prime(2:limit))
    is_prime = .true.

    sqrt_limit = sqrt(real(limit))

    do i = 2, int(sqrt_limit)
      if (is_prime(i)) then
        do j = i * i, limit, i
          is_prime(j) = .false.
        end do
      end if
    end do

    num_primes = count(is_prime)
    allocate(array(num_primes))
    num_primes = 0
    do i = 2, limit
      if (is_prime(i)) then
        num_primes = num_primes + 1
        array(num_primes) = i
      end if
    end do

    deallocate(is_prime)
  end function primes

end module sieve