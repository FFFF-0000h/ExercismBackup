module allergies
  implicit none

  character(len=16), dimension(8) :: allergens = [character(len=16) :: &
  'eggs', 'peanuts', 'shellfish', 'strawberries', 'tomatoes', 'chocolate', 'pollen', 'cats']

contains

  logical function allergicTo(allergy_str, allergy_key)
    character(len=*), intent(in) :: allergy_str
    integer, intent(in) :: allergy_key
    
    integer :: allergen_loc

    allergen_loc = findloc(allergens, allergy_str, 1) - 1 ! first element is 2^0
    allergicTo = iand(allergy_key, 2 ** allergen_loc) > 0
  end function


  function allergicList(allergy_key)
    integer, intent(in) :: allergy_key
    character(len=100) :: allergicList

    integer :: i

    allergicList = ''

    do i = 1, size(allergens)
      if (allergicTo(allergens(i), allergy_key)) then
        allergicList = trim(allergicList)//' '//allergens(i)
      end if
    end do
    allergicList = adjustl(allergicList)
  end function

  

end module
