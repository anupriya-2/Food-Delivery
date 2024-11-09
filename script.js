// Basic category click event
document.querySelectorAll('.category').forEach(category => {
    category.addEventListener('click', () => {
        alert(`Searching for ${category.textContent}...`);
    });
});

// Search bar functionality
document.querySelector('.search input').addEventListener('keypress', (e) => {
    if (e.key === 'Enter') {
        alert(`Searching for "${e.target.value}"`);
    }
});
