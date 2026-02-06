//
// This is only a SKELETON file for the 'Grade School' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export class GradeSchool {
  constructor () {
    this.grades = {}
  }

  add (name, number) {
    console.log('add',Object.values(this.grades))
    let doesExist = Object.values(this.grades).some((students) => {
      return students.includes(name)
    })

    if (doesExist) return false

    if (!this.grades[number]) {
      this.grades[number] = []
    }
    
      this.grades[number].push(name)
      this.grades[number].sort()
      return true
  }
  
  roster() {
    return Object.values(this.grades).flat()
  }

  grade(number) {
    if (!this.grades[number]) {
      return []
    }
    return this.grades[number]
  }
}
