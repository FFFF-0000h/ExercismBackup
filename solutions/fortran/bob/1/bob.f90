module bob
  implicit none
  private
  public :: hey
  
  ! Define the possible responses
  character(*), parameter :: WHATEVER = "Whatever."
  character(*), parameter :: CHILL = "Whoa, chill out!"
  character(*), parameter :: SURE = "Sure."
  character(*), parameter :: CALM = "Calm down, I know what I'm doing!"
  character(*), parameter :: FINE = "Fine. Be that way!"

contains

  function hey(statement) result(response)
    character(len=*), intent(in) :: statement
    character(len=len(CALM)) :: response  ! Longest response determines length
    
    logical :: is_question, is_yelling, is_silent, has_letters
    integer :: i, length, last_char
    character :: ch
    
    ! Initialize
    response = WHATEVER
    is_question = .false.
    is_yelling = .false.
    is_silent = .true.
    has_letters = .false.
    
    ! Get actual length ignoring trailing spaces
    length = len_trim(statement)
    
    ! Check if silent (only whitespace)
    if (length == 0) then
      response = FINE
      return
    end if
    
    ! Find last non-space character for question mark check
    last_char = 0
    do i = length, 1, -1
      if (statement(i:i) /= ' ') then
        last_char = i
        exit
      end if
    end do
    
    ! Check if it's a question
    if (last_char > 0) then
      if (statement(last_char:last_char) == '?') then
        is_question = .true.
      end if
    end if
    
    ! Check for yelling and letters
    do i = 1, length
      ch = statement(i:i)
      
      ! Check if it's whitespace
      if (ch == ' ' .or. ch == char(9) .or. ch == char(10) .or. ch == char(13)) then
        cycle
      end if
      
      ! Not silent if we get here
      is_silent = .false.
      
      ! Check if it's a letter
      if ((ch >= 'A' .and. ch <= 'Z') .or. (ch >= 'a' .and. ch <= 'z')) then
        has_letters = .true.
        
        ! If any lowercase letter exists, it's not all caps
        if (ch >= 'a' .and. ch <= 'z') then
          is_yelling = .false.
        end if
      end if
    end do
    
    ! Determine if yelling (all caps)
    if (has_letters) then
      ! First assume yelling, check for lowercase
      is_yelling = .true.
      do i = 1, length
        ch = statement(i:i)
        if (ch >= 'a' .and. ch <= 'z') then
          is_yelling = .false.
          exit
        end if
      end do
    else
      is_yelling = .false.
    end if
    
    ! Apply Bob's response rules in correct order
    if (is_silent) then
      response = FINE
    else if (is_yelling .and. is_question) then
      response = CALM
    else if (is_yelling) then
      response = CHILL
    else if (is_question) then
      response = SURE
    else
      response = WHATEVER
    end if
    
  end function hey

end module bob