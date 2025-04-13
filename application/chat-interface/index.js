const express = require('express');
const cors = require('cors');
const app = express();
const port = process.env.PORT || 8080;

// Configure CORS
const corsOptions = {
  origin: process.env.CORS_ALLOWED_ORIGIN || '*', // Default to allow all origins if not set
};
app.use(cors(corsOptions));

app.get('/', (req, res) => {
  res.status(200).send('Hello World It Really Works!');
});

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
