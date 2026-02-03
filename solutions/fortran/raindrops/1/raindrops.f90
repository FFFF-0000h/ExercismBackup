module raindrops
  implicit none
contains

  function convert(i)
    integer :: i
    character(20) :: convert
    character(20) :: temp
    logical :: has_factor
    
    ! Initialize result string
    temp = ''
    has_factor = .false.
    
    ! Check divisibility by 3
    if (mod(i, 3) == 0) then
      temp = trim(temp) // 'Pling'
      has_factor = .true.
    end if
    
    ! Check divisibility by 5
    if (mod(i, 5) == 0) then
      temp = trim(temp) // 'Plang'
      has_factor = .true.
    end if
    
    ! Check divisibility by 7
    if (mod(i, 7) == 0) then
      temp = trim(temp) // 'Plong'
      has_factor = .true.
    end if
    
    ! If not divisible by 3, 5, or 7, return the number as string
    if (.not. has_factor) then
      write(temp, '(I0)') i
    end if
    
    convert = temp
    
  end function convert

end module raindrops