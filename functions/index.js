const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.scheduleMedicineReminder = functions.firestore
    .document("users/{userId}/MedicineReminder/{reminderId}")
    .onCreate(async (snapshot, context) => {
      const reminderData = snapshot.data();
      const userId = context.params.userId;
      const reminderTime = reminderData.reminderTime.toDate();

      // Calculate delay until the reminder time
      const delay = reminderTime - new Date();

      if (delay <= 0) {
        console.log("Reminder time is in the past");
        return null;
      }

      // Schedule the notification
      setTimeout(async () => {
        // Retrieve the user's FCM token
        const userDoc = await admin.firestore()
            .collection("users")
            .doc(userId)
            .get();
        const fcmToken = userDoc.data().fcmToken;

        if (fcmToken) {
          const message = {
            notification: {
              title: "Medicine Reminder",
              body:
              "It's time to take your ${reminderData.medicineName}.",
            },
            token: fcmToken,
          };

          try {
            const response = await admin.messaging().send(message);
            console.log("Successfully sent message:", response);
          } catch (error) {
            console.error("Error sending message:", error);
          }
        } else {
          console.log("No FCM token available");
        }
      }, delay);

      return null;
    });
