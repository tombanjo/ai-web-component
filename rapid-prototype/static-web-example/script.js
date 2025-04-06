document.addEventListener('DOMContentLoaded', () => {
    const textInput = document.getElementById('textInput');
    
    // Load saved text from localStorage if available
    const savedText = localStorage.getItem('editorText');
    if (savedText) {
        textInput.value = savedText;
    }
    
    // Save text to localStorage when it changes
    textInput.addEventListener('input', () => {
        localStorage.setItem('editorText', textInput.value);
    });
}); 