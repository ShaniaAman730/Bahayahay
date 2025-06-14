document.addEventListener('DOMContentLoaded', () => {
  const notice = document.querySelector('[data-notice]');
  if (notice) {
    notice.style.display = 'block';
    setTimeout(() => {
      notice.style.display = 'none';
    }, 3000); // Hide after 3 seconds
  }
});
