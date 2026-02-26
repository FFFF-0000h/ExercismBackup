module rational_numbers
  implicit none
contains

  ! Helper: greatest common divisor
  integer function gcd(a, b)
    integer, intent(in) :: a, b
    integer :: x, y, t
    x = abs(a)
    y = abs(b)
    do while (y /= 0)
       t = y
       y = mod(x, y)
       x = t
    end do
    gcd = x
  end function gcd

  ! Reduce rational number to lowest terms with positive denominator
  function reduce(r) result(res)
    integer, dimension(2), intent(in) :: r
    integer, dimension(2) :: res
    integer :: common
    common = gcd(r(1), r(2))
    res(1) = r(1) / common
    res(2) = r(2) / common
    if (res(2) < 0) then
       res(1) = -res(1)
       res(2) = -res(2)
    end if
  end function reduce

  ! Addition
  function add(r1, r2) result(res)
    integer, dimension(2), intent(in) :: r1, r2
    integer, dimension(2) :: res
    integer :: num, den
    num = r1(1)*r2(2) + r2(1)*r1(2)
    den = r1(2)*r2(2)
    res = reduce([num, den])
  end function add

  ! Subtraction
  function sub(r1, r2) result(res)
    integer, dimension(2), intent(in) :: r1, r2
    integer, dimension(2) :: res
    integer :: num, den
    num = r1(1)*r2(2) - r2(1)*r1(2)
    den = r1(2)*r2(2)
    res = reduce([num, den])
  end function sub

  ! Multiplication
  function mul(r1, r2) result(res)
    integer, dimension(2), intent(in) :: r1, r2
    integer, dimension(2) :: res
    integer :: num, den
    num = r1(1)*r2(1)
    den = r1(2)*r2(2)
    res = reduce([num, den])
  end function mul

  ! Division
  function div(r1, r2) result(res)
    integer, dimension(2), intent(in) :: r1, r2
    integer, dimension(2) :: res
    integer :: num, den
    num = r1(1)*r2(2)
    den = r2(1)*r1(2)   ! r2(1) assumed non-zero
    res = reduce([num, den])
  end function div

  ! Absolute value
  function rational_abs(r1) result(res)
    integer, dimension(2), intent(in) :: r1
    integer, dimension(2) :: res
    res = reduce([abs(r1(1)), abs(r1(2))])
  end function rational_abs

  ! Exponentiation to an integer power
  function rational_to_pow(r1, ex) result(res)
    integer, dimension(2), intent(in) :: r1
    integer, intent(in) :: ex
    integer, dimension(2) :: res
    integer :: num, den, p

    if (ex >= 0) then
       num = r1(1)**ex
       den = r1(2)**ex
    else
       p = -ex
       num = r1(2)**p
       den = r1(1)**p
    end if
    res = reduce([num, den])
  end function rational_to_pow

  ! Exponentiation of a real number to a rational power
  function real_to_rational_pow(ex, r1) result(res)
    real, intent(in) :: ex
    integer, dimension(2), intent(in) :: r1
    real :: res
    res = ex ** (real(r1(1)) / real(r1(2)))
  end function real_to_rational_pow

end module rational_numbers