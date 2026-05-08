const msg = document.querySelector('.msg');

document.querySelectorAll(".controls").forEach(control => {
  const row = control.closest(".row");
  const input = control.querySelector(".amount");
  const quantity = row.children[2];

  input.addEventListener("keydown", (e) => {
    if (e.key === "Enter") {
      let change = parseInt(input.value) || 0;
      let current = parseInt(quantity.textContent);

      let newQuantity = Math.max(0, current + change);
      quantity.textContent = newQuantity;


      if (newQuantity <= 5) {
        row.classList.add('lowQuantity');
        msg.innerHTML = 'Low Quantity Detected'
      }else{
        row.classList.remove('lowQuantity');
        msg.innerHTML = '';
      }

      input.value = 0; 
    }
  });
});



 

