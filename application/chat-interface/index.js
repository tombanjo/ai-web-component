const express = require('express');
const cors = require('cors');
const app = express();
const port = process.env.PORT || 8080;

// Configure CORS
const corsOptions = {
  origin: process.env.CORS_ALLOWED_ORIGIN || '*', // Default to allow all origins if not set
};
app.use(cors(corsOptions));

app.post('/', async (req, res) => {
  try {
    const chunks = [];
    for await (const chunk of req) {
      chunks.push(chunk);
    }
    const body = Buffer.concat(chunks).toString(); // Combine chunks and convert to string
    const jsonPayload = JSON.parse(body); // Parse JSON payload
    res.status(200).json(jsonPayload); // Echo back the JSON payload
  } catch (error) {
    res.status(400).send('Invalid JSON payload'); // Handle invalid JSON
  }
});

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
