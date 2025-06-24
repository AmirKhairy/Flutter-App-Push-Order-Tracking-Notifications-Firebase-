// index.js
const express = require("express");
const bodyParser = require("body-parser");
const axios = require("axios"); // ✅ استخدم axios بدل fetch
const { GoogleAuth } = require("google-auth-library");
const serviceAccount = require("./firebase-service-account.json");

const app = express();
app.use(bodyParser.json());

const PROJECT_ID = serviceAccount.project_id;
const MESSAGING_SCOPE = "https://www.googleapis.com/auth/firebase.messaging";
const FCM_ENDPOINT = `https://fcm.googleapis.com/v1/projects/${PROJECT_ID}/messages:send`;

const getAccessToken = async () => {
    const auth = new GoogleAuth({
        credentials: serviceAccount,
        scopes: [MESSAGING_SCOPE],
    });
    const client = await auth.getClient();
    const accessTokenResponse = await client.getAccessToken();
    return accessTokenResponse.token;
};

app.post("/send-notification", async (req, res) => {
    const { title, body, image, fcmToken } = req.body;

    const message = {
        message: {
            token: fcmToken,
            notification: {
                title,
                body,
            },
            android: {
                notification: {
                    image,
                },
            },
            data: {
                click_action: "FLUTTER_NOTIFICATION_CLICK",
            },
        },
    };

    try {
        const accessToken = await getAccessToken();

        const response = await axios.post(FCM_ENDPOINT, message, {
            headers: {
                Authorization: `Bearer ${accessToken}`,
                "Content-Type": "application/json",
            },
        });

        res.status(200).json(response.data);
    } catch (error) {
        console.error("❌ Error sending notification:", error?.response?.data || error.message);
        res.status(500).json({ error: "Failed to send notification" });
    }
});

const PORT = 3000;
app.listen(PORT, () => {
    console.log(`🚀 Server listening on port ${PORT}`);
});