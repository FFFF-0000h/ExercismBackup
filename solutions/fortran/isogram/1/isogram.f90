module isogram
  implicit none

contains

  function isIsogram(phrase) result(no_repeats)
    character(len=*), intent(in) :: phrase
    logical :: no_repeats
    integer :: i, idx
    character :: c
    logical :: seen(26)

    seen = .false.
    no_repeats = .true.

    do i = 1, len(phrase)
       c = phrase(i:i)
       if (('A' <= c .and. c <= 'Z') .or. ('a' <= c .and. c <= 'z')) then
          if ('A' <= c .and. c <= 'Z') then
             idx = ichar(c) - ichar('A') + 1
          else
             idx = ichar(c) - ichar('a') + 1
          end if
          if (seen(idx)) then
             no_repeats = .false.
             return
          else
             seen(idx) = .true.
          end if
       end if
    end do
  end function isIsogram

end module isogram