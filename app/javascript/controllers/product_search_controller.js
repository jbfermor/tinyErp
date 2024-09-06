// app/javascript/controllers/product_search_controller.js
import { Controller } from "stimulus"

export default class extends Controller {
  filter(event) {
    const filterText = event.target.value.toLowerCase()
    const rows = document.querySelectorAll("#productsTable tbody tr")
    rows.forEach(row => {
      const productName = row.querySelector("td").textContent.toLowerCase()
      if (productName.includes(filterText)) {
        row.style.display = ""
      } else {
        row.style.display = "none"
      }
    })
  }
}
