module pangram
  implicit none
contains

  logical function is_pangram(sentence)
    character(*) :: sentence
    integer :: i
    logical :: found(26)
    character :: ch, lower_ch
    character(26) :: alphabet = 'abcdefghijklmnopqrstuvwxyz'
    
    ! Initialize
    found = .false.
    
    do i = 1, len(sentence)
      ch = sentence(i:i)
      
      ! Convert to lowercase
      if (ch >= 'A' .and. ch <= 'Z') then
        lower_ch = achar(iachar(ch) + 32)  ! Convert to lowercase
      else
        lower_ch = ch
      end if
      
      ! Check if it's a lowercase letter
      if (lower_ch >= 'a' .and. lower_ch <= 'z') then
        ! Find its position in alphabet
        found(index(alphabet, lower_ch):index(alphabet, lower_ch)) = .true.
      end if
    end do
    
    is_pangram = all(found)
    
  end function is_pangram

end module pangram