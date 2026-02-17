module leap
  implicit none

contains

  logical function is_leap_year(year)
    integer, intent(in) :: year

    if (mod(year, 400) == 0) then
      is_leap_year = .true.
    else if (mod(year, 100) == 0) then
      is_leap_year = .false.
    else if (mod(year, 4) == 0) then
      is_leap_year = .true.
    else
      is_leap_year = .false.
    end if
  end function

end module