document.addEventListener("turbo:load", () => {
  const toggleFilterButton = document.getElementById("toggleFilterButton");
  const filterForm = document.getElementById("filterForm");

  if (toggleFilterButton) {
    toggleFilterButton.addEventListener("click", () => {
      if (filterForm.style.display === "none") {
        filterForm.style.display = "block";
      } else {
        filterForm.style.display = "none";
      }
    });
  }

  const addProductButton = document.getElementById("add-product-button");
  const buyLinesContainer = document.getElementById("buy-lines-container");
  const totalBuyElement = document.getElementById("total-buy");

  if (addProductButton) {
    addProductButton.addEventListener("click", () => {
      const productModal = new bootstrap.Modal(document.getElementById("productModal"));
      productModal.show();
    });
  }

  if (buyLinesContainer) {
    buyLinesContainer.addEventListener("change", (event) => {
      if (event.target.matches(".buy-line-fields input, .buy-line-fields select")) {
        updateTotalBuyLine(event.target.closest(".buy-line-fields"));
        updateTotalBuy();
      }
    });

    buyLinesContainer.addEventListener("click", (event) => {
      if (event.target.matches(".remove-buy-line")) {
        event.preventDefault();
        event.target.closest(".buy-line-fields").remove();
        updateTotalBuy();
      }
    });
  }

  document.querySelectorAll(".select-product").forEach(button => {
    button.addEventListener("click", (event) => {
      const productId = event.target.getAttribute("data-product-id");
      const productName = event.target.getAttribute("data-product-name");
      const productPrice = event.target.getAttribute("data-product-price");

      const newBuyLine = document.createElement("div");
      newBuyLine.classList.add("buy-line-fields");
      newBuyLine.innerHTML = `
        <div class="row mb-3">
          <div class="col">
            <input type="hidden" name="buy[buy_lines_attributes][][id]">
            <input type="hidden" name="buy[buy_lines_attributes][][product_id]" value="${productId}">
            <input type="text" class="form-control" value="${productName}" readonly>
          </div>
          <div class="col">
            <input type="number" name="buy[buy_lines_attributes][][product_quantity]" class="form-control" min="0" value="1">
          </div>
          <div class="col">
            <input type="number" name="buy[buy_lines_attributes][][total_buy_line]" class="form-control" readonly value="${productPrice}">
          </div>
          <div class="col">
            <button type="button" class="btn btn-danger remove-buy-line">Remove</button>
          </div>
        </div>
      `;
      buyLinesContainer.appendChild(newBuyLine);
      updateTotalBuy();
    });
  });

  function updateTotalBuyLine(buyLineFields) {
    const quantityInput = buyLineFields.querySelector("input[name*='product_quantity']");
    const totalBuyLineInput = buyLineFields.querySelector("input[name*='total_buy_line']");
    const productPrice = parseFloat(buyLineFields.querySelector(".select-product").getAttribute("data-product-price"));

    const quantity = parseFloat(quantityInput.value);
    const total = quantity * productPrice;
    totalBuyLineInput.value = total.toFixed(2);
  }

  function updateTotalBuy() {
    let totalBuy = 0;
    document.querySelectorAll(".buy-line-fields input[name*='total_buy_line']").forEach(input => {
      totalBuy += parseFloat(input.value);
    });
    totalBuyElement.textContent = totalBuy.toFixed(2);
  }
});