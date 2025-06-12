const display = document.getElementById("display");
const buttons = document.querySelectorAll(".btn");

let currentInput = "";

buttons.forEach((button) => {
  button.addEventListener("click", () => {
    const value = button.textContent;

    if (button.classList.contains("number") || button.classList.contains("operator")) {
      currentInput += value === '^' ? '**' : value === "x" ? "*" : value === "÷" ? "/" : value === "%" ? "/100": value;
      display.textContent = currentInput;
    } else if (button.classList.contains("equal")) {
      try {
        currentInput = eval(currentInput).toString();
        display.textContent = currentInput;
      } catch (e) {
        display.textContent = "Error";
        currentInput = "";
      }
    } else if (button.id === "backspace") {
      currentInput = currentInput.slice(0, -1);
      display.textContent = currentInput;
    }
  });
});


// Keyboard input
document.addEventListener("keydown", (e) => {
  if ((e.key >= 0 && e.key <= 9) || ["+", "-", "*", "/", ".", "%"].includes(e.key)) {
    currentInput += e.key;
    display.textContent = currentInput;
  } else if (e.key === "Enter") {
    try {
      currentInput = eval(currentInput).toString();
      display.textContent = currentInput;
    } catch (e) {
      display.textContent = "Error";
      currentInput = "";
    }
  } else if (e.key === "Backspace") {
    currentInput = currentInput.slice(0, -1);
    display.textContent = currentInput;
  }
});
