//
// This is only a SKELETON file for the 'List Ops' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export class List {
  constructor(values = []) {
    this.values = values
  }

  append(newData) {
    newData.values.forEach((e) => this.values.push(e))
    return this
  }

  concat(newList) {
    newList.values.forEach((e) => this.append(e))
    return this
  }

  filter(filterFn) {
    if (this.values == []) {
      return this
    }
    this.values = this.values.filter(filterFn)
    return this 
  }

  map(mapFn) {
    this.values = this.values.map(mapFn)
    return this
  }

  length() {
    return this.values.length
  }

  foldl(reductorFn, initialValue) {
    return this.values.reduce(reductorFn, initialValue)
  }

  foldr(reductorFn, initialValue) {
    return this.values.reduceRight(reductorFn, initialValue)
  }

  reverse() {
    this.values = this.values.reverse()
    return this
  }
}
