module acronym
  implicit none
  private
  
  public :: abbreviate
  
contains

  function abbreviate(s) result(acronym)
    character(len=*), intent(in) :: s
    character(len=:), allocatable :: acronym
    character(len=len_trim(s)) :: temp
    integer :: i, j, len_s
    logical :: new_word, prev_lower
    
    ! Initialize
    temp = ''
    j = 0
    len_s = len_trim(s)
    new_word = .true.
    prev_lower = .false.
    
    do i = 1, len_s
      ! Check for word separators: spaces and hyphens
      if (s(i:i) == ' ' .or. s(i:i) == '-') then
        new_word = .true.
        prev_lower = .false.
      ! Check for letters
      else if (is_letter(s(i:i))) then
        ! Start of a new word
        if (new_word) then
          j = j + 1
          temp(j:j) = to_upper(s(i:i))
          new_word = .false.
          prev_lower = is_lower(s(i:i))
        ! Handle camelCase: current is uppercase, previous was lowercase
        else if (is_upper(s(i:i)) .and. prev_lower) then
          j = j + 1
          temp(j:j) = s(i:i)
          prev_lower = .false.
        else
          prev_lower = is_lower(s(i:i))
        end if
      ! All other characters (punctuation) are ignored
      else
        ! Apostrophe doesn't break word boundaries
        if (s(i:i) == "'") then
          ! Keep track of case for camelCase detection
          if (i > 1 .and. is_letter(s(i-1:i-1))) then
            prev_lower = is_lower(s(i-1:i-1))
          end if
        end if
      end if
    end do
    
    ! Allocate result with exact length
    if (j > 0) then
      acronym = temp(1:j)
    else
      acronym = ''
    end if
    
  end function abbreviate
  
  ! Helper function: convert character to uppercase
  pure function to_upper(ch) result(upper_ch)
    character, intent(in) :: ch
    character :: upper_ch
    integer :: diff
    
    diff = ichar('a') - ichar('A')
    
    if (ch >= 'a' .and. ch <= 'z') then
      upper_ch = char(ichar(ch) - diff)
    else
      upper_ch = ch
    end if
  end function to_upper
  
  ! Helper function: check if character is a letter
  pure function is_letter(ch) result(is_let)
    character, intent(in) :: ch
    logical :: is_let
    
    is_let = (ch >= 'a' .and. ch <= 'z') .or. (ch >= 'A' .and. ch <= 'Z')
  end function is_letter
  
  ! Helper function: check if character is uppercase
  pure function is_upper(ch) result(is_up)
    character, intent(in) :: ch
    logical :: is_up
    
    is_up = (ch >= 'A' .and. ch <= 'Z')
  end function is_upper
  
  ! Helper function: check if character is lowercase
  pure function is_lower(ch) result(is_low)
    character, intent(in) :: ch
    logical :: is_low
    
    is_low = (ch >= 'a' .and. ch <= 'z')
  end function is_lower

end module acronym