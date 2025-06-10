    <!-- Gallery -->
    <script>
      document.addEventListener("DOMContentLoaded", function () {
        const modal = document.getElementById("galleryModal");
        const modalImg = document.getElementById("modalImage");
        const images = document.querySelectorAll(".image-gallery img");

        let currentIndex = 0;

        images.forEach((img, index) => {
          img.addEventListener("click", () => {
            currentIndex = index;
            modalImg.src = img.src;
            modal.style.display = "flex";
          });
        });

        window.changeImage = function (delta) {
          currentIndex = (currentIndex + delta + images.length) % images.length;
          modalImg.src = images[currentIndex].src;
        };

        window.closeModal = function () {
          modal.style.display = "none";
        };
      });
    </script>