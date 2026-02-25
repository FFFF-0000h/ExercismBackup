module high_scores
  implicit none
  private
  public :: scores, latest, personalBest, personalTopThree

contains

  ! Retorna todos os scores
  function scores(scores_array) result(out_scores)
    integer, intent(in) :: scores_array(:)
    integer :: out_scores(size(scores_array))
    out_scores = scores_array
  end function scores

  ! Retorna o último score adicionado
  function latest(scores_array) result(score)
    integer, intent(in) :: scores_array(:)
    integer :: score
    if (size(scores_array) > 0) then
       score = scores_array(size(scores_array))
    else
       score = 0
    end if
  end function latest

  ! Retorna o maior score
  function personalBest(scores_array) result(score)
    integer, intent(in) :: scores_array(:)
    integer :: score
    integer :: i
    if (size(scores_array) == 0) then
       score = 0
    else
       score = scores_array(1)
       do i = 2, size(scores_array)
          if (scores_array(i) > score) score = scores_array(i)
       end do
    end if
  end function personalBest

  ! Retorna os três maiores scores em ordem decrescente
  function personalTopThree(scores_array) result(top_scores)
    integer, intent(in) :: scores_array(:)
    integer :: top_scores(3)
    integer :: temp(size(scores_array))
    integer :: n, i, j, tmp

    n = size(scores_array)
    temp = scores_array
    
    ! Bubble sort decrescente
    do i = 1, n-1
       do j = 1, n-i
          if (temp(j) < temp(j+1)) then
             tmp = temp(j)
             temp(j) = temp(j+1)
             temp(j+1) = tmp
          end if
       end do
    end do

    ! Copia os três primeiros ou menos
    top_scores = 0
    do i = 1, min(3,n)
       top_scores(i) = temp(i)
    end do
  end function personalTopThree

end module high_scores
