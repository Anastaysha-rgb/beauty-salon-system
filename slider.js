document.addEventListener('DOMContentLoaded', () => {
    const slides = document.querySelectorAll('.slide');
    const prevBtn = document.getElementById('prevBtn');
    const nextBtn = document.getElementById('nextBtn');
    let currentSlide = 0;
    let slideInterval;
    

    // Функция показа слайда
    function showSlide(index) {
        slides.forEach(slide => slide.classList.remove('active'));
        
        // Защита от выхода за границы
        if (index >= slides.length) currentSlide = 0;
        if (index < 0) currentSlide = slides.length - 1;
        
        slides[currentSlide].classList.add('active');
    }

    function nextSlide() {
        currentSlide++;
        showSlide(currentSlide);
    }

    function prevSlide() {
        currentSlide--;
        showSlide(currentSlide);
    }

    // Автопрокрутка (каждые 3000 мс = 3 секунды, как в ТЗ)
    function startSlideShow() {
        slideInterval = setInterval(nextSlide, 3000);
    }

    // Перезапуск таймера при клике (чтобы слайд не перелистнулся сразу после нажатия)
    function resetInterval() {
        clearInterval(slideInterval);
        startSlideShow();
    }

    // Слушатели кнопок
    nextBtn.addEventListener('click', () => {
        nextSlide();
        resetInterval();
    });

    prevBtn.addEventListener('click', () => {
        prevSlide();
        resetInterval();
    });

    // Запуск
    startSlideShow();
});