# Reference: Mobile App Backends & Services (2026)

> Last research update: 2026-07-09
> Always verify pricing and limits at official docs.

---

## 1. Firebase (Mobile Focus)

**Category:** Managed Mobile-first BaaS (Google Cloud ecosystem)  
**Website:** firebase.google.com  
**Best for:** Mobile apps built with React Native, Flutter, Swift, or Kotlin. Industry standard for push notifications and sync.

### Pricing (2026)
- **Spark Plan (Free):** Generous free quotas for Firestore database (50,000 reads, 20,000 writes/day), Firebase Auth (10,000 monthly verifications), and Cloud Storage (5GB).
- **Blaze Plan (Pay-as-you-go):** Billed based on exact reads, writes, compute time, and egress.
- **FCM (Firebase Cloud Messaging):** 100% Free and unlimited for mobile push notifications.

### Capabilities
- **Firestore Database:** NoSQL document database with offline caching support built natively into the mobile SDKs.
- **Firebase Cloud Messaging (FCM):** Sends push notifications to iOS and Android devices globally.
- **Analytics & Crashlytics:** Free real-time crash reporting and user event analytics.
- **App Distribution:** Free staging and testing distributions for iOS/Android builds.

### Limitations & Gotchas
- **Complex Query Limits:** Firestore does not support complex relation joins or relational data integrity natively.
- **NoSQL Lock-in:** Migrating off Firestore is highly manual and requires rewriting data schemas.

---

## 2. Expo Application Services (EAS)

**Category:** Native Mobile CI/CD & OTA Updates  
**Website:** expo.dev  
**Best for:** React Native apps utilizing the Expo framework.

### Pricing (2026)
Expo charges for cloud-hosted builds and Over-The-Air (OTA) updates. Local builds are always free.

| Tier | Price (Monthly) | Build Credits | EAS Update MAUs | Overages |
|---|---|---|---|---|
| **Free** | $0 | 15 Android + 15 iOS builds | 1,000 MAUs | N/A |
| **Starter** | $19 | $45 build credits | 3,000 MAUs | $0.10/GiB bandwidth |
| **Production** | $199 | $225 build credits | 50,000 MAUs | $0.05/GiB storage |

### Capabilities
- **EAS Build:** Builds iOS (`.ipa`) and Android (`.apk`/`.aab`) binaries in the cloud without needing a local macOS machine.
- **EAS Update (OTA):** Push JavaScript bundles directly to users' phones without submitting a new version to the Apple App Store or Google Play Store.
- **EAS Submit:** Automatically submits built binaries directly to App Store Connect and Google Play Console.

### Limitations & Gotchas
- **Build Timeouts:** The Free plan builds are low priority and timeout after 45 minutes. Paid plans have a 2-hour timeout.
- **Update Bandwidth Overages:** Global edge bandwidth overages can pile up fast if you deploy large asset updates to millions of active users.

---

## 3. OneSignal

**Category:** Cross-channel Customer Messaging Platform  
**Website:** onesignal.com  
**Best for:** Push notifications, transactional emails, and in-app message triggers.

### Pricing (2026)
- **Free Plan:** 
  - **Mobile Push:** Unlimited subscribers/sends (no MAU fees).
  - **Web Push:** Up to 10,000 subscribers.
  - **Email Sends:** Up to 10,000 sends per month.
  - **In-App Messaging:** 1 active message.
  - **API Rate Limit:** 150 requests per second.
- **Growth Plan ($19/mo base + usage):** Increases API rate limit to 6,000/sec, removes subscriber caps, and unlocks advanced segmentations.

### Capabilities
- **Cross-Channel Journeys:** Build automated messaging sequences (e.g. Email → 2 days wait → Mobile Push).
- **iOS Live Activities:** Supports real-time dynamic widget updates on iOS lock screens.
- **A/B Testing:** Automatic split testing for click-through rates.

### Limitations & Gotchas
- **Free Tier Rate Limits:** Peak notifications may take longer to deliver on the Free plan due to the 150 req/sec limit.
- **Data Retention:** Free plan retention is limited compared to paid tiers.
