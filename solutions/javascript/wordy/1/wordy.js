const OPS = {
    'What is': '',
    'plus': '+',
    'minus': '-',
    'multiplied by': '*',
    'divided by': '/',
    '?': ''
}
const notNumber = word => isNaN(Number(word)),
    notOp = word => '+-*/'.indexOf(word) === -1,
    odd = (_, i) => i % 2

export function answer(question) {
    let words = question.replace(/What is|plus|minus|multiplied by|divided by|\?/g, w => OPS[w])
        .split(' ')
        .filter(word => word)

    switch (true) {
        case words.filter(notNumber).some(notOp):
            throw Error('Unknown operation')
        case words.length % 2 === 0 || !words.filter(odd).every(notNumber):
            throw Error('Syntax error')
    }

    while (words.length > 1) {
        words = [calculate(...words.slice(0, 3)), ...words.slice(3)]
    }

    return Number(words[0])
}

function calculate(a, op, b) {
    a = Number(a)
    b = Number(b)
    switch (op) {
        case '+':
            return a + b
        case '-':
            return a - b
        case '*':
            return a * b
        case '/':
            return a / b
    }
}