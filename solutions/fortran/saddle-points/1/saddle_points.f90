module saddle_points
  implicit none

  type :: point_t
    integer :: row
    integer :: column
  end type point_t

contains

  function saddlePoints(matrix) result(points)
    integer, intent(in) :: matrix(:, :)
    type(point_t), allocatable :: points(:)

    integer :: nrows, ncols, i, j, cnt, row_max
    integer, allocatable :: col_min(:)
    type(point_t), allocatable :: temp(:)

    nrows = size(matrix, 1)
    ncols = size(matrix, 2)

    if (nrows == 0 .or. ncols == 0) then
      allocate(points(0))
      return
    end if

    ! Precompute column minima
    allocate(col_min(ncols))
    do j = 1, ncols
      col_min(j) = matrix(1, j)
      do i = 2, nrows
        if (matrix(i, j) < col_min(j)) col_min(j) = matrix(i, j)
      end do
    end do

    ! Temporary storage (maximum possible number of points)
    allocate(temp(nrows * ncols))
    cnt = 0

    do i = 1, nrows
      ! Find row maximum
      row_max = matrix(i, 1)
      do j = 2, ncols
        if (matrix(i, j) > row_max) row_max = matrix(i, j)
      end do

      ! Identify saddle points in this row
      do j = 1, ncols
        if (matrix(i, j) == row_max .and. matrix(i, j) == col_min(j)) then
          cnt = cnt + 1
          temp(cnt) = point_t(row = i, column = j)
        end if
      end do
    end do

    ! Trim to the actual number of points
    allocate(points(cnt))
    if (cnt > 0) then
      points(1:cnt) = temp(1:cnt)
    end if
  end function saddlePoints

end module saddle_points