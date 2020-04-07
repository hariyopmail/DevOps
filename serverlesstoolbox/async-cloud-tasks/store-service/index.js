// The ID of the project where the queue has been defined.
const PROJECT_ID = '';
// The location of the payment service, like us-central1.
const LOCATION = '';
// Deploy the payment service, capture its URL, and enter it below.
const PAYMENT_SERVICE_URL = 'https://payment-service...';
const QUEUE_NAME = 'payments';

const {v2beta3} = require('@google-cloud/tasks');
const client = new v2beta3.CloudTasksClient();

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
  order.id = generateOrderId();
  await callPaymentService(order);
  const retVal = {
    status: "success",
    order_id: order.id
  };
  res.json(retVal);
})

function generateOrderId() {
  return Math.floor(Math.random()*100000);
}

async function callPaymentService(order) {
  const task = {
    httpRequest: {
      url: PAYMENT_SERVICE_URL,
      body: encodePayload(order),
      httpMethod: 'POST',
      headers: {'content-type': 'application/json'},
      oidcToken: {
        serviceAccountEmail: 'tasks-cloud-run-invoker@serverless-toolbox.iam.gserviceaccount.com',
      }
    },
    scheduleTime: {
      seconds: Date.now() / 1000 + 10,
    }
  };
  const request = {
    parent: client.queuePath(PROJECT_ID, LOCATION, QUEUE_NAME),
    task: task,
  };
  const [response] = await client.createTask(request);
  console.log(`Created task for order ${order.id}`);
}

function encodePayload(payload) {
  return Buffer.from(
    JSON.stringify(payload)
  ).toString('base64');
}
