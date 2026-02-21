// test.js
const assert = require('assert');
const http = require('http');
const app = require('./server');

// Start the server on a test port
const server = app.listen(3001, () => {
    console.log("Running CI/CT/CD Test...");

    http.get('http://localhost:3001/', (res) => {
        let data = '';
        res.on('data', chunk => data += chunk);
        
        res.on('end', () => {
            try {
                // The Test: Check if the app returns HTTP 200
                assert.strictEqual(res.statusCode, 200, "App should return 200 OK");
                
                // The Test: Check if the response contains 'Monolith'
                const json = JSON.parse(data);
                assert.ok(json.message.includes('Monolith'), "Message should contain 'Monolith'");
                
                console.log("✅ All tests passed! Ready for deployment.");
                process.exit(0); // Exit 0 tells the CI/CD pipeline it was successful
            } catch (err) {
                console.error("❌ Test failed:", err.message);
                process.exit(1); // Exit 1 tells the CI/CD pipeline to ABORT deployment
            }
        });
    }).on('error', (err) => {
        console.error("❌ Server connection failed:", err.message);
        process.exit(1);
    });
});