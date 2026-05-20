module isbn_verifier
  implicit none

contains

  function isValid(isbn) result(valid)
    character(*), intent(in) :: isbn
    logical :: valid
    integer :: i, pos, sum
    integer :: digits(10)
    character :: ch

    valid = .false.
    pos = 0
    digits = 0

    do i = 1, len_trim(isbn)
      ch = isbn(i:i)
      if (ch == '-') then
        cycle
      else if (ch >= '0' .and. ch <= '9') then
        pos = pos + 1
        if (pos > 10) return
        digits(pos) = ichar(ch) - 48
      else if (ch == 'X' .or. ch == 'x') then
        pos = pos + 1
        if (pos /= 10) return
        digits(pos) = 10
      else
        return
      end if
    end do

    if (pos /= 10) return

    sum = 0
    do i = 1, 10
      sum = sum + digits(i) * (11 - i)
    end do

    if (mod(sum, 11) == 0) valid = .true.
  end function isValid

end module isbn_verifier