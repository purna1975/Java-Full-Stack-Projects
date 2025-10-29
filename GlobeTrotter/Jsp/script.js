// Smooth scrolling for navigation links
document.querySelectorAll('a[href^="#"]').forEach((anchor) => {
  anchor.addEventListener("click", function (e) {
    e.preventDefault()

    document.querySelector(this.getAttribute("href")).scrollIntoView({
      behavior: "smooth",
    })
  })
})

// Navbar color change on scroll
window.addEventListener("scroll", () => {
  if (window.scrollY > 50) {
    document.querySelector(".navbar").classList.add("bg-dark")
    document.querySelector(".navbar").classList.remove("bg-primary")
  } else {
    document.querySelector(".navbar").classList.add("bg-primary")
    document.querySelector(".navbar").classList.remove("bg-dark")
  }
})

// Form validation for registration
document.querySelector("#registerModal form").addEventListener("submit", (e) => {
  const password = document.querySelector("#registerPassword").value
  const confirmPassword = document.querySelector("#registerConfirmPassword").value

  if (password !== confirmPassword) {
    e.preventDefault()
    alert("Passwords do not match!")
  }
})

// Display success message after form submission
const urlParams = new URLSearchParams(window.location.search)
const successMessage = urlParams.get("success")
if (successMessage) {
  alert(decodeURIComponent(successMessage))
}

// Animate wonder cards on scroll
const wonderCards = document.querySelectorAll(".wonder-card")
const observerOptions = {
  root: null,
  rootMargin: "0px",
  threshold: 0.1,
}

const observer = new IntersectionObserver((entries, observer) => {
  entries.forEach((entry) => {
    if (entry.isIntersecting) {
      entry.target.classList.add("animate__animated", "animate__fadeInUp")
      observer.unobserve(entry.target)
    }
  })
}, observerOptions)

wonderCards.forEach((card) => {
  observer.observe(card)
})

// Initialize tooltips
// Import bootstrap here if not already imported.  For example:
// import * as bootstrap from 'bootstrap';  // Adjust path as needed.
var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
var tooltipList = tooltipTriggerList.map((tooltipTriggerEl) => new bootstrap.Tooltip(tooltipTriggerEl))
