module armstrong_numbers
  implicit none
contains

  logical function isArmstrongNumber(i)
    integer, intent(in) :: i
    integer :: num, digit, num_digits, sum, temp
    
    ! Handle negative numbers (not Armstrong by definition)
    if (i < 0) then
      isArmstrongNumber = .false.
      return
    end if
    
    ! Count number of digits
    num = i
    num_digits = 0
    temp = i
    
    do while (temp > 0)
      num_digits = num_digits + 1
      temp = temp / 10
    end do
    
    ! Handle single digit numbers and 0
    if (num_digits == 0) then  ! i = 0
      isArmstrongNumber = .true.  ! 0^1 = 0
      return
    end if
    
    if (num_digits == 1) then
      isArmstrongNumber = .true.  ! All single digit numbers are Armstrong numbers
      return
    end if
    
    ! Calculate sum of digits raised to power of num_digits
    sum = 0
    num = i
    
    do while (num > 0)
      digit = mod(num, 10)  ! Get last digit
      
      ! Raise digit to power of num_digits
      sum = sum + digit ** num_digits
      
      ! Remove last digit
      num = num / 10
    end do
    
    ! Check if sum equals original number
    isArmstrongNumber = (sum == i)
    
  end function isArmstrongNumber

end module armstrong_numbers