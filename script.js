
// Countdown to launch: Jan 1, 2026
const launchDate = new Date("2026-01-01T00:00:00Z").getTime();

const daysEl = document.getElementById("days");
const hoursEl = document.getElementById("hours");
const minutesEl = document.getElementById("minutes");
const secondsEl = document.getElementById("seconds");

function updateCountdown() {
  const now = new Date().getTime();
  const distance = launchDate - now;

  if (distance <= 0) {
    daysEl.textContent = "00";
    hoursEl.textContent = "00";
    minutesEl.textContent = "00";
    secondsEl.textContent = "00";
    return;
  }

  const days = Math.floor(distance / (1000 * 60 * 60 * 24));
  const hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
  const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
  const seconds = Math.floor((distance % (1000 * 60)) / 1000);

  daysEl.textContent = String(days).padStart(2, "0");
  hoursEl.textContent = String(hours).padStart(2, "0");
  minutesEl.textContent = String(minutes).padStart(2, "0");
  secondsEl.textContent = String(seconds).padStart(2, "0");
}

updateCountdown();
setInterval(updateCountdown, 1000);

// Email "notify me" form (front-end only demo — no backend wired up)
const form = document.getElementById("notify-form");
const confirmMsg = document.getElementById("confirm-msg");
const emailInput = document.getElementById("email");

form.addEventListener("submit", function (e) {
  e.preventDefault();
  const email = emailInput.value.trim();

  if (!email) return;

  confirmMsg.textContent = `🎉 Thanks! We'll email ${email} when "Set Sail: Cruise Line" launches in 2026.`;
  emailInput.value = "";

  // Optional: store locally so it persists across refreshes on this device
  const saved = JSON.parse(localStorage.getItem("cruiseLineSignups") || "[]");
  saved.push({ email, date: new Date().toISOString() });
  localStorage.setItem("cruiseLineSignups", JSON.stringify(saved));
});

// Randomize ship animation duration slightly for a natural feel
const ship = document.getElementById("ship");
if (ship) {
  ship.style.animationDuration = `${3 + Math.random()}s, ${20 + Math.random() * 10}s`;
}
