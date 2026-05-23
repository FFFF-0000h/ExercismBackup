module darts
  implicit none

contains

  function score(x, y) result(points)
    real, intent(in) :: x, y
    integer :: points
    real :: dist_sq

    dist_sq = x * x + y * y

    if (dist_sq <= 1.0) then
      points = 10
    else if (dist_sq <= 25.0) then
      points = 5
    else if (dist_sq <= 100.0) then
      points = 1
    else
      points = 0
    end if
  end function score

end module darts