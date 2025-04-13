class AIChatInterface extends HTMLElement {
  constructor() {
    super();
    this.attachShadow({ mode: 'open' });
  }

  connectedCallback() {
    this.render();
    this.fetchChatResponse();
  }

  render() {
    this.shadowRoot.innerHTML = `
      <style>
        .container {
          font-family: Arial, sans-serif;
          padding: 10px;
          border: 1px solid #ccc;
          border-radius: 5px;
          max-width: 300px;
        }
        .message {
          margin-bottom: 10px;
        }
        .response {
          color: blue;
        }
      </style>
      <div class="container">
        <div class="message">Welcome to AI Chat Interface!</div>
        <div class="response">Loading response...</div>
      </div>
    `;
  }

  async fetchChatResponse() {
    try {
      const response = await fetch('https://chat-service-71966184676.us-central1.run.app/'); // Replace with actual URL
      const data = await response.text();
      this.shadowRoot.querySelector('.response').textContent = data;
    } catch (error) {
      this.shadowRoot.querySelector('.response').textContent = 'Failed to fetch response.';
      console.error('Error fetching chat response:', error);
    }
  }
}

customElements.define('ai-chat-interface', AIChatInterface);
