module roman_numerals
  implicit none

contains

  function roman(num) result(s)
    integer, value :: num
    character(15) :: s

    ! Arrays of decimal values and corresponding Roman numeral strings
    integer, parameter :: values(13) = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
    character(len=2), parameter :: symbols(13) = ["M ", "CM", "D ", "CD", "C ", "XC", "L ", "XL", "X ", "IX", "V ", "IV", "I "]
    
    integer :: i, pos, n

    ! Initialize output string with spaces
    s = ' '
    pos = 1

    n = num
    do i = 1, size(values)
       do while (n >= values(i))
          ! Append the symbol, trimming trailing space if present
          if (symbols(i)(2:2) == ' ') then
             s(pos:pos) = symbols(i)(1:1)
             pos = pos + 1
          else
             s(pos:pos+1) = symbols(i)
             pos = pos + 2
          end if
          n = n - values(i)
       end do
    end do

    ! The rest of s remains space-padded, which is fine
  end function roman

end module roman_numerals