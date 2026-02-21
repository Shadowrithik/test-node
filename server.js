// server.js
const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

app.get('/', (req, res) => {
    res.status(200).json({ 
        message: "Hello from Monolith!", 
        status: "Healthy" 
    });
});

// Export the app for testing purposes, but only listen if run directly
if (require.main === module) {
    app.listen(PORT, () => {
        console.log(`Server running on http://localhost:${PORT}`);
    });
}

module.exports = app;