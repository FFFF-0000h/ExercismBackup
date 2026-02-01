module nth_prime
  implicit none
contains

  ! get nth prime
  integer function prime(n)
    integer, intent(in) :: n
    integer :: i, candidate, count
    logical :: is_prime
    
    if (n <= 0) then
      prime = -1
      return
    end if
    
    if (n == 1) then
      prime = 2
      return
    end if
    
    count = 1  ! we already have prime #1 (2)
    candidate = 3  ! start checking from 3
    
    do while (count < n)
      is_prime = .true.
      
      ! Check if candidate is prime
      ! Only check up to sqrt(candidate)
      do i = 2, int(sqrt(real(candidate)))
        if (mod(candidate, i) == 0) then
          is_prime = .false.
          exit
        end if
      end do
      
      if (is_prime) then
        count = count + 1
        if (count == n) then
          prime = candidate
          return
        end if
      end if
      
      candidate = candidate + 2  ! check only odd numbers (even > 2 are not prime)
    end do
    
    prime = candidate
  end function prime

end module nth_prime