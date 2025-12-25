const express = require('express');
const cors = require('cors');
const { PredictionServiceClient } = require('@google-cloud/aiplatform');

const app = express();
const port = process.env.PORT || 8080;

// Initialize Vertex AI Prediction Service Client
const client = new PredictionServiceClient();

// Replace the model initialization logic
let modelEndpoint = process.env.MODEL_ENDPOINT || 'gemini-2.0-flash'; // Ensure you set this environment variable to your model endpoint

// Configure CORS
const corsOptions = {
  origin: process.env.CORS_ALLOWED_ORIGIN || '*', // Default to allow all origins if not set
};
app.use(cors(corsOptions));

// Middleware to parse JSON payloads
app.use(express.json());

app.get('/', async (req, res) => {
  res.status(200).json({ message: 'Health check successful', request: req.body });
});

app.post('/', async (req, res) => {
  try {
    const jsonPayload = req.body;

    const [response] = await client.predict({
      endpoint: modelEndpoint,
      instances: [{ content: jsonPayload.message }],
    });

    const responseText = response.predictions[0].content;

    res.status(200).json({ reply: responseText, request: jsonPayload });
  } catch (error) {
    console.error('Error generating content:', error);
    res.status(500).send('Error generating content');
  }
});

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
