const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

// Root route
app.get('/', (req, res) => {
    res.status(200).json({ 
        message: "Hello from Monolith!", 
        status: "Healthy" 
    });
});

// ADDED: Health check endpoint to match health-check.sh
app.get('/health', (req, res) => {
    res.status(200).json({ 
        status: "UP",
        timestamp: new Date().toISOString()
    });
});

// Export for testing, but only listen if run directly
if (require.main === module) {
    app.listen(PORT, () => {
        console.log(`Server running on http://localhost:${PORT}`);
    });
}

module.exports = app;