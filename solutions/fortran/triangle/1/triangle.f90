module triangle
  implicit none

  interface equilateral
    module procedure equilateral_real
    module procedure equilateral_int
  end interface

  interface scalene
    module procedure scalene_real
    module procedure scalene_int
  end interface

  interface isosceles
    module procedure isosceles_real
    module procedure isosceles_int
  end interface

contains

  ! Real version
  logical function equilateral_real(edges)
    real, dimension(3), intent(in) :: edges
    real :: a, b, c
    a = edges(1)
    b = edges(2)
    c = edges(3)

    ! Check triangle validity
    if (a <= 0.0 .or. b <= 0.0 .or. c <= 0.0) then
      equilateral_real = .false.
      return
    end if
    if (a + b < c .or. b + c < a .or. a + c < b) then
      equilateral_real = .false.
      return
    end if

    equilateral_real = (a == b .and. b == c)
  end function equilateral_real

  ! Integer version
  logical function equilateral_int(edges)
    integer, dimension(3), intent(in) :: edges
    integer :: a, b, c
    a = edges(1)
    b = edges(2)
    c = edges(3)

    ! Check triangle validity
    if (a <= 0 .or. b <= 0 .or. c <= 0) then
      equilateral_int = .false.
      return
    end if
    if (a + b < c .or. b + c < a .or. a + c < b) then
      equilateral_int = .false.
      return
    end if

    equilateral_int = (a == b .and. b == c)
  end function equilateral_int

  ! Real version
  logical function isosceles_real(edges)
    real, dimension(3), intent(in) :: edges
    real :: a, b, c
    a = edges(1)
    b = edges(2)
    c = edges(3)

    ! Check triangle validity
    if (a <= 0.0 .or. b <= 0.0 .or. c <= 0.0) then
      isosceles_real = .false.
      return
    end if
    if (a + b < c .or. b + c < a .or. a + c < b) then
      isosceles_real = .false.
      return
    end if

    isosceles_real = (a == b .or. b == c .or. a == c)
  end function isosceles_real

  ! Integer version
  logical function isosceles_int(edges)
    integer, dimension(3), intent(in) :: edges
    integer :: a, b, c
    a = edges(1)
    b = edges(2)
    c = edges(3)

    ! Check triangle validity
    if (a <= 0 .or. b <= 0 .or. c <= 0) then
      isosceles_int = .false.
      return
    end if
    if (a + b < c .or. b + c < a .or. a + c < b) then
      isosceles_int = .false.
      return
    end if

    isosceles_int = (a == b .or. b == c .or. a == c)
  end function isosceles_int

  ! Real version
  logical function scalene_real(edges)
    real, dimension(3), intent(in) :: edges
    real :: a, b, c
    a = edges(1)
    b = edges(2)
    c = edges(3)

    ! Check triangle validity
    if (a <= 0.0 .or. b <= 0.0 .or. c <= 0.0) then
      scalene_real = .false.
      return
    end if
    if (a + b < c .or. b + c < a .or. a + c < b) then
      scalene_real = .false.
      return
    end if

    scalene_real = (a /= b .and. b /= c .and. a /= c)
  end function scalene_real

  ! Integer version
  logical function scalene_int(edges)
    integer, dimension(3), intent(in) :: edges
    integer :: a, b, c
    a = edges(1)
    b = edges(2)
    c = edges(3)

    ! Check triangle validity
    if (a <= 0 .or. b <= 0 .or. c <= 0) then
      scalene_int = .false.
      return
    end if
    if (a + b < c .or. b + c < a .or. a + c < b) then
      scalene_int = .false.
      return
    end if

    scalene_int = (a /= b .and. b /= c .and. a /= c)
  end function scalene_int

end module triangle