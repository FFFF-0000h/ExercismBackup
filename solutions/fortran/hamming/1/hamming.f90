module hamming
  implicit none
contains

  function compute(strand1, strand2, distance)
      character(*) :: strand1, strand2
      integer :: distance
      logical :: compute
      integer :: i, len1, len2
      
      ! Initialize distance to 0
      distance = 0
      
      ! Get lengths of both strands
      len1 = len(strand1)
      len2 = len(strand2)
      
      ! Check if strands are of equal length
      if (len1 /= len2) then
          compute = .false.
          return
      end if
      
      ! Calculate Hamming distance
      do i = 1, len1
          if (strand1(i:i) /= strand2(i:i)) then
              distance = distance + 1
          end if
      end do
      
      ! Return success
      compute = .true.
      
  end function compute

end module hamming