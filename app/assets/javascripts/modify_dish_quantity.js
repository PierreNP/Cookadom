function modifyDishQuantity() {
    var quantityBtns = document.querySelectorAll('i[data-quantity]')

    for (var i = 0; i < quantityBtns.length; i++) {
        quantityBtns[i].addEventListener("click", function() {
            quantityModifier = this.getAttribute('data-quantity')
            quantityInput = document.querySelector('.my-5 input[name="quantity"]')

            if (quantityModifier == 'add') {
                quantityInput.value = parseInt(quantityInput.value) + 1
            } else if (quantityModifier == 'remove' && quantityInput.value != 1) {
                quantityInput.value = parseInt(quantityInput.value) - 1
            }
        })
    }
}

window.addEventListener("DOMContentLoaded", function() {
    modifyDishQuantity()
});