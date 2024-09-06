// app/javascript/controllers/product_quantity_controller.js
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["quantity", "total"]

  connect() {
    alert("Hello")
  }
  
  calculateTotal(event) {
    const button = event.currentTarget
    alert(button)
    const productPrice = parseFloat(button.dataset.productPrice)
    const quantityInput = button.closest("tr").querySelector(".quantity-input")
    const quantity = parseInt(quantityInput.value) || 0
    const total = productPrice * quantity
    alert("Hello")
    const totalElement = span.closest("tr").querySelector(".total-sell-line")
    totalElement.textContent = total.toFixed(2) + "€"
  }
}
