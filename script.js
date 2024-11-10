// // script.js

// // Function to handle Add to Cart button clicks
// document.querySelectorAll('.menu-card form').forEach(form => {
//     form.addEventListener('submit', function (e) {
//         e.preventDefault(); // Prevent form submission
        
//         // Get the menu item ID and trigger an "added to cart" alert
//         const menuItemId = this.querySelector('input[name="menu_item_id"]').value;
//         addToCart(menuItemId);
//     });
// });

// // script.js


// // Function to simulate adding an item to the cart
// function addToCart(itemId) {
//     // For now, we simply log the item to the console (can be replaced with actual cart logic)
//     console.log(`Item with ID: ${itemId} added to cart.`);
    
//     // Display a success message or alert
//     const successMessage = document.createElement('div');
//     successMessage.classList.add('success-message');
//     successMessage.innerHTML = `<p>Item successfully added to your cart!</p>`;
    
//     document.body.appendChild(successMessage);
    
//     // Automatically remove success message after 3 seconds
//     setTimeout(() => {
//         successMessage.remove();
//     }, 3000);
// }

// // Function to show/hide the search bar based on user interaction
// document.querySelector('.search input').addEventListener('focus', function () {
//     this.style.borderColor = '#333'; // Highlight search bar when focused
// });
// document.querySelector('.search input').addEventListener('blur', function () {
//     this.style.borderColor = '#ddd'; // Reset border when focus is lost
// });

// // Optional: Smooth scrolling to the top of the page
// document.querySelector('header .logo').addEventListener('click', function () {
//     window.scrollTo({ top: 0, behavior: 'smooth' });
// });
