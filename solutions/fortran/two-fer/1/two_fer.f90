module two_fer
  implicit none

contains

  function twoFer(name) result(phrase)
    character(*), intent(in), optional :: name
    character(:), allocatable :: phrase

    if (present(name)) then
      phrase = "One for " // trim(name) // ", one for me."
    else
      phrase = "One for you, one for me."
    end if
  end function twoFer

end module two_fer