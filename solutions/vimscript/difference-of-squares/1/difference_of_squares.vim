"
" Find the difference between the square of the sum and the sum of the squares
" of the first N natural numbers.
"
" Examples:
"
"   :echo SquareOfSum(3)
"   36
"   :echo SumOfSquares(3)
"   14
"   :echo DifferenceOfSquares(3)
"   22
"

" Sum of first N natural numbers: N*(N+1)/2
" Square of sum: [N*(N+1)/2]^2
function! SquareOfSum(number) abort
  let sum = a:number * (a:number + 1) / 2
  return sum * sum
endfunction

" Sum of squares of first N natural numbers: N*(N+1)*(2N+1)/6
function! SumOfSquares(number) abort
  return a:number * (a:number + 1) * (2 * a:number + 1) / 6
endfunction

" Difference = SquareOfSum - SumOfSquares
function! DifferenceOfSquares(number) abort
  return SquareOfSum(a:number) - SumOfSquares(a:number)
endfunction