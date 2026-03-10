module luhn
  implicit none

contains

  function validate(number) result(valid)
    character(*), intent(in) :: number
    logical :: valid

    integer :: i, pos, digit, total, len_clean
    character(len=len(number)) :: clean
    character :: c

    ! Remove spaces and check for non‑digit characters
    len_clean = 0
    do i = 1, len(number)
      c = number(i:i)
      if (c == ' ') cycle
      if (c < '0' .or. c > '9') then
        valid = .false.
        return
      end if
      len_clean = len_clean + 1
      clean(len_clean:len_clean) = c
    end do

    ! Strings of length 0 or 1 are invalid
    if (len_clean <= 1) then
      valid = .false.
      return
    end if

    ! Luhn algorithm: process digits from right to left
    total = 0
    do i = len_clean, 1, -1
      digit = iachar(clean(i:i)) - iachar('0')
      ! Double every second digit (starting from the second rightmost)
      if (mod(len_clean - i + 1, 2) == 0) then
        digit = digit * 2
        if (digit > 9) digit = digit - 9
      end if
      total = total + digit
    end do

    valid = (mod(total, 10) == 0)
  end function validate

end module luhn