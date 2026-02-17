module queen_attack
  implicit none
contains

  logical function isValid(pos)
    integer, dimension(2), intent(in) :: pos
    isValid = (pos(1) >= 1 .and. pos(1) <= 8 .and. pos(2) >= 1 .and. pos(2) <= 8)
  end function

  logical function canAttack(white_pos, black_pos)
    integer, dimension(2), intent(in) :: white_pos, black_pos
    canAttack = (white_pos(1) == black_pos(1)) .or. &
                (white_pos(2) == black_pos(2)) .or. &
                (abs(white_pos(1) - black_pos(1)) == abs(white_pos(2) - black_pos(2)))
  end function

end module