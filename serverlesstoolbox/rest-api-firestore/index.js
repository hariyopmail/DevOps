const admin = require('firebase-admin');
const express = require('express');
const app = express();
const port = process.env.PORT || 8080;

admin.initializeApp({
    credential: admin.credential.applicationDefault()
});

/* 
The initializeApp function above will use the current project's Application Default
Credentials.  You can specify a different service account by providing the service
account key in a json file and initializing with that instead:
 
const serviceAccount = require('./barkbark-key.json');
admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
});

*/
const db = admin.firestore();

app.listen(port, () => {
    console.log('BarkBark Rest API listening on port', port);
});

async function getBreed(breed) {
    let dogsRef = db.collection("dogs");
    let response = await dogsRef.where("name", "==", breed).get();
    return response
}

app.get('/:breed', async (req, res) => {
    const breed = req.params.breed;
    const breedData = await getBreed(breed);
    let retVal;
    if (!breedData.empty) {
        retVal = breedData.docs.map(doc => {
            return { ...doc.data() }
        })
    } else {
        res.status(404);
        retVal = { status: 'fail', data: { title: `'${breed}' not found` } };
    }
    res.json(retVal)
})