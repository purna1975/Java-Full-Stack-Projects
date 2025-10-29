document.addEventListener("DOMContentLoaded", () => {
  const registerForm = document.getElementById("registerForm")
  if (registerForm) {
    registerForm.addEventListener("submit", function (e) {
      e.preventDefault()

      // Basic validation
      const password = document.getElementById("password").value
      const cpassword = document.getElementById("cpassword").value

      if (password !== cpassword) {
        showError("Passwords do not match!")
        return
      }

      // If validation passes, submit the form
      this.submit()
    })
  }

  // Handle URL parameters for error messages
  const urlParams = new URLSearchParams(window.location.search)
  const error = urlParams.get("error")
  const success = urlParams.get("success")

  if (error) {
    let message = ""
    switch (error) {
      case "missing_fields":
        message = "Please fill in all required fields."
        break
      case "password_mismatch":
        message = "Passwords do not match."
        break
      case "db_error":
        message = "Database error occurred. Please try again."
        break
      case "server_error":
        message = "Server error occurred. Please try again."
        break
      default:
        message = "An error occurred. Please try again."
    }
    showError(message)
  }

  if (success === "true") {
    showSuccess("Registration successful!")
  }

  // Cuisine filter functionality
  const cuisineFilters = document.querySelectorAll(".cuisine-filter")
  const restaurantItems = document.querySelectorAll(".restaurant-item")

  cuisineFilters.forEach((filter) => {
    filter.addEventListener("click", function (e) {
      e.preventDefault()
      const selectedCuisine = this.getAttribute("data-cuisine")

      restaurantItems.forEach((item) => {
        if (selectedCuisine === "all" || item.getAttribute("data-cuisine") === selectedCuisine) {
          item.style.display = "block"
          setTimeout(() => {
            item.classList.remove("hidden")
          }, 10)
        } else {
          item.classList.add("hidden")
          setTimeout(() => {
            item.style.display = "none"
          }, 300)
        }
      })

      // Update active state of filter buttons
      cuisineFilters.forEach((btn) => btn.classList.remove("active"))
      this.classList.add("active")
    })
  })

  // Navbar scroll effect
  const navbar = document.querySelector(".navbar")
  window.addEventListener("scroll", () => {
    if (window.scrollY > 50) {
      navbar.classList.add("navbar-scrolled")
    } else {
      navbar.classList.remove("navbar-scrolled")
    }
  })

  // Search functionality
  const searchInput = document.getElementById("searchInput")
  const searchButton = searchInput.nextElementSibling

  function performSearch() {
    const searchTerm = searchInput.value.toLowerCase()
    restaurantItems.forEach((item) => {
      const restaurantName = item.querySelector(".card-title").textContent.toLowerCase()
      const cuisineType = item.querySelector(".cuisine-type").textContent.toLowerCase()
      if (restaurantName.includes(searchTerm) || cuisineType.includes(searchTerm)) {
        item.style.display = "block"
        setTimeout(() => {
          item.classList.remove("hidden")
        }, 10)
      } else {
        item.classList.add("hidden")
        setTimeout(() => {
          item.style.display = "none"
        }, 300)
      }
    })
  }

  searchButton.addEventListener("click", performSearch)
  searchInput.addEventListener("keyup", (e) => {
    if (e.key === "Enter") {
      performSearch()
    }
  })
})

function showError(message) {
  const errorDiv = document.getElementById("errorMessage")
  if (errorDiv) {
    errorDiv.textContent = message
    errorDiv.style.display = "block"
  }
}

function showSuccess(message) {
  const errorDiv = document.getElementById("errorMessage")
  if (errorDiv) {
    errorDiv.className = "alert alert-success"
    errorDiv.textContent = message
    errorDiv.style.display = "block"
  }
}

function togglePassword(inputId) {
  const passwordInput = document.getElementById(inputId)
  const toggleIcon = document.getElementById("toggleIcon" + inputId.charAt(0).toUpperCase() + inputId.slice(1))

  if (passwordInput.type === "password") {
    passwordInput.type = "text"
    toggleIcon.classList.replace("bi-eye", "bi-eye-slash")
  } else {
    passwordInput.type = "password"
    toggleIcon.classList.replace("bi-eye-slash", "bi-eye")
  }
}
