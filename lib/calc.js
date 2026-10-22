// app/calculator.js

function calculate(expression) {
  if (!expression || typeof expression !== "string") {
    throw new Error("Expression must be a non-empty string");
  }

  const tokens = expression.trim().split(/\s+/).reverse();
  const stack = [];

  for (const token of tokens) {
    if (!isNaN(token)) {
      // Token is a number
      stack.push(Number(token));
    } else if (["+","-","*","/"].includes(token)) {
      // Token is an operator — pop two operands
      if (stack.length < 2) {
        throw new Error("Invalid expression: insufficient operands");
      }

      const a = stack.pop();
      const b = stack.pop();

      let value;
      switch (token) {
        case "+":
          value = a + b;
          break;
        case "-":
          value = a - b;
          break;
        case "*":
          value = a * b;
          break;
        case "/":
          value = a / b;
          break;
      }

      stack.push(value);

    } else {
      throw new Error(`Invalid token: ${token}`);
    }
  }

  if (stack.length !== 1) {
    throw new Error("Invalid expression");
  }

  return stack[0];
}

module.exports = { calculate };
