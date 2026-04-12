/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */
/*
import { setGlobalOptions } from "firebase-functions";
// const {onRequest} = require("firebase-functions/https");
// const logger = require("firebase-functions/logger");

// For cost control, you can set the maximum number of containers that can be
// running at the same time. This helps mitigate the impact of unexpected
// traffic spikes by instead downgrading performance. This limit is a
// per-function limit. You can override the limit for each function using the
// `maxInstances` option in the function's options, e.g.
// `onRequest({ maxInstances: 5 }, (req, res) => { ... })`.
// NOTE: setGlobalOptions does not apply to functions using the v1 API. V1
// functions should each use functions.runWith({ maxInstances: 10 }) instead.
// In the v1 API, each function can only serve one request per container, so
// this will be the maximum concurrent request count.
setGlobalOptions({maxInstances: 10});

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });


// const SibApiV3Sdk = require('sib-api-v3-sdk');
// const defaultClient = SibApiV3Sdk.ApiClient.instance;
// const apiKey = process.env.BREVO_API_KEY;
import { https } from "firebase-functions";
import axios from "axios";
import { defineSecret } from "firebase-functions/params";
const BREVO_API_KEY = defineSecret("BREVO_API_KEY");

export const sendEmail = https.onCall({ secrets: [BREVO_API_KEY] }, 
    async (data) => {
  const {firstname, lastname, email, phone, subject, message} = data;

  const apiKey = BREVO_API_KEY.value();
  console.log("BREVO_API_KEY exists:", !!apiKey);
  try {
    const response = await axios.post(
        "https://api.brevo.com/v3/smtp/email",
        {
          sender: {
            name: "Amadou Dieng",
            email: "amadiengdieng@gmail.com",
          },
          to: [
            {
              email: email,
              name: lastname + " " + firstname || "User",
            },
          ],
          subject: subject + " " + phone,
          htmlContent: message,
        },
        {
          headers: {
            "api-key": apiKey,
            "content-type": "application/json",
            "accept": "application/json",
          },
        },
    );

    return {success: true, data: response.data};
  } catch (error) {
    
    return {success: false, error: error.message};
  }
});
*/

/**
 * Firebase Functions v2 + ESM (Node 18 / 20)
 */

import { setGlobalOptions } from "firebase-functions/v2";
import { onCall } from "firebase-functions/v2/https";
import { defineSecret } from "firebase-functions/params";
import axios from "axios";

setGlobalOptions({
  maxInstances: 10,
});

const BREVO_API_KEY = defineSecret("BREVO_API_KEY");

export const sendEmail = onCall(
  { secrets: [BREVO_API_KEY] },
  async (request) => {
    if(!request.auth){
        throw new HttpsError(
        "Non authentifié",
        "Vous devez etre enregistrer pour utiliser ce functionnalité"
      );

    }
    const { firstname, lastname, email, phone, subject, message } = request.data;

    const apiKey = BREVO_API_KEY.value();

    try {
      const response = await axios.post(
        "https://api.brevo.com/v3/smtp/email",
        {
          sender: {
            name: "Amadou Dieng",
            email: "amadiengdieng@gmail.com",
          },
          to: [
            {
              email,
              name: `${lastname} ${firstname}` || "User",
            },
          ],
          subject: `${subject} ${phone}`,
          htmlContent: message,
        },
        {
          headers: {
            "api-key": apiKey,
            "content-type": "application/json",
            accept: "application/json",
          },
        }
      );

      return { success: true, data: response.data };
    } catch (error) {
      console.error(error);
      return {
        success: false,
        error: error.message,
      };
    }
  }
);