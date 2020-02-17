function bindSearch() {
    const form = document.getElementById('search-form');
    const inputs = form.querySelectorAll('input');
    const submitForm = debounce(form.submit.bind(form), 500)
    for(let i = 0; i < inputs.length; i++) {
        inputs[i].addEventListener('change', submitForm)
    }
};

function debounce(func, delay) {
    let clearTimer;
    return function() {
        const context = this;
        const args = arguments;
        clearTimeout(clearTimer);
        clearTimer = setTimeout(() => func.apply(context, args), delay);
    }
}