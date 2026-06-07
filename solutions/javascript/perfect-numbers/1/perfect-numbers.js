export const classify = (num) => {
  if (num <= 0) {
    throw new Error('Classification is only possible for natural numbers.');
  }

  let aliquotSum = 0;

  for (let i = 1; i * i <= num; i++) {
    if (num % i === 0) {
      if (i !== num) {
        aliquotSum += i;
      }
      const j = num / i;
      if (j !== i && j !== num) {
        aliquotSum += j;
      }
    }
  }

  if (aliquotSum === num) return 'perfect';
  if (aliquotSum > num) return 'abundant';
  return 'deficient';
};