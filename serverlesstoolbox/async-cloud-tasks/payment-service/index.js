const express = require('express');
const bodyParser = require('body-parser');
const app = express();
app.use(bodyParser.json());
const port = process.env.PORT || 8080;
app.listen(port, () => {
  console.log('Listening on port', port);
});

app.post('/', async (req, res) => {
  const order = req.body;
  console.log(`Process payment for ${order.id}`);
  res.status(204).send();
})
