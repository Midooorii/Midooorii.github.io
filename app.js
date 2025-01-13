// Sélectionner tous les carrousels
document.querySelectorAll('.carousel').forEach(carousel => {
    let currentSlide = 0; // L'index du slide courant pour ce carrousel
    const slides = carousel.querySelectorAll('.slide'); // Sélectionne les slides pour ce carrousel
    const prevButton = carousel.querySelector('.prev'); // Bouton précédent
    const nextButton = carousel.querySelector('.next'); // Bouton suivant

    // Fonction pour afficher le slide correspondant
    function showSlide(index) {
        slides.forEach((slide, i) => {
            slide.classList.remove('active'); // Cache tous les slides
            if (i === index) {
                slide.classList.add('active'); // Montre le slide actif
            }
        });
    }

    // Fonction pour passer au slide suivant
    function nextSlide() {
        currentSlide = (currentSlide + 1) % slides.length; // Boucle à la fin
        showSlide(currentSlide);
    }

    // Fonction pour revenir au slide précédent
    function prevSlide() {
        currentSlide = (currentSlide - 1 + slides.length) % slides.length; // Boucle au début
        showSlide(currentSlide);
    }

    // Ajouter des écouteurs d'événements pour les boutons
    prevButton.addEventListener('click', prevSlide);
    nextButton.addEventListener('click', nextSlide);
});

