module protein_translation
  implicit none

contains

  function proteins(rna) result(names)
    character(len=*), intent(in) :: rna
    character(len=13), allocatable :: names(:)

    integer :: i, n, count
    character(len=3) :: codon

    ! First pass: count valid codons before STOP
    n = 0
    do i = 1, len_trim(rna), 3
      if (i+2 > len_trim(rna)) exit   ! ignore incomplete codon
      codon = rna(i:i+2)
      select case(codon)
      case("UAA", "UAG", "UGA")
        exit   ! stop codon terminates translation
      case("AUG", "UUU", "UUC", "UUA", "UUG", &
           "UCU", "UCC", "UCA", "UCG", "UAU", "UAC", &
           "UGU", "UGC", "UGG")
        n = n + 1
      case default
        ! invalid codon – stop (or ignore; here we stop for safety)
        exit
      end select
    end do

    ! Allocate result array
    allocate(names(n))

    ! Second pass: fill protein names
    count = 0
    do i = 1, len_trim(rna), 3
      if (i+2 > len_trim(rna)) exit
      codon = rna(i:i+2)
      select case(codon)
      case("AUG")
        count = count + 1
        names(count) = "Methionine"
      case("UUU", "UUC")
        count = count + 1
        names(count) = "Phenylalanine"
      case("UUA", "UUG")
        count = count + 1
        names(count) = "Leucine"
      case("UCU", "UCC", "UCA", "UCG")
        count = count + 1
        names(count) = "Serine"
      case("UAU", "UAC")
        count = count + 1
        names(count) = "Tyrosine"
      case("UGU", "UGC")
        count = count + 1
        names(count) = "Cysteine"
      case("UGG")
        count = count + 1
        names(count) = "Tryptophan"
      case("UAA", "UAG", "UGA")
        exit
      case default
        exit
      end select
    end do
  end function proteins

end module protein_translation