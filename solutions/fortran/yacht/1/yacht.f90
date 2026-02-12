module yacht
  implicit none

contains

  integer function score(dice, yacht_type)
    integer, dimension(5), intent(in) :: dice
    character(len=*), intent(in) :: yacht_type
    integer :: i, counts(6), total, max_count, second_max_count
    integer, dimension(5) :: sorted_dice
    
    ! Initialize
    score = 0
    counts = 0
    total = 0
    
    ! Count frequencies and calculate sum
    do i = 1, 5
      counts(dice(i)) = counts(dice(i)) + 1
      total = total + dice(i)
    end do
    
    ! Sort dice for straight detection
    sorted_dice = dice
    call sort_array(sorted_dice, 5)
    
    select case (trim(yacht_type))
      case ("ones")
        score = counts(1) * 1
        
      case ("twos")
        score = counts(2) * 2
        
      case ("threes")
        score = counts(3) * 3
        
      case ("fours")
        score = counts(4) * 4
        
      case ("fives")
        score = counts(5) * 5
        
      case ("sixes")
        score = counts(6) * 6
        
      case ("full house")
        ! Check for 3 of one number and 2 of another
        max_count = maxval(counts)
        second_max_count = 0
        do i = 1, 6
          if (counts(i) < max_count .and. counts(i) > second_max_count) then
            second_max_count = counts(i)
          end if
        end do
        
        if (max_count == 3 .and. second_max_count == 2) then
          score = total
        end if
        
      case ("four of a kind")
        ! Check if any number appears at least 4 times
        do i = 1, 6
          if (counts(i) >= 4) then
            score = i * 4
            exit
          end if
        end do
        
      case ("little straight")
        ! Check for 1-2-3-4-5
        if (sorted_dice(1) == 1 .and. sorted_dice(2) == 2 .and. &
            sorted_dice(3) == 3 .and. sorted_dice(4) == 4 .and. &
            sorted_dice(5) == 5) then
          score = 30
        end if
        
      case ("big straight")
        ! Check for 2-3-4-5-6
        if (sorted_dice(1) == 2 .and. sorted_dice(2) == 3 .and. &
            sorted_dice(3) == 4 .and. sorted_dice(4) == 5 .and. &
            sorted_dice(5) == 6) then
          score = 30
        end if
        
      case ("choice")
        score = total
        
      case ("yacht")
        ! Check if all dice are the same
        if (maxval(counts) == 5) then
          score = 50
        end if
        
    end select
    
  end function score
  
  ! Helper subroutine to sort an integer array
  subroutine sort_array(arr, n)
    integer, dimension(:), intent(inout) :: arr
    integer, intent(in) :: n
    integer :: i, j, temp
    
    do i = 1, n-1
      do j = i+1, n
        if (arr(i) > arr(j)) then
          temp = arr(i)
          arr(i) = arr(j)
          arr(j) = temp
        end if
      end do
    end do
  end subroutine sort_array

end module yacht