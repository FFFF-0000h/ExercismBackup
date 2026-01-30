module matrix
  implicit none

contains

  function row(matrix, dims, i) result(r)
    integer, dimension(2), intent(in) :: dims
    !! Matrix dimensions (nrows, ncols)
    character(len=*), dimension(dims(1)), intent(in) :: matrix
    !! Matrix as a 1-d array of strings
    integer, intent(in) :: i
    !! Row index
    integer, dimension(dims(2)) :: r
    integer :: j, start_pos, end_pos, k
    
    ! Parse the i-th row string into integers
    start_pos = 1
    do j = 1, dims(2)
      ! Find next space or end of string
      end_pos = index(matrix(i)(start_pos:), ' ')
      if (end_pos == 0) then
        ! Last number in the row
        read(matrix(i)(start_pos:), *) r(j)
      else
        ! Adjust for substring offset
        end_pos = start_pos + end_pos - 2
        read(matrix(i)(start_pos:end_pos), *) r(j)
        start_pos = end_pos + 2  ! Skip the space
      end if
    end do
  end function

  function column(matrix, dims, j) result(c)
    integer, dimension(2), intent(in) :: dims
    !! Matrix dimensions (nrows, ncols)
    character(len=*), dimension(dims(1)), intent(in) :: matrix
    !! Matrix as a 1-d array of strings
    integer, intent(in) :: j
    !! Column index
    integer, dimension(dims(1)) :: c
    integer :: i, k, start_pos, current_col, pos
    character(len=:), allocatable :: temp_str
    
    do i = 1, dims(1)
      ! Parse the i-th row to find j-th column
      temp_str = trim(adjustl(matrix(i)))
      current_col = 1
      start_pos = 1
      
      ! Find the j-th number in the row
      do while (current_col < j)
        pos = index(temp_str(start_pos:), ' ')
        if (pos == 0) then
          exit  ! Not enough columns in this row
        end if
        start_pos = start_pos + pos
        current_col = current_col + 1
      end do
      
      if (current_col == j) then
        ! Found the j-th column, read the number
        pos = index(temp_str(start_pos:), ' ')
        if (pos == 0) then
          read(temp_str(start_pos:), *) c(i)
        else
          read(temp_str(start_pos:start_pos+pos-2), *) c(i)
        end if
      else
        c(i) = 0  ! Default if column doesn't exist
      end if
    end do
  end function

end module