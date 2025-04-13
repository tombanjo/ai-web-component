class AIChatInterface extends HTMLElement {
  constructor() {
    super();
    this.attachShadow({ mode: 'open' });
    this._data = null; // Private property to store data
  }

  set data(value) {
    this._data = value;
    this.fetchChatResponse(); // Trigger fetchChatResponse when data is updated
  }

  get data() {
    return this._data;
  }

  connectedCallback() {
    this.render();
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
      const response = await fetch('https://chat-service-71966184676.us-central1.run.app/', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(this._data), // Send the updated data as JSON
      });
      const data = await response.text();
      this.shadowRoot.querySelector('.response').textContent = data;
    } catch (error) {
      this.shadowRoot.querySelector('.response').textContent = 'Failed to fetch response.';
      console.error('Error fetching chat response:', error);
    }
  }
}

customElements.define('ai-chat-interface', AIChatInterface);
